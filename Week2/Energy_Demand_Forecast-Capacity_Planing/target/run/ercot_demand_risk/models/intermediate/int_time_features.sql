
  
    
    

    create  table
      "ercot"."main_ercot"."int_time_features__dbt_tmp"
  
    as (
      

select
  hour_ts,
  extract(year from hour_ts) as year,
  extract(month from hour_ts) as month,
  extract(dow from hour_ts) as day_of_week,   -- DuckDB: 0=Sunday ... 6=Saturday
  extract(hour from hour_ts) as hour_of_day,
  case when extract(dow from hour_ts) in (0, 6) then 1 else 0 end as is_weekend
from "ercot"."main_ercot"."stg_ercot_load_1h"
    );
  
  