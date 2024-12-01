{{ config(materialized='view') }}

with source as (

    select * from {{ ref('base_loan') }}

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
        purpose,
        title,
        initial_list_status,
        application_type,
        policy_code

    from source

)

select * from renamed