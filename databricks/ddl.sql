--Schema creation
CREATE SCHEMA purgoai;

--Note: TABLES WILL BE CREATED BY THE DELTA LIVE TABLES PIPELINES

--Code for Delta Live Table to compute monthly sales
CREATE OR REFRESH MATERIALIZED VIEW monthly_sales
COMMENT "Compute monthly sales"
AS 
  SELECT product.id, product.name,sales.date, sum(sales.quantity * product.price) as total
  FROM purgoai.fact_sales sales 
      INNER JOIN purgoai.dim_product product on sales.product_id = product.id
  GROUP BY product.id, product.name,sales.date

--Total Sales View
CREATE VIEW purgoai.vw_get_total_sales
AS
SELECT sales.id,sales.date,product.name,sales.quantity,product.price, sales.quantity * product.price as total
FROM purgoai.fact_sales sales 
    INNER JOIN purgoai.dim_product product on sales.product_id = product.id;