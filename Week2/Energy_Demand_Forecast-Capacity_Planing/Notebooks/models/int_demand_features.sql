-- models/intermediate/int_demand_features.sql

CREATE OR REPLACE VIEW ercot.int_demand_features AS
SELECT
  l.hour_ts,
  l.ercot_mw,
  t.year, t.month, t.day_of_week, t.hour_of_day, t.is_weekend,

  LAG(l.ercot_mw, 1)   OVER (ORDER BY l.hour_ts) AS lag_1h,
  LAG(l.ercot_mw, 24)  OVER (ORDER BY l.hour_ts) AS lag_24h,
  LAG(l.ercot_mw, 168) OVER (ORDER BY l.hour_ts) AS lag_168h,

  AVG(l.ercot_mw) OVER (ORDER BY l.hour_ts ROWS BETWEEN 23 PRECEDING AND CURRENT ROW)  AS roll_mean_24h,
  AVG(l.ercot_mw) OVER (ORDER BY l.hour_ts ROWS BETWEEN 167 PRECEDING AND CURRENT ROW) AS roll_mean_7d

FROM ercot.stg_ercot_load_1h l
JOIN ercot.int_time_features t
  ON l.hour_ts = t.hour_ts;
