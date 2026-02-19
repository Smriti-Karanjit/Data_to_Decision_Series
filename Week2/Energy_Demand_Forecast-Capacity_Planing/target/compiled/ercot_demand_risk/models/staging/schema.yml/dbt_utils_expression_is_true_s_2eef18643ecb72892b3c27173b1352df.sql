



select
    1
from "ercot"."main_ercot"."stg_ercot_load_1h"

where not(ncent_mw ncent_mw is null or ncent_mw >= 0)

