
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select pct_extreme
from "ercot"."main_ercot"."fct_capacity_risk_monthly"
where pct_extreme is null



  
  
      
    ) dbt_internal_test