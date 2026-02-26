{{ config(materialized='table') }}

with m as (
  select
    month,
    total_hours,
    high_hours,
    extreme_hours,
    pct_high,
    pct_extreme
  from {{ ref('fct_capacity_risk_monthly') }}
),

a as (
  select
    month,
    alert_flag,
    recommended_action as alert_recommended_action
  from {{ ref('fct_capacity_alerts') }}
),

s as (
  select
    month,
    max(case when scenario = 'GROWTH_2PCT' then projected_extreme_hours end) as extreme_2pct,
    max(case when scenario = 'GROWTH_5PCT' then projected_extreme_hours end) as extreme_5pct,
    max(case when scenario = 'GROWTH_8PCT' then projected_extreme_hours end) as extreme_8pct,

    max(case when scenario = 'GROWTH_2PCT' then projected_high_hours end) as high_2pct,
    max(case when scenario = 'GROWTH_5PCT' then projected_high_hours end) as high_5pct,
    max(case when scenario = 'GROWTH_8PCT' then projected_high_hours end) as high_8pct

    -- If you add projected_high_plus_hours in fct_capacity_scenarios:
    -- , max(case when scenario = 'GROWTH_2PCT' then projected_high_plus_hours end) as high_plus_2pct
    -- , max(case when scenario = 'GROWTH_5PCT' then projected_high_plus_hours end) as high_plus_5pct
    -- , max(case when scenario = 'GROWTH_8PCT' then projected_high_plus_hours end) as high_plus_8pct

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

  coalesce(a.alert_flag, 0) as alert_flag,
  a.alert_recommended_action,

  s.extreme_2pct,
  s.extreme_5pct,
  s.extreme_8pct,

  s.high_2pct,
  s.high_5pct,
  s.high_8pct,

  (s.extreme_5pct - m.extreme_hours) as delta_extreme_5pct,
  (s.high_5pct - m.high_hours)       as delta_high_5pct

from m
left join a using (month)
left join s using (month)
order by m.month