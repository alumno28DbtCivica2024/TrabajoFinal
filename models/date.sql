{{
    config(
        materialized = "table"
    )
}}
with date_dimension as (
    {{ dbt_date.get_date_dimension("2010-01-01", "2020-12-31") }}
)
select distinct
    to_char(date_trunc('month',date_day),'MM-YYYY') as date,
    month_of_year,
    month_name,
    month_name_short,
    quarter_of_year,
    year_number
from
    date_dimension