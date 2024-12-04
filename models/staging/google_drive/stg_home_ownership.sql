{{ config(materialized='view') }}

with source as (

    select * from {{ ref('base_loan') }}

),

renamed as (

    select distinct
        {{ dbt_utils.generate_surrogate_key(['home_ownership']) }} as home_ownership_id,
        home_ownership
        

    from source

)

select * from renamed