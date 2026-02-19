



select
    1
from "ercot"."main_ercot"."stg_ercot_load_1h"

where not(east_mw east_mw is null or east_mw >= 0)

