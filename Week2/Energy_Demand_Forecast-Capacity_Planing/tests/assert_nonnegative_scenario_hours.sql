select *
from {{ ref('fct_capacity_scenarios') }}
where projected_extreme_hours < 0
   or projected_high_hours < 0
