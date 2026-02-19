
    
    

select
    month as unique_field,
    count(*) as n_records

from "ercot"."main_ercot"."fct_capacity_alerts"
where month is not null
group by month
having count(*) > 1


