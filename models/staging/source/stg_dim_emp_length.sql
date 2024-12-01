{{ config(materialized='view') }}

with source as (

    select * from {{ ref('stg_per_info_members') }}

),

renamed as (

    select distinct
        {{ dbt_utils.generate_surrogate_key(['emp_length']) }} as emp_length_id,
        emp_length

    from source

)

select * from renamed