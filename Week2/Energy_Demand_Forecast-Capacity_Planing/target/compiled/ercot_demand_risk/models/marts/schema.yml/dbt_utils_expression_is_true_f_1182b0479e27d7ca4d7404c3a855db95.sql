



select
    1
from "ercot"."main_ercot"."fct_capacity_scenarios"

where not(projected_extreme_hours projected_extreme_hours >= 0)

