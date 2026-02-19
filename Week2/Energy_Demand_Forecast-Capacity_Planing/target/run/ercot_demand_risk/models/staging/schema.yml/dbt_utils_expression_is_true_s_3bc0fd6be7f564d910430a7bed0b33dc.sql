
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from "ercot"."main_ercot"."stg_ercot_load_1h"

where not(coast_mw coast_mw is null or coast_mw >= 0)


  
  
      
    ) dbt_internal_test