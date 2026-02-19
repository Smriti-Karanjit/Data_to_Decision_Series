
  
    
    

    create  table
      "ercot"."main_ercot"."fct_capacity_risk__dbt_tmp"
  
    as (
      

with th as (
  select * from "ercot"."main_ercot"."int_risk_thresholds_fixed"
),
l as (
  select
    hour_ts,
    ercot_mw
  from "ercot"."main_ercot"."stg_ercot_load_1h"
)

select
  l.hour_ts,
  l.ercot_mw,
  case
    when l.ercot_mw >= th.p99 then 'EXTREME'
    when l.ercot_mw >= th.p95 then 'HIGH'
    when l.ercot_mw >= th.p90 then 'MEDIUM'
    else 'LOW'
  end as risk_level,
  th.p90, th.p95, th.p99,
  th.baseline_start,
  th.baseline_end
from l
cross join th
    );
  
  