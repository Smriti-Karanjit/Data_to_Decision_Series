
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select projected_high_hours
from "ercot"."main_ercot"."fct_capacity_scenarios"
where projected_high_hours is null



  
  
      
    ) dbt_internal_test