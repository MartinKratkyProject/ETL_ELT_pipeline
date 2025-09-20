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
    abse_telephone_number,
    base_address,
    website
from raw_fire_vihecles


