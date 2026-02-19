
  
    
    

    create  table
      "ercot"."main_ercot"."fct_capacity_alerts__dbt_tmp"
  
    as (
      

with hourly as (
  select
    hour_ts,
    date_trunc('month', hour_ts) as month,
    risk_level
  from "ercot"."main_ercot"."fct_capacity_risk"
),

flagged as (
  select
    *,
    case when risk_level in ('HIGH','EXTREME') then 1 else 0 end as is_high_plus,
    case when risk_level = 'EXTREME' then 1 else 0 end as is_extreme
  from hourly
),

-- gaps-and-islands: create group ids separated by "not in band"
streaks as (
  select
    *,
    sum(case when is_high_plus = 0 then 1 else 0 end)
      over (partition by month order by hour_ts) as grp_high_plus,
    sum(case when is_extreme = 0 then 1 else 0 end)
      over (partition by month order by hour_ts) as grp_extreme
  from flagged
),

stats as (
  select
    month,

    sum(is_extreme) as extreme_hours,
    sum(case when risk_level='HIGH' then 1 else 0 end) as high_hours,
    sum(case when risk_level='MEDIUM' then 1 else 0 end) as medium_hours,
    sum(case when risk_level='LOW' then 1 else 0 end) as low_hours,

    max(case when is_high_plus=1 then cnt_high_plus else 0 end) as max_high_plus_streak,
    max(case when is_extreme=1 then cnt_extreme else 0 end) as max_extreme_streak

  from (
    select
      month, risk_level, is_high_plus, is_extreme,
      count(*) over (partition by month, grp_high_plus) as cnt_high_plus,
      count(*) over (partition by month, grp_extreme) as cnt_extreme
    from streaks
  ) x
  group by 1
)

select
  *,
  -- explainable “ops rule” (tune later)
  case
    when extreme_hours >= 250 or max_extreme_streak >= 12 then 1
    when high_hours >= 400 or max_high_plus_streak >= 24 then 1
    else 0
  end as alert_flag,

  case
    when extreme_hours >= 250 or max_extreme_streak >= 12 then 'PREP EXTRA CAPACITY / OPERATIONS'
    when high_hours >= 400 or max_high_plus_streak >= 24 then 'INCREASE READINESS / STAFFING'
    else 'NORMAL'
  end as recommended_action
from stats
    );
  
  