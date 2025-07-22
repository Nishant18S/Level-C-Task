CREATE TABLE dim_customer_history (
    dim_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    name VARCHAR(100),
    address VARCHAR(255),
    phone VARCHAR(20),
    version INT,
    effective_date DATE,
    end_date DATE,
    is_current BIT
);
