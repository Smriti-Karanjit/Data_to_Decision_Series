
    
    

select
    hour_ts as unique_field,
    count(*) as n_records

from "ercot"."main_ercot"."int_demand_features"
where hour_ts is not null
group by hour_ts
having count(*) > 1


