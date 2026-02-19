



select
    1
from "ercot"."main_ercot"."fct_capacity_scenarios"

where not(projected_high_hours projected_high_hours >= 0)

