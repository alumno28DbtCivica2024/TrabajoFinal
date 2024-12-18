{{ config(materialized='view') }}

with source as (

    select * from {{ ref('payment_snapshot') }}

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