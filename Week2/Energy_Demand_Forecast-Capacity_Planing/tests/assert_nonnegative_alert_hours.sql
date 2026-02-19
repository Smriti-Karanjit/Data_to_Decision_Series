select *
from {{ ref('fct_capacity_alerts') }}
where extreme_hours < 0
   or high_hours < 0
