select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select list_no
from "warehouse_db"."silver"."stg_civil_services"
where list_no is null



      
    ) dbt_internal_test