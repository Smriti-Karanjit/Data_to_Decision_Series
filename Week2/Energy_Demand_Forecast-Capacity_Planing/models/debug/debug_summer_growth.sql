{{ config(materialized='view') }}

with base as (
  select
    month,
    extreme_hours as baseline_extreme
  from {{ ref('fct_capacity_risk_monthly') }}
  where extract(month from month) in (6,7,8,9)
),

growth as (
  select
    month,
    projected_extreme_hours
  from {{ ref('fct_capacity_scenarios') }}
  where scenario = 'GROWTH_5PCT'
    and extract(month from month) in (6,7,8,9)
)

select
  b.month,
  b.baseline_extreme,
  g.projected_extreme_hours as extreme_5pct,
  (g.projected_extreme_hours - b.baseline_extreme) as delta_extreme
from base b
join growth g using (month)
order by delta_extreme desc