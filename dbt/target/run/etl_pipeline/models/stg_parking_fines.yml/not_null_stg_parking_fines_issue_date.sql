select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select issue_date
from "warehouse_db"."silver"."stg_parking_fines"
where issue_date is null



      
    ) dbt_internal_test