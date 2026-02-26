{{ config(materialized='table') }}

with th as (
  select * from {{ ref('int_risk_thresholds_fixed') }}
),

base as (
  select
    date_trunc('month', hour_ts) as month,
    ercot_mw
  from {{ ref('fct_capacity_risk') }}
),

scenarios as (
  select 'GROWTH_2PCT' as scenario, 1.02 as mult union all
  select 'GROWTH_5PCT', 1.05 union all
  select 'GROWTH_8PCT', 1.08
),

hourly_proj as (
  select
    b.month,
    s.scenario,
    b.ercot_mw * s.mult as projected_mw
  from base b
  cross join scenarios s
)

select
  month,
  scenario,
  sum(case when projected_mw >= th.p99 then 1 else 0 end) as projected_extreme_hours,
  sum(case when projected_mw >= th.p95 and projected_mw < th.p99 then 1 else 0 end) as projected_high_hours,
  sum(case when projected_mw >= th.p95 then 1 else 0 end) as projected_high_plus_hours
from hourly_proj
cross join th
group by 1,2
