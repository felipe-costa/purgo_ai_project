--User and group creation for databricks to have access on Redshift
create user databricks with password 'abcD1234'

CREATE GROUP ro_group;

ALTER GROUP ro_group ADD USER databricks;

GRANT USAGE ON SCHEMA "purgoai" TO GROUP ro_group;

GRANT SELECT ON ALL TABLES IN SCHEMA purgoai to GROUP ro_group;
