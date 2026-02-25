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
   -- compare at DATE level (timestamps may not start at 00:00)
   or cast(min_ts as date) > date '2021-01-01'
   -- also protect against missing tail-end data (adjust if your seed changes)
   or cast(max_ts as date) < date '2025-12-31'