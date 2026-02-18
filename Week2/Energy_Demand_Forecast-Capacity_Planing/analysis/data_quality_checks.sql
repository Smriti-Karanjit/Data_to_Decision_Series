-- analysis/data_quality_checks.sql

-- Row counts
SELECT
  (SELECT COUNT(*) FROM ercot.raw_ercot_hourly_load) AS raw_rows,
  (SELECT COUNT(*) FROM ercot.stg_ercot_load)        AS stg_rows,
  (SELECT COUNT(*) FROM ercot.stg_ercot_load_1h)     AS hourly_rows;

-- Null timestamps
SELECT COUNT(*) AS null_hour_ts
FROM ercot.stg_ercot_load
WHERE hour_ts IS NULL;

-- Duplicate timestamps before hourly aggregation (DST)
SELECT COUNT(*) AS dup_hours
FROM (
  SELECT hour_ts, COUNT(*) c
  FROM ercot.stg_ercot_load
  GROUP BY hour_ts
  HAVING c > 1
);

-- Range sanity
SELECT MIN(hour_ts) AS min_ts, MAX(hour_ts) AS max_ts
FROM ercot.stg_ercot_load_1h;
