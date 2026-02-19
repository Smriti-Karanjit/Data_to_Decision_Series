-- Fail if readiness levels are not monotonic with extreme_hours (higher extreme => not "less severe" readiness)

with base as (
  select
    month,
    readiness_level,
    delta_extreme_5pct
  from {{ ref('mart_capacity_readiness') }}
),

ranked as (
  select
    *,
    case
      when readiness_level = 'GREEN' then 1
      when readiness_level = 'AMBER' then 2
      when readiness_level = 'RED'   then 3
      else null
    end as readiness_rank
  from base
)

select *
from ranked
where readiness_rank is null
