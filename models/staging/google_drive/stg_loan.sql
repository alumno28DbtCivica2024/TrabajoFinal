{{ config(
    materialized='incremental',
    unique_key = 'loan_id'
    ) 
    }}

with source as (

    select * from {{ ref('base_loan') }}

{% if is_incremental() %}

	  WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }} )

{% endif %}

),

renamed as (

    select
        loan_id,
        member_id,
        loan_amnt,
        term_months,
        int_rate,
        monthly_fee,
        grade,
        sub_grade,
        issue_d,
        pymnt_plan,
        desc,
        {{ dbt_utils.generate_surrogate_key(['purpose']) }} as purpose_id,
        title,
        initial_list_status,
        application_type,
        policy_code,
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
        collection_recovery_fee,
        _fivetran_synced

    from source

)

select * from renamed