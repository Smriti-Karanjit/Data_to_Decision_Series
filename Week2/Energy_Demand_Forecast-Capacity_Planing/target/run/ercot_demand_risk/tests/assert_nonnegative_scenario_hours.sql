
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  select *
from "ercot"."main_ercot"."fct_capacity_scenarios"
where projected_extreme_hours < 0
   or projected_high_hours < 0
  
  
      
    ) dbt_internal_test