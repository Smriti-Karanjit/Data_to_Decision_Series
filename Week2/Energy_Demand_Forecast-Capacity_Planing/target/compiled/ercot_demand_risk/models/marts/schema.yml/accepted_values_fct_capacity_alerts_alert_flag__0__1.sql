
    
    

with all_values as (

    select
        alert_flag as value_field,
        count(*) as n_records

    from "ercot"."main_ercot"."fct_capacity_alerts"
    group by alert_flag

)

select *
from all_values
where value_field not in (
    '0','1'
)


