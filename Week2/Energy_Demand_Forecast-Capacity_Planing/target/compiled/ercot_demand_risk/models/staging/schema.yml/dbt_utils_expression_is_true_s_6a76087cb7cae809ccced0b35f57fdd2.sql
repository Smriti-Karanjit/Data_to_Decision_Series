



select
    1
from "ercot"."main_ercot"."stg_ercot_load_1h"

where not(north_mw north_mw is null or north_mw >= 0)

