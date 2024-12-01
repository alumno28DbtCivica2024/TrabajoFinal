{{ config(materialized='view') }}

with source as (

    select * from {{ ref('base_loan') }}

),

renamed as (

    select
        member_id,
        {{ dbt_utils.generate_surrogate_key(['emp_length']) }} as emp_length_id,
        employ,
        {{ dbt_utils.generate_surrogate_key(['home_ownership']) }} as home_ownership_id,
        annual_inc,
        {{ dbt_utils.generate_surrogate_key(['verification_status']) }} as verification_status_id,
        {{ dbt_utils.generate_surrogate_key(['zip_code']) }} as zip_code_id,
        addr_state,
        dti

    from source

)

select * from renamed