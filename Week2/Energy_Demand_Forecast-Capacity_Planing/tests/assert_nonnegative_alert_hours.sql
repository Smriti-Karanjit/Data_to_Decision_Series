select *
from {{ ref('fct_capacity_alerts') }}
where high_hours < 0
   or extreme_hours < 0
