--Create the schema to hold all objects
CREATE SCHEMA purgoai;

--Create needed tables for the experiment
CREATE TABLE purgoai.dim_product (id int not null IDENTITY, name VARCHAR(500) not null, description varchar(500) not null, price NUMERIC(13,2) not null, primary key (id));
CREATE TABLE purgoai.fact_sales (id int not null IDENTITY, date DATE, product_id int, quantity int);
ALTER TABLE purgoai.fact_sales ADD CONSTRAINT FK_PRODUCT FOREIGN KEY (product_id) REFERENCES purgoai.dim_product (id);
CREATE TABLE purgoai.gold_monthly_sales (product_id int, product_name varchar(500), date DATE, total NUMERIC(13,2));

--Simple stored procedure to compute the total of sales per month
CREATE PROCEDURE purgoai.sp_compute_monthly_sales() AS $$

BEGIN

    INSERT INTO purgoai.gold_monthly_sales (product_id,product_name, date, total)
    SELECT product.id, product.name,sales.date, sum(sales.quantity * product.price) as total
    FROM purgoai.fact_sales sales 
        INNER JOIN purgoai.dim_product product on sales.product_id = product.id
    GROUP BY product.id, product.name,sales.date

RETURN;
END;
$$ LANGUAGE plpgsql;  

--Simple view to compute the total of each sale
CREATE VIEW purgoai.vw_get_total_sales
AS
SELECT sales.id,sales.date,product.name,sales.quantity,product.price, sales.quantity * product.price as total
FROM purgoai.fact_sales sales 
    INNER JOIN purgoai.dim_product product on sales.product_id = product.id;

call purgoai.sp_compute_monthly_sales()