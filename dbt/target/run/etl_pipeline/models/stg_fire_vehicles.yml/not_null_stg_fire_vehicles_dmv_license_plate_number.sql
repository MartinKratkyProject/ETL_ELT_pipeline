select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select dmv_license_plate_number
from "warehouse_db"."silver"."stg_fire_vehicles"
where dmv_license_plate_number is null



      
    ) dbt_internal_test