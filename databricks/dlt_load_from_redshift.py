import dlt
from pyspark.sql.functions import *

@dlt.table(
  name='dim_product',
  comment="Retrieve dim_product table from redshift"
)
def src_dim_product():
  df = (spark.read
    .format("redshift")
    .option("url", "jdbc:redshift://default-workgroup.207567769123.eu-north-1.redshift-serverless.amazonaws.com:5439/dev")
    .option("dbtable", 'purgoai.dim_product')
    .option("user", 'databricks')
    .option("password", 'abcD1234')
    .load())
  return df

@dlt.table(
  name='fact_sales',
  comment="Retrieve fact_sales table from redshift"
)
def src_fact_sales():
  df = (spark.read
    .format("redshift")
    .option("url", "jdbc:redshift://default-workgroup.207567769123.eu-north-1.redshift-serverless.amazonaws.com:5439/dev")
    .option("dbtable", 'purgoai.fact_sales')
    .option("user", 'databricks')
    .option("password", 'abcD1234')
    .load())
  return df