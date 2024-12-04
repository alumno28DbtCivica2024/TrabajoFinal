{{ config(materialized='view') }}

with fct_loan_petition as (

    select * from {{ ref('fct_loan_petition') }}

),

dim_purpose as (

    select * from {{ ref('dim_purpose') }}

),

fct_loan_state as (

    select * from {{ ref('fct_loan_state') }}

),

general_loans as (

    select 
    A.grade as grado_riesgo,
    B.purpose as proposito,
        count(*) as numero_solicitudes_prestamos,
        sum(loan_amnt) as suma_capital_pedido,
        avg(int_rate) as media_interes,
        sum(C.funded_amnt) as suma_capital_financiado,
        floor(sum(C.funded_amnt)*avg(int_rate)/100) as ganancias_esperadas,
        floor(sum(total_pymnt)) as total_pagos_recibidos
    from fct_loan_petition A
    right join dim_purpose B
    on A.purpose_id=B.purpose_id
    right join fct_loan_state C
    on A.loan_id=C.loan_id
    group by A.grade, B.purpose
    order by grade, numero_solicitudes_prestamos desc

)

select * from general_loans