with raw_civil_services as (
    select *
    from raw_data.table_nyc_civil_services
)

select
    exam_no,
    list_no,
    first_name,
    mi as middle_initial,
    last_name,
    adj_fa::numeric as adj_fa,
    list_title_code,
    list_title_desc,
    group_no,
    list_agency_code,
    list_agency_desc,
    established_date::date as established_date,
    anniversary_date::date as anniversary_date,
    extension_date::date as extension_date,
    veteran_credit,
    published_date::date as published_date
from raw_civil_services
where exam_no is not null
and list_no is not null
and first_name is not null
and last_name is not null
and adj_fa is not null
and adj_fa::numeric between 0 and 100



