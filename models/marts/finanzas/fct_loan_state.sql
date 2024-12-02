{{ config(
    materialized='incremental',
    unique_key = 'loan_id'
    ) 
    }}

with source as (

    select * from {{ ref('stg_loan') }}

{% if is_incremental() %}

	  WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }} )

{% endif %}

),

renamed as (

    select
        loan_id,
        funded_amnt,
        funded_amnt_inv,
        loan_status_id,
        out_prncp,
        out_prncp_inv,
        total_pymnt,
        total_pymnt_inv,
        total_rec_prncp,
        total_rec_int,
        total_rec_late_fee,
        recoveries,
        collection_recovery_fee,
        _fivetran_synced

    from source

)

select * from renamed