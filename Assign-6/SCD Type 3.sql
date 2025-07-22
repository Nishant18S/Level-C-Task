CREATE PROCEDURE scd_type_3
AS
BEGIN
    UPDATE d
    SET 
        previous_address = d.address,
        address = s.address,
        name = s.name,
        phone = s.phone,
        effective_date = s.update_date
    FROM dim_customer d
    JOIN stg_customer s ON d.customer_id = s.customer_id
    WHERE d.address <> s.address;

    INSERT INTO dim_customer (customer_id, name, address, phone, effective_date, is_current)
    SELECT s.customer_id, s.name, s.address, s.phone, s.update_date, 1
    FROM stg_customer s
    WHERE NOT EXISTS (
        SELECT 1 FROM dim_customer d WHERE d.customer_id = s.customer_id
    );
END;
