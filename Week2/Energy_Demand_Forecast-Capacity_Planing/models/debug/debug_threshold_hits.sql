{{ config(materialized='view') }}

with x as (
  select
    ercot_mw,
    p90, p95, p99
  from {{ ref('fct_capacity_risk') }}
)
select
  sum(case when ercot_mw >= p90 then 1 else 0 end) as ge_p90,
  sum(case when ercot_mw >= p95 then 1 else 0 end) as ge_p95,
  sum(case when ercot_mw >= p99 then 1 else 0 end) as ge_p99,
  count(*) as n
from x