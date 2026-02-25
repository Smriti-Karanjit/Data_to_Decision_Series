{{ config(materialized='table') }}

select
  r.hour_ts,
  r.ercot_mw,
  r.risk_level,

  -- calendar enrichments (needed by schema.yml tests)
  extract('year'  from r.hour_ts) as year,
  extract('month' from r.hour_ts) as month,
  extract('hour'  from r.hour_ts) as hour_of_day,
  cast(strftime(r.hour_ts, '%w') as integer) as day_of_week,  -- 0=Sun..6=Sat
  case
    when strftime(r.hour_ts, '%w') in ('0','6') then 1
    else 0
  end as is_weekend,

  -- demand features
  d.lag_1h,
  d.lag_24h,
  d.lag_168h,
  d.roll_mean_24h,
  d.roll_mean_7d,

  (r.ercot_mw - d.roll_mean_24h) as delta_vs_24h_mean

from {{ ref('fct_capacity_risk') }} r
join {{ ref('int_demand_features') }} d
  on r.hour_ts = d.hour_ts