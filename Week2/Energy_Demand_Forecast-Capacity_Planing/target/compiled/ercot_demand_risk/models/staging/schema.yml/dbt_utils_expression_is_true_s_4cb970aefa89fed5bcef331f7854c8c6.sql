



select
    1
from "ercot"."main_ercot"."stg_ercot_load_1h"

where not(fwest_mw fwest_mw is null or fwest_mw >= 0)

