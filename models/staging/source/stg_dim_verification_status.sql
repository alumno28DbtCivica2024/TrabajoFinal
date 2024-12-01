{{ config(materialized='view') }}

with source as (

    select * from {{ ref('stg_per_info_members') }}

),

renamed as (

    select distinct
        {{ dbt_utils.generate_surrogate_key(['verification_status']) }} as verification_status,
        verification_status

    from source

)

select * from renamed