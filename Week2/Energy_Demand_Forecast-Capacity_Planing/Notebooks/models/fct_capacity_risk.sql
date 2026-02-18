-- models/marts/fct_capacity_risk.sql

CREATE OR REPLACE TABLE ercot.fct_capacity_risk AS
WITH th AS (
  SELECT
    percentile_approx(ercot_mw, 0.90) AS p90,
    percentile_approx(ercot_mw, 0.95) AS p95,
    percentile_approx(ercot_mw, 0.99) AS p99
  FROM ercot.stg_ercot_load_1h
)
SELECT
  hour_ts,
  ercot_mw,
  CASE
    WHEN ercot_mw >= th.p99 THEN 'EXTREME'
    WHEN ercot_mw >= th.p95 THEN 'HIGH'
    WHEN ercot_mw >= th.p90 THEN 'MEDIUM'
    ELSE 'LOW'
  END AS risk_level
FROM ercot.stg_ercot_load_1h
CROSS JOIN th;
