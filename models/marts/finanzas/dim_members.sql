{{ config(materialized='view') }}

with source as (

    select distinct
        member_id,
        employ,
        E.emp_length,
        D.home_ownership,
        annual_inc,
        B.verification_status,
        C.zip_code,
        addr_state,
        dti,
        _fivetran_synced 
    from {{ ref('stg_per_info_members') }} A
    right join {{ ref('stg_verification_status') }} B
    on A.verification_status_id=B.verification_status_id
    right join {{ ref('stg_zip_code') }} C
    on A.zip_code_id=C.zip_code_id
    right join {{ ref('stg_home_ownership') }} D
    on A.home_ownership_id=D.home_ownership_id
    right join {{ ref('stg_emp_length') }} E
    on A.emp_length_id=E.emp_length_id


),

renamed as (

    select distinct
        *

    from source

)

select * from renamed