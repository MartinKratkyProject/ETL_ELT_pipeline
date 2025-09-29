with raw_fire_vihecles as (
    select *
    from raw_data.table_nyc_fire_vihecles
)

select
    active,
    vehicle_license_number,
    name,
    license_type,
    expiration_date::date as expiration_date,
    permit_license_number,
    dmv_license_plate_number,
    vehicle_vin_number,
    wheelchair_accessible,
    vehicle_year::numeric as vehicle_year,
    base_number,
    base_name,
    base_type,
    base_telephone_number,
    base_address,
    certification_date::date as certification_date,
    website,
    last_date_updated::date as last_date_updated
from raw_fire_vihecles
where vehicle_license_number is not null
and permit_license_number is not null
and dmv_license_plate_number is not null
and vehicle_vin_number is not null


