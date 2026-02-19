
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select pct_high
from "ercot"."main_ercot"."fct_capacity_risk_monthly"
where pct_high is null



  
  
      
    ) dbt_internal_test