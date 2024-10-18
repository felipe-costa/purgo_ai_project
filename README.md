
# Purgo AI Project

Simple project with samples of code migration from Redshift to Databricks

## Redshift

For Redshift the following scripts were created:

* [ddl.sql](redshift/ddl.sql): Contains the data definition scripts for 3 tables (dim_product, fact_sales, gold_monthly_sales), one view: vw_get_total_sales, and one stored procedure: sp_compute_monthly_sales. Objects were created on schema purgoai.
* [data_gen.sql](redshift/data_gen.sql): Contains one stored procedure to load synthetic into the tables dim_product and fact_sales.
* [auth.sql](redshift/auth.sql): scripts used to create database user to connect to Redshift.
![redshift_tables](/../main/redshift/redshift_tables.png?raw=true "Optional Title")
## Databricks

IMPORTANT: Databricks SQL Warehouse don't have support for stored procedures. In this case I'm replacing stored procedures for Delta Live Tables workloads.

For Databricks the following scripts were created:
* [ddl.sql](databricks/ddl.sql): contains the schema definition, the view creation (vw_get_total_sales), and the code for the gold_monthly_sales delta live table.
* [dlt_load_from_redshift.py](databricks/dlt_load_from_redshift.py): Data Migration Script. This is script will take care of read data from tables in Redshift and load into databricks. Tables will be automatically created on Databricks. This script will also be used on a Delta Live Table pipeline.
![dlt](/../main/databricks/Delta_Live_Tables.png?raw=true "Optional Title")


