with pivoted as (
  select
    month,
    max(case when scenario='GROWTH_2PCT' then projected_high_hours + projected_extreme_hours end) as alert_2,
    max(case when scenario='GROWTH_5PCT' then projected_high_hours + projected_extreme_hours end) as alert_5,
    max(case when scenario='GROWTH_8PCT' then projected_high_hours + projected_extreme_hours end) as alert_8,
    max(case when scenario='GROWTH_2PCT' then projected_extreme_hours end) as ex_2,
    max(case when scenario='GROWTH_5PCT' then projected_extreme_hours end) as ex_5,
    max(case when scenario='GROWTH_8PCT' then projected_extreme_hours end) as ex_8
  from {{ ref('fct_capacity_scenarios') }}
  group by 1
)
select *
from pivoted
where alert_5 < alert_2
   or alert_8 < alert_5
   or ex_5 < ex_2
   or ex_8 < ex_5
