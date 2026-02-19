select *
from {{ ref('stg_ercot_load_1h') }}
where ercot_mw <= 0
