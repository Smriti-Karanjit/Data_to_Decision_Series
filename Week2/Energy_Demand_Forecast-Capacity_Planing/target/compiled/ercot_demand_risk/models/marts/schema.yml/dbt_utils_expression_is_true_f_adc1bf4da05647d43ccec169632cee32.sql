



select
    1
from "ercot"."main_ercot"."fct_capacity_alerts"

where not(high_hours high_hours >= 0)

