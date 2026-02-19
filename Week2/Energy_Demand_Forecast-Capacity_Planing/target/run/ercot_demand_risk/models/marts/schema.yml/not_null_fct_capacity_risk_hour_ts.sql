
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select hour_ts
from "ercot"."main_ercot"."fct_capacity_risk"
where hour_ts is null



  
  
      
    ) dbt_internal_test