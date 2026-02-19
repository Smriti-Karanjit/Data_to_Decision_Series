-- Fail if any growth scenario produces fewer (high+extreme) exposure hours than baseline for the same month.
with baseline as (
  select
    month,
    (high_hours + extreme_hours) as baseline_alert_hours
  from {{ ref('fct_capacity_risk_monthly') }}
),

scenarios as (
  select
    month,
    scenario,
    (projected_high_hours + projected_extreme_hours) as scenario_alert_hours
  from {{ ref('fct_capacity_scenarios') }}
)

select
  s.month,
  s.scenario,
  s.scenario_alert_hours,
  b.baseline_alert_hours
from scenarios s
join baseline b using (month)
where s.scenario_alert_hours < b.baseline_alert_hours