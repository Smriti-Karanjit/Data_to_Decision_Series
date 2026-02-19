
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select baseline_start
from "ercot"."main_ercot"."int_risk_thresholds_fixed"
where baseline_start is null



  
  
      
    ) dbt_internal_test