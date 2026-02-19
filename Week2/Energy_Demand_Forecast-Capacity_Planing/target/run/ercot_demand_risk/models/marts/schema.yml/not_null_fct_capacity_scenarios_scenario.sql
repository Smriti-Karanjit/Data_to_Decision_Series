
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select scenario
from "ercot"."main_ercot"."fct_capacity_scenarios"
where scenario is null



  
  
      
    ) dbt_internal_test