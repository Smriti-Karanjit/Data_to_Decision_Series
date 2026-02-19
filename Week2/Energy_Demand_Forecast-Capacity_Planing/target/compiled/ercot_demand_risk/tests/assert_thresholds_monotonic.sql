select *
from "ercot"."main_ercot"."int_risk_thresholds_fixed"
where not (p90 < p95 and p95 < p99)