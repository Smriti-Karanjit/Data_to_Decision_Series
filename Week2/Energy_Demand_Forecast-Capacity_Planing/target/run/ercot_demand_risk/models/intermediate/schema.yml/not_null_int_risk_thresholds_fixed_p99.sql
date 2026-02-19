
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select p99
from "ercot"."main_ercot"."int_risk_thresholds_fixed"
where p99 is null



  
  
      
    ) dbt_internal_test