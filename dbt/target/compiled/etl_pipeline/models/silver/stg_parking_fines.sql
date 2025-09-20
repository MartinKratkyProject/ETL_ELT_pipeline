with raw_parking as (
    select *
    from raw_data.table_nyc_parking_fines
)

select
    plate,
    state,
    license_type,
    summons_number,
    issue_date::date as issue_date,
    violation,
    fine_amount::numeric as fine_amount,
    penalty_amount::numeric as penalty_amount,
    interest_amount::numeric as interest_amount,
    reduction_amount::numeric as reduction_amount,
    payment_amount::numeric as payment_amount,
    amount_due::numeric as amount_due
from raw_parking
where plate is not null
and summons_number is not null
and issue_date is not null
-- and amount_due::numeric > 200