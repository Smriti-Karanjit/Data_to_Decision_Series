
    
    

with all_values as (

    select
        risk_level as value_field,
        count(*) as n_records

    from "ercot"."main_ercot"."fct_capacity_risk"
    group by risk_level

)

select *
from all_values
where value_field not in (
    'LOW','MEDIUM','HIGH','EXTREME'
)


