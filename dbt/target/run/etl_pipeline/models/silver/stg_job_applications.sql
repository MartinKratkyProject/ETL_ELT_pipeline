
  create view "warehouse_db"."silver"."stg_job_applications__dbt_tmp"
    
    
  as (
    with raw_job_applications as (
    select *
    from raw_data.table_xlsx_job_applications
)

select
    "Unnamed: 0" as col1,
    "Unnamed: 1" as col2
from raw_job_applications
where "Unnamed: 0" is not null
  );