select *
from {{ ref('int_risk_thresholds_fixed') }}
where not (p90 < p95 and p95 < p99)
