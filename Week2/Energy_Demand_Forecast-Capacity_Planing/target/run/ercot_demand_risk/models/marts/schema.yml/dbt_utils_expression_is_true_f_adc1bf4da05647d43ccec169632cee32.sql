
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from "ercot"."main_ercot"."fct_capacity_alerts"

where not(high_hours high_hours >= 0)


  
  
      
    ) dbt_internal_test