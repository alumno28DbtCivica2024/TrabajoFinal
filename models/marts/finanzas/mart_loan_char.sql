{{ config(materialized='table') }}

with fct_loan_petition as (

    select * from {{ ref('fct_loan_petition') }}

),

loan_char as (

    select 
        term_months as numero_meses,
        pymnt_plan as plan_pago,
        application_type as tipo_prestamo,
        initial_list_status as estado_prestamo,
        count(loan_id) as numero_prestamos
    from fct_loan_petition
    group by numero_meses, pymnt_plan, application_type, initial_list_status, policy_code

)



select * from loan_char