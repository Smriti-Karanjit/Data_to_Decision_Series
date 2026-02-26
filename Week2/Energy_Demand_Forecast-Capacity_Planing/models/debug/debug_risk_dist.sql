{{ config(materialized='view') }}

select
  risk_level,
  count(*) as n,
  round(100.0 * count(*) / sum(count(*)) over (), 2) as pct
from {{ ref('fct_capacity_risk') }}
group by 1
order by n desc;