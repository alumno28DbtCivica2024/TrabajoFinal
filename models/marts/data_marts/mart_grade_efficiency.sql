{{ config(materialized='table') }}

with fct_credit_history_member as (

    select * from {{ ref('fct_credit_history_member') }}

),

fct_loan_petition as (

    select * from {{ ref('fct_loan_petition') }}

),

grade_efficiency as (

    select 
        grade,
        count(A.delinq_2_yrs) as num_clientes_delincuentes
    from fct_credit_history_member A
    right join fct_loan_petition B 
    on A.member_id=B.member_id
    where delinq_2_yrs is not null and delinq_2_yrs <> 0
    group by grade
    order by grade 

)

select * from grade_efficiency