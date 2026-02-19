
    
    

with all_values as (

    select
        scenario as value_field,
        count(*) as n_records

    from "ercot"."main_ercot"."fct_capacity_scenarios"
    group by scenario

)

select *
from all_values
where value_field not in (
    'GROWTH_2PCT','GROWTH_5PCT','GROWTH_8PCT'
)


