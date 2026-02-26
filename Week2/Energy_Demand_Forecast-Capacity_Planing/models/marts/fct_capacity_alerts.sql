{{ config(materialized='table') }}

with params as (
  select
    250::int as extreme_hours_threshold,
    12::int  as extreme_streak_threshold,
    400::int as high_hours_threshold,
    24::int  as high_plus_streak_threshold
),

hourly as (
  select
    hour_ts,
    date_trunc('month', hour_ts) as month,
    risk_level,
    case when risk_level in ('HIGH','EXTREME') then 1 else 0 end as is_high_plus,
    case when risk_level = 'EXTREME' then 1 else 0 end as is_extreme
  from {{ ref('fct_capacity_risk') }}
),

-- group ids separated by "not in band"
streaks as (
  select
    *,
    sum(case when is_high_plus = 0 then 1 else 0 end)
      over (partition by month order by hour_ts) as grp_high_plus,
    sum(case when is_extreme = 0 then 1 else 0 end)
      over (partition by month order by hour_ts) as grp_extreme
  from hourly
),

-- compute true streak length (count only the band hours)
streak_counts as (
  select
    month,
    hour_ts,
    risk_level,
    is_high_plus,
    is_extreme,

    sum(is_high_plus) over (partition by month, grp_high_plus) as high_plus_streak_len,
    sum(is_extreme)   over (partition by month, grp_extreme)   as extreme_streak_len
  from streaks
),

stats as (
  select
    month,

    sum(is_extreme) as extreme_hours,
    sum(case when risk_level='HIGH' then 1 else 0 end) as high_hours,
    sum(case when risk_level='MEDIUM' then 1 else 0 end) as medium_hours,
    sum(case when risk_level='LOW' then 1 else 0 end) as low_hours,

    max(case when is_high_plus=1 then high_plus_streak_len else 0 end) as max_high_plus_streak,
    max(case when is_extreme=1 then extreme_streak_len else 0 end) as max_extreme_streak

  from streak_counts
  group by 1
)

select
  s.*,

  case
    when s.extreme_hours >= p.extreme_hours_threshold
      or s.max_extreme_streak >= p.extreme_streak_threshold
      then 1
    when s.high_hours >= p.high_hours_threshold
      or s.max_high_plus_streak >= p.high_plus_streak_threshold
      then 1
    else 0
  end as alert_flag,

  case
    when s.extreme_hours >= p.extreme_hours_threshold
      or s.max_extreme_streak >= p.extreme_streak_threshold
      then 'PREP EXTRA CAPACITY / OPERATIONS'
    when s.high_hours >= p.high_hours_threshold
      or s.max_high_plus_streak >= p.high_plus_streak_threshold
      then 'INCREASE READINESS / STAFFING'
    else 'NORMAL'
  end as recommended_action

from stats s
cross join params p