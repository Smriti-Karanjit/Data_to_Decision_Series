
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from "ercot"."main_ercot"."stg_ercot_load_1h"

where not(fwest_mw fwest_mw is null or fwest_mw >= 0)


  
  
      
    ) dbt_internal_test