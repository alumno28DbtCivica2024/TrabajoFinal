{{ config(materialized='view') }}

with source as (

    select * from {{ ref('stg_loan_status') }}

),

renamed as (

    select distinct
        loan_status_id,
        loan_status

    from source

)

select * from renamed