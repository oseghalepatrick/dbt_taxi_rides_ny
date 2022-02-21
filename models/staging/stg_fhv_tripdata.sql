{{ config(materialized='view') }}

select
    -- identifiers
    {{ dbt_utils.surrogate_key(['dispatching_base_num', 'pickup_datetime', 'dropoff_datetime']) }} as tripid,
    dispatching_base_num,
    cast(pulocationid as integer) as  pickup_locationid,
    cast(dolocationid as integer) as dropoff_locationid,
    
    -- timestamps
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropoff_datetime as timestamp) as dropoff_datetime,
    
    -- trip info
    SR_Flag

from {{ source('staging','fhv_tripdata') }}
where extract(year from pickup_datetime) = 2019

-- dbt build --m <model.sql> --var 'is_test_run: false'
/*{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}*/