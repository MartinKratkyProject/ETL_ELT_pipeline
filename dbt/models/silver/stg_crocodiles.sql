with raw_crocodiles as (
    select *, row_number() over (
            partition by "Observation ID"
            order by "Date of Observation" desc
        ) as row_num
    from raw_data.table_csv_crocodiles
)

select row_num,
    "Observation ID" as observation_id,
    "Common Name" as common_name,
    "Scientific Name" as scientific_name,
    "Family" as family,
    "Genus" as genus,
    "Observed Length (m)"::numeric as observation_length_in_m,
    "Observed Weight (kg)"::numeric as observation_weight_in_kg,
    "Age Class" as age_class,
    "Sex" as sex,
    to_date("Date of Observation", 'DD-MM-YYYY') as date_of_observation,
    "Country/Region" as country,
    "Habitat Type" as habitat_type,
    "Conservation Status" as conservation_status,
    "Observer Name" as observer_name,
    "Notes" as notes
from raw_crocodiles
where "Observation ID" is not null
and "Common Name" is not null
and row_num = 1
