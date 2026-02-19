
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  select *
from "ercot"."main_ercot"."stg_ercot_load_1h"
where ercot_mw <= 0
  
  
      
    ) dbt_internal_test