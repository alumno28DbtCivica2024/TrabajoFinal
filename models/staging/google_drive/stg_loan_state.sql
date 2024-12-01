{{ config(materialized='view') }}

with source as (

    select * from {{ ref('base_loan') }}

),

renamed as (

    select
        loan_id,
        funded_amnt,
        funded_amnt_inv,
        {{ dbt_utils.generate_surrogate_key(['loan_status']) }} as loan_status_id,
        out_prncp,
        out_prncp_inv,
        total_pymnt,
        total_pymnt_inv,
        total_rec_prncp,
        total_rec_int,
        total_rec_late_fee,
        recoveries,
        collection_recovery_fee

    from source

)

select * from renamed