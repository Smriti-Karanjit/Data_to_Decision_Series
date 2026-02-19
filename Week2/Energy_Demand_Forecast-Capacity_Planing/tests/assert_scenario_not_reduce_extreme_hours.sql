-- Fail if any growth scenario produces fewer extreme hours than baseline
select
  month,
  scenario_name,
  scenario_extreme_hours,
  actual_extreme_hours
from {{ ref('fct_capacity_scenarios') }}
where scenario_name != 'baseline'
  and scenario_extreme_hours < actual_extreme_hours
