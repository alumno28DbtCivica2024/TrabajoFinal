{{ config(materialized='table') }}

with source as (

    select * from {{ ref('payment_snapshot') }}

),

renamed as (

    select
        payment_id,
        loan_id,
        last_pymnt_d,
        last_pymnt_amnt,
        next_pymnt_d

    from source

)

select * from renamed