{% snapshot payment_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='loan_id',
      strategy='check',
      check_cols=['last_pymnt_d'],
    )
}}

select 
    {{ dbt_utils.generate_surrogate_key(['loan_id','last_pymnt_d']) }} as payment_id,
    loan_id,
    last_pymnt_d,
    last_pymnt_amnt,
    next_pymnt_d,
    _fivetran_synced
from {{ ref('base_loan') }}

{% endsnapshot %}