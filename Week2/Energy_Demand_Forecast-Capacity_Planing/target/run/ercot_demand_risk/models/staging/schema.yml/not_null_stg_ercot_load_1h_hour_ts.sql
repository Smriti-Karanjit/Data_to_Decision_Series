
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select hour_ts
from "ercot"."main_ercot"."stg_ercot_load_1h"
where hour_ts is null



  
  
      
    ) dbt_internal_test