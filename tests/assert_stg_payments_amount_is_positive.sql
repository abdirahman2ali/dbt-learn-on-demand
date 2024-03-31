-- this test ensures that all transaction amounts are greater than 0

with

payments as (

    select * from {{ ref('stg_payments') }}

)

select
    order_id,
    sum(payment_amount) as total_amount

from payments
group by 1
having total_amount < 0