{{ config(materialized='view') }}

with source as (

    select * from {{ ref('stg_emp_length') }}

),

renamed as (

    select distinct
        emp_length_id,
        emp_length

    from source

)

select * from renamed