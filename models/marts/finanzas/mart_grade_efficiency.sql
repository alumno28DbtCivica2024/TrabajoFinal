{{ config(materialized='table') }}

with fct_credit_history_member as (

    select * from {{ ref('fct_credit_history_member') }}

),

fct_loan_petition as (

    select * from {{ ref('fct_loan_petition') }}

),

num_clientes as (

    select 
        grade,
        count(member_id) as num_clientes
    from fct_loan_petition
    group by grade
    order by grade

),

efficiency as ( 
    select 
        C.grade,
        count(A.delinq_2_yrs) as num_clientes_delincuentes,
        num_clientes
    from fct_credit_history_member A
    right join fct_loan_petition B 
    on A.member_id=B.member_id
    inner join num_clientes C
    on B.grade=C.grade
    where delinq_2_yrs is not null and delinq_2_yrs <> 0
    group by C.grade, num_clientes
    order by C.grade 
)

select
    grade,
    num_clientes_delincuentes,
    num_clientes,
    num_clientes_delincuentes/num_clientes as ratio_delincuencia
from efficiency
order by grade