{{ config(materialized='view') }}

with source as (

    select * from {{ ref('base_loan') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['loan_id','last_pymnt_d']) }} as payment_id,
        loan_id,
        last_pymnt_d,
        last_pymnt_amnt,
        next_pymnt_d

    from source

)

select * from renamed