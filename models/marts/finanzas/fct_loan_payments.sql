{{ config(materialized='table') }}

with source as (

    select * from {{ ref('stg_loan_payments') }}

),

renamed as (

    select
        payment_id,
        loan_id,
        last_pymnt_d,
        last_pymnt_amnt,
        next_pymnt_d,
        dbt_valid_from,
        dbt_valid_to

    from source

)

select * from renamed