select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select vehicle_vin_number
from "warehouse_db"."silver"."stg_fire_vehicles"
where vehicle_vin_number is null



      
    ) dbt_internal_test