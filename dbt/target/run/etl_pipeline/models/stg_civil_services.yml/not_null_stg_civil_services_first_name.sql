select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select first_name
from "warehouse_db"."silver"."stg_civil_services"
where first_name is null



      
    ) dbt_internal_test