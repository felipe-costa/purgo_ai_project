--Stored procedure to generate synthetic data for testing purposes
CREATE PROCEDURE data_gen() AS $$
DECLARE
  reports RECORD;
BEGIN
FOR b in 1..300 LOOP
    INSERT INTO purgoai.dim_product (name,description,price) values ('PRODUCT 0' + cast(b as varchar(10)), 'DESCRIPTION FOR PRODUCT 0' + cast(b as varchar(10)), CAST(RANDOM() * 100 AS INT));
END LOOP;

FOR i in 1..12 LOOP

  INSERT INTO purgoai.fact_sales (date, product_id,quantity)
  with src as (
  SELECT  cast('2024-' + trim(to_char(i, '09')) + '-01' as date) as date,id,CAST(RANDOM() * 100 AS INT) as quantity,
  cast(random() * 100 as int) as rnd
  FROM purgoai.dim_product
  ORDER BY RANDOM()
  )
  select date,id,quantity
  from src
  where rnd < 40;

END LOOP;

RETURN;
END;
$$ LANGUAGE plpgsql;  