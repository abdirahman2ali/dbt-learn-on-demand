{{ config(materialized = 'table')}}

select

    {{ dbt_utils.surrogate_key(['customer_id', 'order_date'])}} as id,
    customer_id,
    order_date,
    count(distinct order_id) as total_orders

from {{ ref('stg_orders') }}
group by 1,2,3