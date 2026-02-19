
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  select *
from "ercot"."main_ercot"."int_risk_thresholds_fixed"
where not (p90 < p95 and p95 < p99)
  
  
      
    ) dbt_internal_test