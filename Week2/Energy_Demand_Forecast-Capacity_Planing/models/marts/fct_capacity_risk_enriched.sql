{{ config(materialized='table') }}

select
  r.hour_ts,
  r.ercot_mw,
  r.risk_level,

  t.year,
  t.month,
  t.day_of_week,
  t.hour_of_day,
  t.is_weekend,

  d.lag_1h,
  d.lag_24h,
  d.lag_168h,
  d.roll_mean_24h,
  d.roll_mean_7d,

  (r.ercot_mw - d.roll_mean_24h) as delta_vs_24h_mean

from {{ ref('fct_capacity_risk') }} r
join {{ ref('int_time_features') }} t
  on r.hour_ts = t.hour_ts
join {{ ref('int_demand_features') }} d
  on r.hour_ts = d.hour_ts