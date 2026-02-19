-- Fail if projected exposure is not monotonic with higher growth scenarios.
-- Expect: GROWTH_2PCT <= GROWTH_5PCT <= GROWTH_8PCT
with s as (
  select
    month,
    sum(case when scenario = 'GROWTH_2PCT' then projected_high_hours end) as high_2,
    sum(case when scenario = 'GROWTH_5PCT' then projected_high_hours end) as high_5,
    sum(case when scenario = 'GROWTH_8PCT' then projected_high_hours end) as high_8,
    sum(case when scenario = 'GROWTH_2PCT' then projected_extreme_hours end) as extreme_2,
    sum(case when scenario = 'GROWTH_5PCT' then projected_extreme_hours end) as extreme_5,
    sum(case when scenario = 'GROWTH_8PCT' then projected_extreme_hours end) as extreme_8
  from {{ ref('fct_capacity_scenarios') }}
  group by 1
)
select *
from s
where (high_5 < high_2) or (high_8 < high_5)
   or (extreme_5 < extreme_2) or (extreme_8 < extreme_5)
