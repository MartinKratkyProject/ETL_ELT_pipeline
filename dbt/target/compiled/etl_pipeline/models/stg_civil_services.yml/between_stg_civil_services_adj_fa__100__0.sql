

select *
from "warehouse_db"."silver"."stg_civil_services"
where adj_fa < 0
   or adj_fa > 100

