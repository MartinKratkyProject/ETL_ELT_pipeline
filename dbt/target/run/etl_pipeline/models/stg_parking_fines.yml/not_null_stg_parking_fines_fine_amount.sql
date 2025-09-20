select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select fine_amount
from "warehouse_db"."silver"."stg_parking_fines"
where fine_amount is null



      
    ) dbt_internal_test