
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from "ercot"."main_ercot"."stg_ercot_load_1h"

where not(ncent_mw ncent_mw is null or ncent_mw >= 0)


  
  
      
    ) dbt_internal_test