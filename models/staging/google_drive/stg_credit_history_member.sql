{{ config(
    materialized='incremental'
    ) 
    }}

WITH source AS (
    SELECT * 
    FROM {{ ref('base_loan') }}

{% if is_incremental() %}

	  WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }} )

{% endif %}
),



renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['member_id','_fivetran_synced']) }} as history_id,
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
        mths_since_last_major_derog,
        _fivetran_synced as history_date,
        _fivetran_synced

    from source

)

select * from renamed