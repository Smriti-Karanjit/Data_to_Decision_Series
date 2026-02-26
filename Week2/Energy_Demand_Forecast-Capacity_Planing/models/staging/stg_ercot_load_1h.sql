{{ config(materialized='view') }}

-- Hourly ERCOT load (exported from Databricks CE → saved as dbt seed)
-- Guarantees numeric MW columns for downstream thresholds and risk labeling

select
  cast(hour_ts as timestamp) as hour_ts,

  try_cast(replace(cast(ercot_mw as varchar),  ',', '') as double) as ercot_mw,
  try_cast(replace(cast(coast_mw as varchar), ',', '') as double) as coast_mw,
  try_cast(replace(cast(east_mw  as varchar), ',', '') as double) as east_mw,
  try_cast(replace(cast(fwest_mw as varchar), ',', '') as double) as fwest_mw,
  try_cast(replace(cast(north_mw as varchar), ',', '') as double) as north_mw,
  try_cast(replace(cast(ncent_mw as varchar), ',', '') as double) as ncent_mw,
  try_cast(replace(cast(south_mw as varchar), ',', '') as double) as south_mw,
  try_cast(replace(cast(scent_mw as varchar), ',', '') as double) as scent_mw,
  try_cast(replace(cast(west_mw  as varchar), ',', '') as double) as west_mw

from {{ ref('ercot_load_1h') }}
where hour_ts is not null