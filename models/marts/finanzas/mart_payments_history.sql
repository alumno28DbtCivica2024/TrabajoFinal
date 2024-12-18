{{ config(materialized='view') }}

with fct_loan_payments as (

    select * from {{ ref('fct_loan_payments') }}

),

payments_history as (

    select
        year(to_date(B.last_pymnt_d, 'MM-YYYY')) as anio_pago,  
        month(to_date(B.last_pymnt_d, 'MM-YYYY')) as mes_pago,
        count(*) as num_pagos,
        floor(avg(B.last_pymnt_amnt)) as media_pago
    from fct_loan_payments B
    group by year(to_date(B.last_pymnt_d, 'MM-YYYY')), month(to_date(B.last_pymnt_d, 'MM-YYYY'))
    order by year(to_date(B.last_pymnt_d, 'MM-YYYY')), month(to_date(B.last_pymnt_d, 'MM-YYYY')) 

)

select * from payments_history
order by anio_pago