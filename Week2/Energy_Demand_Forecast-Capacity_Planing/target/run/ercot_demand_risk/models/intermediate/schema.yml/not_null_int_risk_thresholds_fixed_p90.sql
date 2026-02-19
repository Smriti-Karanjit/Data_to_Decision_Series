
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select p90
from "ercot"."main_ercot"."int_risk_thresholds_fixed"
where p90 is null



  
  
      
    ) dbt_internal_test