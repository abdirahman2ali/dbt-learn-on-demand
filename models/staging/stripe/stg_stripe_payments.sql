with

source as (

    select * from {{ ref('payments') }} -- this is from a seed file. This is not best practice but for learning purposes.

),

transformed as (

    select

        id as payment_id,
        orderid as order_id,
        status as payment_status,
        round(amount/100.0,2) as payment_amount,

    from source
)

select * from transformed