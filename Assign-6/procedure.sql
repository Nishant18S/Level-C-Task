CREATE PROCEDURE scd_type_4
AS
BEGIN
    INSERT INTO dim_customer_history
    SELECT * FROM dim_customer d
    JOIN stg_customer s ON d.customer_id = s.customer_id
    WHERE d.name <> s.name OR d.address <> s.address OR d.phone <> s.phone;

    UPDATE d
    SET 
        name = s.name,
        address = s.address,
        phone = s.phone,
        effective_date = s.update_date
    FROM dim_customer d
    JOIN stg_customer s ON d.customer_id = s.customer_id;

    INSERT INTO dim_customer (customer_id, name, address, phone, effective_date, is_current)
    SELECT s.customer_id, s.name, s.address, s.phone, s.update_date, 1
    FROM stg_customer s
    WHERE NOT EXISTS (
        SELECT 1 FROM dim_customer d WHERE d.customer_id = s.customer_id
    );
END;
