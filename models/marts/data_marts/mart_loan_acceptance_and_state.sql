{{ config(materialized='table') }}

with fct_loan_petition as (

    select * from {{ ref('fct_loan_petition') }}

),

fct_loan_state as (

select * from {{ ref('fct_loan_state') }}

),

dim_loan_status as (

select * from {{ ref('dim_loan_status') }}

),

loan_acceptance_and_state as (

    select 
        D.loan_status,
        year(to_date(A.issue_d, 'MM-YYYY')) as anio_aceptacion,
        month(to_date(A.issue_d, 'MM-YYYY')) as mes_aceptacion,
        count(A.loan_id) as numero_prestamos
    from fct_loan_petition A
    right join fct_loan_state C
    on A.loan_id=C.loan_id
    right join dim_loan_status D
    on C.loan_status_id=D.loan_status_id
    group by D.LOAN_STATUS, year(to_date(A.issue_d, 'MM-YYYY')), month(to_date(A.issue_d, 'MM-YYYY'))
    order by D.loan_status, year(to_date(A.issue_d, 'MM-YYYY')), month(to_date(A.issue_d, 'MM-YYYY'))

)

select * from loan_acceptance_and_state