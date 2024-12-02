{{ config(materialized='view') }}

with source as (

    select * from {{ ref('base_loan') }}

),

renamed as (

    select distinct
        {{ dbt_utils.generate_surrogate_key(['verification_status']) }} as verification_status_id,
        verification_status

    from source

)

select * from renamed