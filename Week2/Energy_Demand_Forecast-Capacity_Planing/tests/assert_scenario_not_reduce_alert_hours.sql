-- Fail if any growth scenario produces fewer alert hours than baseline.
-- Here "alert hours" means HIGH + EXTREME (or whatever your definition is).
with baseline as (
  select
    month,
    (projected_high_hours + projected_extreme_hours) as baseline_alert_hours
  from {{ ref('fct_capacity_scenarios') }}
  -- if you don't have a baseline scenario row, remove this block and compare vs actuals instead
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
