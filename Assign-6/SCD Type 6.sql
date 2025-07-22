CREATE PROCEDURE scd_type_6
AS
BEGIN
    DECLARE @customer_id INT, @name VARCHAR(100), @address VARCHAR(255), @phone VARCHAR(20), @update_date DATE;

    DECLARE cur CURSOR FOR 
        SELECT customer_id, name, address, phone, update_date FROM stg_customer;

    OPEN cur;
    FETCH NEXT FROM cur INTO @customer_id, @name, @address, @phone, @update_date;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF EXISTS (
            SELECT 1 FROM dim_customer 
            WHERE customer_id = @customer_id AND is_current = 1 AND 
                  (name <> @name OR address <> @address OR phone <> @phone)
        )
        BEGIN
            UPDATE dim_customer
            SET is_current = 0, end_date = @update_date
            WHERE customer_id = @customer_id AND is_current = 1;

            DECLARE @prev_name VARCHAR(100);
            SELECT TOP 1 @prev_name = name FROM dim_customer 
            WHERE customer_id = @customer_id ORDER BY version DESC;

            DECLARE @version INT = ISNULL((
                SELECT MAX(version) FROM dim_customer WHERE customer_id = @customer_id
            ), 0) + 1;

            INSERT INTO dim_customer (customer_id, name, address, phone, previous_name, version, effective_date, is_current)
            VALUES (@customer_id, @name, @address, @phone, @prev_name, @version, @update_date, 1);
        END
        ELSE IF NOT EXISTS (
            SELECT 1 FROM dim_customer WHERE customer_id = @customer_id
        )
        BEGIN
            INSERT INTO dim_customer (customer_id, name, address, phone, version, effective_date, is_current)
            VALUES (@customer_id, @name, @address, @phone, 1, @update_date, 1);
        END

        FETCH NEXT FROM cur INTO @customer_id, @name, @address, @phone, @update_date;
    END

    CLOSE cur;
    DEALLOCATE cur;
END;
