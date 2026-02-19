{{ config(materialized='view') }}

-- Hourly ERCOT load (exported from Databricks CE, loaded via dbt seed)

select
    cast(hour_ts as timestamp) as hour_ts,

    cast(ercot_mw as double) as ercot_mw,
    cast(coast_mw as double) as coast_mw,
    cast(east_mw  as double) as east_mw,
    cast(fwest_mw as double) as fwest_mw,
    cast(north_mw as double) as north_mw,
    cast(ncent_mw as double) as ncent_mw,
    cast(south_mw as double) as south_mw,
    cast(scent_mw as double) as scent_mw,
    cast(west_mw  as double) as west_mw

from {{ ref('ercot_load_1h') }}
where hour_ts is not null
