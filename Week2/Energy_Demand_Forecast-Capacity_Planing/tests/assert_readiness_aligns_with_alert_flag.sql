-- Fail if alert_flag is true but readiness is not elevated/critical
-- Adjust allowed readiness values to match your model outputs.
select
  month,
  readiness_level,
  alert_flag
from {{ ref('mart_capacity_readiness') }}
where alert_flag = true
  and readiness_level in ('Stable', 'Normal', 'Low')  -- adjust to your labels
