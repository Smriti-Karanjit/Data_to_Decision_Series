with actual as (
  select month,
         sum(high_hours) as actual_high,
         sum(extreme_hours) as actual_extreme
  from {{ ref('fct_capacity_risk_monthly') }}
  group by 1
),
scen as (
  select month,
         max(case when scenario = 'GROWTH_2PCT' then projected_high_hours end) as s2_high,
         max(case when scenario = 'GROWTH_2PCT' then projected_extreme_hours end) as s2_extreme
  from {{ ref('fct_capacity_scenarios') }}
  group by 1
)
select a.month
from actual a
join scen s using(month)
where s.s2_high < a.actual_high
   or s.s2_extreme < a.actual_extreme
