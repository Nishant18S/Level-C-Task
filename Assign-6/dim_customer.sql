CREATE TABLE dim_customer (
    dim_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    name VARCHAR(100),
    address VARCHAR(255),
    phone VARCHAR(20),
    version INT DEFAULT 1,
    effective_date DATE,
    end_date DATE,
    is_current BIT DEFAULT 1,
    previous_address VARCHAR(255),      -- For SCD Type 3
    previous_name VARCHAR(100)          -- For SCD Type 6
);
