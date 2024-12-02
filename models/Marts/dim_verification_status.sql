{{ config(materialized='view') }}

with source as (

    select * from {{ ref('stg_verification_status') }}

),

renamed as (

    select distinct
        verification_status_id,
        verification_status

    from source

)

select * from renamed