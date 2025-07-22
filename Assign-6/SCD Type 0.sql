CREATE PROCEDURE scd_type_0
AS
BEGIN
    INSERT INTO dim_customer (customer_id, name, address, phone, effective_date, is_current)
    SELECT s.customer_id, s.name, s.address, s.phone, s.update_date, 1
    FROM stg_customer s
    WHERE NOT EXISTS (
        SELECT 1 FROM dim_customer d WHERE d.customer_id = s.customer_id
    );
END;
