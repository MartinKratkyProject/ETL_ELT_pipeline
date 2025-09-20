select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    plate as unique_field,
    count(*) as n_records

from "warehouse_db"."silver"."stg_parking_fines"
where plate is not null
group by plate
having count(*) > 1



      
    ) dbt_internal_test