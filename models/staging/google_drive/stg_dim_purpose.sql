{{ config(materialized='view') }}

with source as (

    select * from {{ ref('base_loan') }}

),

renamed as (

    select distinct
        {{ dbt_utils.generate_surrogate_key(['purpose']) }} as purpose_id,
        purpose

    from source

)

select * from renamed