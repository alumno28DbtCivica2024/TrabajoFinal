{{ config(materialized='view') }}

with source as (

    select * from {{ ref('stg_zip_code') }}

),

renamed as (

    select distinct
        zip_code_id,
        zip_code

    from source

)

select * from renamed