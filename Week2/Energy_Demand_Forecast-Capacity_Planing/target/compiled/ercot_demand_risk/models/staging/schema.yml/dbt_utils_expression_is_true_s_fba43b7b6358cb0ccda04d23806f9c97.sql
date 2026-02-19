



select
    1
from "ercot"."main_ercot"."stg_ercot_load_1h"

where not(ercot_mw ercot_mw > 0)

