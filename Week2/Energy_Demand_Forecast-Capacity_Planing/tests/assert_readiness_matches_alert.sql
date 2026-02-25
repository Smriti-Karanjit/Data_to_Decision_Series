select month
from {{ ref('mart_capacity_readiness') }}
where alert_flag = 1
  and readiness_level != 'RED'