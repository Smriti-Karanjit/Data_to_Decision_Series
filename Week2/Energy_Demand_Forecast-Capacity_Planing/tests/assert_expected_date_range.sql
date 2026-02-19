-- Fail if data range unexpectedly changes (adjust dates for your seed)
select *
from (
  select
    min(hour_ts) as min_ts,
    max(hour_ts) as max_ts
  from {{ ref('fct_capacity_risk') }}
) t
where min_ts is null
   or max_ts is null
   or min_ts > timestamp '2021-01-01'
