{{ config(materialized='table') }}

with baseline as (
  select
    ercot_mw
  from {{ ref('stg_ercot_load_1h') }}
  where hour_ts >= timestamp '2021-01-01'
    and hour_ts <  timestamp '2024-01-01'
)

select
  quantile_cont(ercot_mw, 0.90) as p90,
  quantile_cont(ercot_mw, 0.95) as p95,
  quantile_cont(ercot_mw, 0.99) as p99,
  timestamp '2021-01-01' as baseline_start,
  timestamp '2024-01-01' as baseline_end
from baseline