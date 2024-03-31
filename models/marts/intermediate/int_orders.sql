with 

-- Step 1. Import CTEs

orders as (

    select * from {{ref("stg_orders")}}

),

payments as (

    select * from {{ref("stg_payments")}}
    where payment_status != 'fail' -- exclude any orders with status that failed.

),

-- Step 2. Build the Logical CTEs

orders_totals as (

--  This CTE is calculating the total order amount per order by status.

    select

        order_id,
        payment_status,
        sum(payment_amount) as order_value_dollars 

    from payments
    group by 1,2

),

--- Step 3. Build final CTEs

final_cte as (

    select

        orders.*,
        orders_totals.payment_status,
        orders_totals.order_value_dollars

    from orders
    left join orders_totals
        on orders.order_id = orders_totals.order_id

)

--- Step 4. Select Statement

select * from final_cte 