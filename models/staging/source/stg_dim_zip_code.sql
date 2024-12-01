{{ config(materialized='view') }}

with source as (

    select * from {{ ref('stg_per_info_members') }}

),

renamed as (

    select distinct
        {{ dbt_utils.generate_surrogate_key(['zip_code']) }} as zip_code_id,
        zip_code

    from source

)

select * from renamed