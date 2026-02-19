{{ config(materialized='table') }}

with base as (
  select
    make_date(t.year::int, t.month::int, 1) as month,
    r.risk_level
  from {{ ref('fct_capacity_risk') }} r
  join {{ ref('int_time_features') }} t
    on r.hour_ts = t.hour_ts
),

agg as (
  select
    month,
    count(*) as total_hours,
    sum(case when risk_level = 'HIGH' then 1 else 0 end) as high_hours,
    sum(case when risk_level = 'EXTREME' then 1 else 0 end) as extreme_hours
  from base
  group by 1
)

select
  month,
  total_hours,
  high_hours,
  extreme_hours,
  round(high_hours * 1.0 / nullif(total_hours,0), 4) as pct_high,
  round(extreme_hours * 1.0 / nullif(total_hours,0), 4) as pct_extreme
from agg
order by month
