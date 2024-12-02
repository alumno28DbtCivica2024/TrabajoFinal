{{ config(materialized='view') }}

with source as (

    select * from {{ ref('stg_purpose') }}

),

renamed as (

    select distinct
        purpose_id,
        purpose

    from source

)

select * from renamed