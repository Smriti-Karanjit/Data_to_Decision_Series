{{ config(materialized='table') }}

with m as (
  select *
  from {{ ref('fct_capacity_risk_monthly') }}
),

a as (
  select
    month,
    extreme_hours,
    high_hours,
    alert_flag
  from {{ ref('fct_capacity_alerts') }}
),

s as (
  select
    month,
    max(case when scenario = 'GROWTH_2PCT' then projected_extreme_hours end) as extreme_2pct,
    max(case when scenario = 'GROWTH_5PCT' then projected_extreme_hours end) as extreme_5pct,
    max(case when scenario = 'GROWTH_8PCT' then projected_extreme_hours end) as extreme_8pct
  from {{ ref('fct_capacity_scenarios') }}
  group by 1
)

select
  m.month,
  m.total_hours,
  m.high_hours,
  m.extreme_hours,
  m.pct_high,
  m.pct_extreme,
  a.alert_flag,
  s.extreme_2pct,
  s.extreme_5pct,
  s.extreme_8pct,
  (s.extreme_5pct - m.extreme_hours) as delta_extreme_5pct
from m
left join a using (month)
left join s using (month)
order by m.month
