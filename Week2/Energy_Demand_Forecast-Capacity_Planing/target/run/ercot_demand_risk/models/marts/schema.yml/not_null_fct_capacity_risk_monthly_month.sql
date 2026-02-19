
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select month
from "ercot"."main_ercot"."fct_capacity_risk_monthly"
where month is null



  
  
      
    ) dbt_internal_test