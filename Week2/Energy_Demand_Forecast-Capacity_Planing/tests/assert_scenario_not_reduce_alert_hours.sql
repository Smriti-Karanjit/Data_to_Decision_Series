-- Fail if any growth scenario produces fewer alert hours than baseline
select
  month,
  scenario_name,
  scenario_alert_hours,
  actual_alert_hours
from {{ ref('fct_capacity_scenarios') }}
where scenario_name != 'baseline'
  and scenario_alert_hours < actual_alert_hours
