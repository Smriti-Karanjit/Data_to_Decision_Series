
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select total_hours
from "ercot"."main_ercot"."fct_capacity_risk_monthly"
where total_hours is null



  
  
      
    ) dbt_internal_test