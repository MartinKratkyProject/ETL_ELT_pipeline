select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select summons_number
from "warehouse_db"."silver"."stg_parking_fines"
where summons_number is null



      
    ) dbt_internal_test