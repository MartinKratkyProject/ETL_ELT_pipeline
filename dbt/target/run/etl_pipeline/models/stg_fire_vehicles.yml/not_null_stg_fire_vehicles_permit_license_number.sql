select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select permit_license_number
from "warehouse_db"."silver"."stg_fire_vehicles"
where permit_license_number is null



      
    ) dbt_internal_test