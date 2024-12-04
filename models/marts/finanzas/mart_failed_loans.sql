{{ config(materialized='view') }}

with fct_loan_petition as (

    select * from {{ ref('fct_loan_petition') }}

),

fct_loan_state as (

    select * from {{ ref('fct_loan_state') }}

),

failed_loans as (

    select 
        grade,
        count(*) as numero_prestamos,
        floor(sum(total_rec_late_fee)) as recaudacion_penalizaciones,
        floor(sum(recoveries)) as recuperacion_tras_incumplimiento,
        floor(sum(collection_recovery_fee)) as costes_recuperacion
    from fct_loan_petition A
    inner join fct_loan_state B
    on A.loan_id=B.loan_id
    group by grade
    order by grade

)



select * from failed_loans