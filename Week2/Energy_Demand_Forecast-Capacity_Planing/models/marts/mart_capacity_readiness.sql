{{ config(materialized='table') }}

with monthly as (
  select
    month,
    total_hours,
    high_hours,
    extreme_hours,
    pct_high,
    pct_extreme
  from {{ ref('fct_capacity_risk_monthly') }}
),

alerts as (
  select
    month,
    alert_flag,
    extreme_hours as alert_extreme_hours,
    high_hours as alert_high_hours
  from {{ ref('fct_capacity_alerts') }}
),

scenarios as (
  select
    month,
    max(case when scenario = 'GROWTH_2PCT' then projected_extreme_hours end) as extreme_2pct,
    max(case when scenario = 'GROWTH_5PCT' then projected_extreme_hours end) as extreme_5pct,
    max(case when scenario = 'GROWTH_8PCT' then projected_extreme_hours end) as extreme_8pct,
    max(case when scenario = 'GROWTH_2PCT' then projected_high_hours end)    as high_2pct,
    max(case when scenario = 'GROWTH_5PCT' then projected_high_hours end)    as high_5pct,
    max(case when scenario = 'GROWTH_8PCT' then projected_high_hours end)    as high_8pct
  from {{ ref('fct_capacity_scenarios') }}
  group by 1
),

final as (
  select
    m.month,
    m.total_hours,
    m.high_hours,
    m.extreme_hours,
    m.pct_high,
    m.pct_extreme,

    coalesce(a.alert_flag, 0) as alert_flag,

    s.extreme_2pct,
    s.extreme_5pct,
    s.extreme_8pct,
    s.high_2pct,
    s.high_5pct,
    s.high_8pct,

    (s.extreme_5pct - m.extreme_hours) as delta_extreme_5pct,
    (s.high_5pct - m.high_hours)       as delta_high_5pct,

    case
      when coalesce(a.alert_flag,0) = 1 or m.pct_extreme >= 0.10 then 'RED'
      when m.pct_extreme >= 0.03 or m.pct_high >= 0.20 then 'AMBER'
      else 'GREEN'
    end as readiness_level,

    case
      when coalesce(a.alert_flag,0) = 1 or m.pct_extreme >= 0.10 then 'Prepare emergency reserves + demand response'
      when m.pct_extreme >= 0.03 or m.pct_high >= 0.20 then 'Schedule extra capacity + maintenance freeze window'
      else 'Normal operations'
    end as recommended_action

  from monthly m
  left join alerts a using (month)
  left join scenarios s using (month)
)

select *
from final
order by month
