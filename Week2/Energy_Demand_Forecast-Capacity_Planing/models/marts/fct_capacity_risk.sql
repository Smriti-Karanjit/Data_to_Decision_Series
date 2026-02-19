{{ config(materialized='table') }}

with th as (
  select * from {{ ref('int_risk_thresholds_fixed') }}
),
l as (
  select
    hour_ts,
    ercot_mw
  from {{ ref('stg_ercot_load_1h') }}
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
