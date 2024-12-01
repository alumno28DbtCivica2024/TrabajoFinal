{{ config(materialized='view') }}

with source as (

    select * from {{ ref('base_loan') }}

),

renamed as (

    select
        member_id,
        delinq_2_yrs,
        earliest_cr_line,
        inq_last_6_mths,
        mths_since_last_delinq,
        mths_since_last_record,
        open_acc,
        pub_rec,
        revol_bal,
        revol_util,
        total_acc,
        last_credit_pull_d,
        collections_12_mths_ex_med,
        mths_since_last_major_derog

    from source

)

select * from renamed