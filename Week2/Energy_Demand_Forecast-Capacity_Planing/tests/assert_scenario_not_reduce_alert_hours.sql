-- tests/assert_scenario_not_reduce_alert_hours.sql
with actual as (
  select
    month,
    (high_hours + extreme_hours) as actual_alert_hours
  from {{ ref('fct_capacity_risk_monthly') }}
),

scen as (
  select
    month,
    scenario,
    projected_alert_hours
  from {{ ref('fct_capacity_scenarios') }}
)

select
  s.month,
  s.scenario,
  s.projected_alert_hours,
  a.actual_alert_hours
from scen s
join actual a using (month)
where s.projected_alert_hours < a.actual_alert_hours
;
