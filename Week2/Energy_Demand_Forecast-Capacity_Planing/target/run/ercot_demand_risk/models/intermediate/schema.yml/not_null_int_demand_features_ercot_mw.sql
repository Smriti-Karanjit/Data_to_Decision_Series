
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select ercot_mw
from "ercot"."main_ercot"."int_demand_features"
where ercot_mw is null



  
  
      
    ) dbt_internal_test