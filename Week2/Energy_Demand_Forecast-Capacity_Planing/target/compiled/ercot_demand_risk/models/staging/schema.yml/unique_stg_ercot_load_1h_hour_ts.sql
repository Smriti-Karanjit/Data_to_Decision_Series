
    
    

select
    hour_ts as unique_field,
    count(*) as n_records

from "ercot"."main_ercot"."stg_ercot_load_1h"
where hour_ts is not null
group by hour_ts
having count(*) > 1


