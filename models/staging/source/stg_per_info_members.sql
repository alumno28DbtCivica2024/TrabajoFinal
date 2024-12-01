{{ config(materialized='view') }}

with source as (

    select * from {{ ref('base_loan') }}

),

renamed as (

    select
        member_id,
        emp_length,
        employ,
        home_ownership,
        annual_inc,
        verification_status,
        zip_code,
        addr_state,
        dti

    from source

)

select * from renamed