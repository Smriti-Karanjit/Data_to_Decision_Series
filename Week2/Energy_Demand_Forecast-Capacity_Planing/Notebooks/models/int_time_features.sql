CREATE OR REPLACE VIEW ercot.int_time_features AS
SELECT
  hour_ts,
  year(hour_ts)      AS year,
  month(hour_ts)     AS month,
  dayofweek(hour_ts) AS day_of_week,
  hour(hour_ts)      AS hour_of_day,
  CASE WHEN dayofweek(hour_ts) IN (1,7) THEN 1 ELSE 0 END AS is_weekend
FROM ercot.stg_ercot_load_1h;
