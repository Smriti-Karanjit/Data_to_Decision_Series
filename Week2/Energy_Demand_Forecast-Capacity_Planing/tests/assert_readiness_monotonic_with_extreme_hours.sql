-- Fail if extreme hours increase but readiness decreases month-over-month.
-- This catches inconsistent mapping logic.
with ordered as (
  select
    month,
    extreme_hours,
    readiness_level,
    lag(extreme_hours) over (order by month) as prev_extreme_hours,
    lag(readiness_level) over (order by month) as prev_readiness_level
  from {{ ref('mart_capacity_readiness') }}
),
ranked as (
  select
    *,
    case
      when readiness_level in ('Stable','Normal','Low') then 1
      when readiness_level in ('Elevated','Medium') then 2
      when readiness_level in ('Critical','High') then 3
      else null
    end as readiness_rank,
    case
      when prev_readiness_level in ('Stable','Normal','Low') then 1
      when prev_readiness_level in ('Elevated','Medium') then 2
      when prev_readiness_level in ('Critical','High') then 3
      else null
    end as prev_readiness_rank
  from ordered
)
select
  month,
  prev_extreme_hours,
  extreme_hours,
  prev_readiness_level,
  readiness_level
from ranked
where prev_extreme_hours is not null
  and readiness_rank is not null
  and prev_readiness_rank is not null
  and extreme_hours > prev_extreme_hours
  and readiness_rank < prev_readiness_rank
