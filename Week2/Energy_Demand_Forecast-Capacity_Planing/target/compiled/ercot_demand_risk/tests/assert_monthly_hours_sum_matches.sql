with a as (
  select sum(total_hours) as s
  from "ercot"."main_ercot"."fct_capacity_risk_monthly"
),
b as (
  select count(*) as c
  from "ercot"."main_ercot"."fct_capacity_risk"
)
select *
from a, b
where a.s <> b.c