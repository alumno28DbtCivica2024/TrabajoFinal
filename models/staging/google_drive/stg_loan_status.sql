{{ config(materialized='view') }}

with source as (

    select * from {{ ref('base_loan') }}

),

renamed as (

    select distinct
        {{ dbt_utils.generate_surrogate_key(['loan_status']) }} as loan_status_id,
        loan_status

    from source

)

select * from renamed