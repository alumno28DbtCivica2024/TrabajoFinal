{{ config(
    materialized='incremental',
    unique_key = 'member_id'
    ) 
    }}

with source as (

    select * from {{ ref('stg_per_info_members') }}

{% if is_incremental() %}


	  WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }} )

{% endif %}

),

renamed as (

    select distinct
        member_id,
        emp_length_id,
        employ,
        home_ownership_id,
        annual_inc,
        verification_status_id,
        zip_code_id,
        addr_state,
        dti,
        _fivetran_synced

    from source

)

select * from renamed