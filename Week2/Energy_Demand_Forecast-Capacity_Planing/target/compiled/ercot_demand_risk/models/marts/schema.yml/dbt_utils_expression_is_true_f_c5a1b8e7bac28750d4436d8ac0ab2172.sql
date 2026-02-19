



select
    1
from "ercot"."main_ercot"."fct_capacity_alerts"

where not(extreme_hours extreme_hours >= 0)

