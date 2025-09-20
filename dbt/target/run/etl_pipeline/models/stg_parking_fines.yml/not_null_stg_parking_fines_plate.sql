select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select plate
from "warehouse_db"."silver"."stg_parking_fines"
where plate is null



      
    ) dbt_internal_test