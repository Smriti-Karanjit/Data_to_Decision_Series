
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select alert_flag
from "ercot"."main_ercot"."fct_capacity_alerts"
where alert_flag is null



  
  
      
    ) dbt_internal_test