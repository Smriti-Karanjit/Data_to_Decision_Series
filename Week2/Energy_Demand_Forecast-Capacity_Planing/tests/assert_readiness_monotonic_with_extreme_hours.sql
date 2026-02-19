-- tests/assert_scenario_monotonicity_high_extreme.sql
with pivoted as (
  select
    month,
    max(case when scenario = 'GROWTH_2PCT' then projected_extreme_hours end) as extreme_2,
    max(case when scenario = 'GROWTH_5PCT' then projected_extreme_hours end) as extreme_5,
    max(case when scenario = 'GROWTH_8PCT' then projected_extreme_hours end) as extreme_8,

    max(case when scenario = 'GROWTH_2PCT' then projected_alert_hours end) as alert_2,
    max(case when scenario = 'GROWTH_5PCT' then projected_alert_hours end) as alert_5,
    max(case when scenario = 'GROWTH_8PCT' then projected_alert_hours end) as alert_8
  from {{ ref('fct_capacity_scenarios') }}
  group by 1
)

select *
from pivoted
where extreme_2 is null or extreme_5 is null or extreme_8 is null
   or alert_2 is null or alert_5 is null or alert_8 is null
   or extreme_5 < extreme_2
   or extreme_8 < extreme_5
   or alert_5 < alert_2
   or alert_8 < alert_5
;
