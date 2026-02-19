-- Fail if exposure is not monotonic across increasing growth scenarios.
-- Assumes one row per (month, scenario) in fct_capacity_scenarios.
with pivoted as (
  select
    month,
    max(case when scenario = 'GROWTH_2PCT' then projected_high_hours end) as high_2,
    max(case when scenario = 'GROWTH_5PCT' then projected_high_hours end) as high_5,
    max(case when scenario = 'GROWTH_8PCT' then projected_high_hours end) as high_8,
    max(case when scenario = 'GROWTH_2PCT' then projected_extreme_hours end) as extreme_2,
    max(case when scenario = 'GROWTH_5PCT' then projected_extreme_hours end) as extreme_5,
    max(case when scenario = 'GROWTH_8PCT' then projected_extreme_hours end) as extreme_8
  from {{ ref('fct_capacity_scenarios') }}
  group by 1
)
select *
from pivoted
where high_2 is null or high_5 is null or high_8 is null
   or extreme_2 is null or extreme_5 is null or extreme_8 is null
   or high_5 < high_2
   or high_8 < high_5
   or extreme_5 < extreme_2
   or extreme_8 < extreme_5
