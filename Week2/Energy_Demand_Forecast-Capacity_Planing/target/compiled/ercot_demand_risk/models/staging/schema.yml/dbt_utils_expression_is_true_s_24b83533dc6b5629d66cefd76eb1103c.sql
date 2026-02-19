



select
    1
from "ercot"."main_ercot"."stg_ercot_load_1h"

where not(scent_mw scent_mw is null or scent_mw >= 0)

