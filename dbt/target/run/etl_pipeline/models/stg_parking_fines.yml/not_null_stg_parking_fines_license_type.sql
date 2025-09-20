select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select license_type
from "warehouse_db"."silver"."stg_parking_fines"
where license_type is null



      
    ) dbt_internal_test