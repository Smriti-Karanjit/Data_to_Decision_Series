



select
    1
from "ercot"."main_ercot"."stg_ercot_load_1h"

where not(west_mw west_mw is null or west_mw >= 0)

