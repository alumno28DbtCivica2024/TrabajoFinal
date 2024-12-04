{{ config(materialized='view') }}

with source as (

    select * from {{ ref('stg_home_ownership') }}

),

renamed as (

    select distinct
        home_ownership_id,
        home_ownership
        

    from source

)

select * from renamed