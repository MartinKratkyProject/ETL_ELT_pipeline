select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select common_name
from "warehouse_db"."silver"."stg_crocodiles"
where common_name is null



      
    ) dbt_internal_test