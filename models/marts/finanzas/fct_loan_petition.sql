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
        purpose_id,
        title,
        initial_list_status,
        application_type,
        policy_code,
        _fivetran_synced

    from source

)

select * from renamed