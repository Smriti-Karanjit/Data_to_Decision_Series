{{ config(materialized='table') }}

select
  l.hour_ts,
  l.ercot_mw,
  t.year,
  t.month,
  t.day_of_week,
  t.hour_of_day,
  t.is_weekend,

  lag(l.ercot_mw, 1)   over (order by l.hour_ts) as lag_1h,
  lag(l.ercot_mw, 24)  over (order by l.hour_ts) as lag_24h,
  lag(l.ercot_mw, 168) over (order by l.hour_ts) as lag_168h,

  avg(l.ercot_mw) over (order by l.hour_ts rows between 23 preceding and current row)  as roll_mean_24h,
  avg(l.ercot_mw) over (order by l.hour_ts rows between 167 preceding and current row) as roll_mean_7d

from {{ ref('stg_ercot_load_1h') }} l
join {{ ref('int_time_features') }} t
  on l.hour_ts = t.hour_ts
