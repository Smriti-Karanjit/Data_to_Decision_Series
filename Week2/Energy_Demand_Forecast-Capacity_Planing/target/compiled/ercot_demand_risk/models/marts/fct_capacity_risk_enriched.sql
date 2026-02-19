

select
  r.hour_ts,
  r.ercot_mw,
  r.risk_level,
  d.lag_1h,
  d.lag_24h,
  d.lag_168h,
  d.roll_mean_24h,
  d.roll_mean_7d,
  (r.ercot_mw - d.roll_mean_24h) as delta_vs_24h_mean
from "ercot"."main_ercot"."fct_capacity_risk" r
join "ercot"."main_ercot"."int_demand_features" d
  on r.hour_ts = d.hour_ts