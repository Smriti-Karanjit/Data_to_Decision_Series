

with base as (
  select
    date_trunc('month', hour_ts) as month,
    risk_level
  from "ercot"."main_ercot"."fct_capacity_risk"
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