{{ config(
    materialized='incremental',
    unique_key = 'loan_id'
    ) 
    }}

with source as (

    select * from {{ source('google_drive', 'loan') }}

{% if is_incremental() %}

	  WHERE cast(_fivetran_synced as timestamp_ntz(9)) > (SELECT MAX(_fivetran_synced) FROM {{ this }} )

{% endif %}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['id']) }} as loan_id,
        {{ dbt_utils.generate_surrogate_key(['member_id']) }} as member_id,
        cast(loan_amnt as int) as loan_amnt,
        cast(funded_amnt as int) as funded_amnt,
        cast(funded_amnt_inv as int) as funded_amnt_inv,
        cast(left(trim(term), 2) as int) as term_months,
        int_rate,
        installment as monthly_fee,
        trim(grade) as grade,
        trim(sub_grade) as sub_grade,
        coalesce(emp_title, 'Unemployed') as employ,
        case when trim(emp_length)='n/a' then null else trim(emp_length) end as emp_length,
        trim(home_ownership) as home_ownership,
        floor(case when annual_inc is null then 0 else annual_inc end) as annual_inc,
        trim(verification_status) as verification_status,
        {{ correct_date('issue_d') }} as issue_d,
        trim(loan_status) as loan_status,
        cast(case when pymnt_plan='y' then TRUE else FALSE end as boolean) as pymnt_plan,
        trim(url) as url,
        trim(desc) as desc,
        trim(purpose) as purpose,
        lower(trim(title)) as title,
        trim(zip_code) as zip_code,
        trim(addr_state) as addr_state,
        dti,
        cast(delinq_2_yrs as int) as delinq_2_yrs,
        {{ correct_date('earliest_cr_line') }} as earliest_cr_line,
        cast(inq_last_6_mths as int) as inq_last_6_mths,
        cast(mths_since_last_delinq as int) as mths_since_last_delinq,
        cast(mths_since_last_record as int) as mths_since_last_record,
        cast(open_acc as int) as open_acc,
        cast(pub_rec as int) as pub_rec,
        revol_bal,
        revol_util,
        cast(total_acc as int) as total_acc,
        case when initial_list_status='f' then 'funded' else 'waitlist'end as initial_list_status,
        out_prncp,
        out_prncp_inv,
        round(total_pymnt, 2) as total_pymnt,
        total_pymnt_inv,
        total_rec_prncp,
        total_rec_int,
        total_rec_late_fee,
        recoveries,
        round(collection_recovery_fee, 2) as collection_recovery_fee,
        {{ correct_date('last_pymnt_d') }} as last_pymnt_d,
        last_pymnt_amnt,
        {{ correct_date('next_pymnt_d') }} as next_pymnt_d,
        {{ correct_date('last_credit_pull_d') }} as last_credit_pull_d,
        collections_12_mths_ex_med,
        cast(mths_since_last_major_derog as int) as mths_since_last_major_derog,
        case when policy_code=1 then 'Public' else 'No public' end as policy_code,
        trim(application_type) as application_type,
        floor(annual_inc_joint) as annual_inc_joint,
        dti_joint,
        trim(verification_status_joint) as verification_status_joint,
        acc_now_delinq,
        tot_coll_amt,
        tot_cur_bal,
        open_acc_6_m,
        open_il_6_m,
        open_il_12_m,
        open_il_24_m,
        mths_since_rcnt_il,
        total_bal_il,
        il_util,
        open_rv_12_m,
        open_rv_24_m,
        max_bal_bc,
        all_util,
        total_rev_hi_lim,
        inq_fi,
        total_cu_tl,
        abs(inq_last_12_m) as inq_last_12_m,
        cast(_fivetran_synced as timestamp_ntz(9)) as _fivetran_synced 

    from source

)

select * from renamed