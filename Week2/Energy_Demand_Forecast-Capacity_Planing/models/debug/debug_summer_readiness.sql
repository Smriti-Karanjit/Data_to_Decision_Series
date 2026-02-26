{{ config(materialized='view') }}

select
  month,
  total_hours,
  high_hours,
  extreme_hours,
  pct_high,
  pct_extreme,
  readiness_level,
  alert_flag
from {{ ref('mart_capacity_readiness') }}
where extract(month from month) in (6,7,8,9)
order by month