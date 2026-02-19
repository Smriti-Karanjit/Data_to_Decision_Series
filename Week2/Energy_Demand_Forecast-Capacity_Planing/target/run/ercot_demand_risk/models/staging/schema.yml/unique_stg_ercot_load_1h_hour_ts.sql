
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    hour_ts as unique_field,
    count(*) as n_records

from "ercot"."main_ercot"."stg_ercot_load_1h"
where hour_ts is not null
group by hour_ts
having count(*) > 1



  
  
      
    ) dbt_internal_test