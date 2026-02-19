-- Fail if any growth scenario produces fewer EXTREME hours than baseline (monotonic stress)
with baseline as (
  select
    month,
    projected_extreme_hours as baseline_extreme_hours
  from {{ ref('fct_capacity_scenarios') }}
  where scenario = 'GROWTH_2PCT'  -- baseline proxy if you don't store baseline in this table
),
scenarios as (
  select
    month,
    scenario,
    projected_extreme_hours as scenario_extreme_hours
  from {{ ref('fct_capacity_scenarios') }}
)
select
  s.month,
  s.scenario,
  s.scenario_extreme_hours,
  b.baseline_extreme_hours
from scenarios s
join baseline b using (month)
where s.scenario in ('GROWTH_5PCT','GROWTH_8PCT')
  and s.scenario_extreme_hours < b.baseline_extreme_hours
