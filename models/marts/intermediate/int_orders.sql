with 

orders as (

    select * from {{ref("stg_jaffle_shop_orders")}}

),

payments as (

    select * from {{ref("stg_stripe_payments")}}
    where payment_status != 'fail'

),

orders_totals as (

    select

        order_id,
        payment_status,
        sum(payment_amount) as order_value_dollars

    from payments
    group by 1,2

),

final_cte as (

    select

        orders.*,
        orders_totals.payment_status,
        orders_totals.order_value_dollars

    from orders
    left join orders_totals
        on orders.order_id and orders_totals.order_id

)

select * from final_cte