{{ config(materialized='table') }}

with base as (
  select
    hour_ts,
    ercot_mw
  from {{ ref('stg_ercot_load_1h') }}
  where hour_ts >= timestamp('2021-01-01')
    and hour_ts <  timestamp('2024-01-01')  -- baseline: 2021-2023
),

th as (
  select
    percentile_approx(ercot_mw, 0.90) as p90,
    percentile_approx(ercot_mw, 0.95) as p95,
    percentile_approx(ercot_mw, 0.99) as p99
  from base
)

select
  p90, p95, p99,
  '2021-01-01' as baseline_start,
  '2024-01-01' as baseline_end
from th
