{{ config(materialized='view') }}

with fct_loan_payments as (

    select * from {{ ref('fct_loan_payments') }}

),

fct_loan_petition as (

    select * from {{ ref('fct_loan_petition') }}

),

payments_history as (

    select
        year(to_date(B.last_pymnt_d, 'MM-YYYY')) as anio_aceptacion,  
        month(to_date(B.last_pymnt_d, 'MM-YYYY')) as mes_aceptacion,
        count(*),
        floor(avg(B.last_pymnt_amnt)) as monto_pago
    from fct_loan_payments B
    right join fct_loan_petition A
    on A.loan_id=B.loan_id
    group by year(to_date(B.last_pymnt_d, 'MM-YYYY')), month(to_date(B.last_pymnt_d, 'MM-YYYY'))
    order by year(to_date(B.last_pymnt_d, 'MM-YYYY')), month(to_date(B.last_pymnt_d, 'MM-YYYY')) 

)

select * from payments_history