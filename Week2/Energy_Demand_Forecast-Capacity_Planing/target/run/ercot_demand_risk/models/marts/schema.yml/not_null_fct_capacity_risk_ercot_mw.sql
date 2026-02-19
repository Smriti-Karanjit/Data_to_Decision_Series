
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select ercot_mw
from "ercot"."main_ercot"."fct_capacity_risk"
where ercot_mw is null



  
  
      
    ) dbt_internal_test