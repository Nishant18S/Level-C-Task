CREATE PROCEDURE scd_type_1
AS
BEGIN
    MERGE dim_customer AS target
    USING stg_customer AS source
    ON target.customer_id = source.customer_id
    WHEN MATCHED THEN
        UPDATE SET 
            name = source.name,
            address = source.address,
            phone = source.phone,
            effective_date = source.update_date
    WHEN NOT MATCHED THEN
        INSERT (customer_id, name, address, phone, effective_date, is_current)
        VALUES (source.customer_id, source.name, source.address, source.phone, source.update_date, 1);
END;
