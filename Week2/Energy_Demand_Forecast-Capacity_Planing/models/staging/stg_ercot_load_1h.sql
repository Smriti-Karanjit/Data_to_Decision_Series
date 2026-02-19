-- models/staging/stg_ercot_load_1h.sql
-- Output: one row per hour (DST duplicates averaged)

CREATE OR REPLACE VIEW ercot.stg_ercot_load_1h AS
SELECT
  hour_ts,
  AVG(ercot_mw) AS ercot_mw,
  AVG(coast_mw) AS coast_mw,
  AVG(east_mw)  AS east_mw,
  AVG(fwest_mw) AS fwest_mw,
  AVG(north_mw) AS north_mw,
  AVG(ncent_mw) AS ncent_mw,
  AVG(south_mw) AS south_mw,
  AVG(scent_mw) AS scent_mw,
  AVG(west_mw)  AS west_mw
FROM ercot.stg_ercot_load
GROUP BY hour_ts;
