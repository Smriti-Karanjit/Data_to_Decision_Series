
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  select *
from "ercot"."main_ercot"."fct_capacity_alerts"
where extreme_hours < 0
   or high_hours < 0
  
  
      
    ) dbt_internal_test