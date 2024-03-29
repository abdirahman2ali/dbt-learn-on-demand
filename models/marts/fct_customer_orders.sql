with 

--- Step 1. Import CTEs

orders as (

    select * from {{ ref('int_orders') }}

),

customers as (

    select * from {{ref("stg_jaffle_shop_customers")}}

),

--- Step 2. Build the Logical CTEs

customer_order_history as (

    select

        customers.customer_id,
        customers.surname,
        customers.givenname,
        customers.full_name, 

        min(orders.valid_order_date) as first_order_date,

        max(orders.valid_order_date) as last_order_date,

        coalesce(max(orders.user_order_seq),0) as order_count,

        coalesce(count(case 
            when orders.valid_order_date is not null
            then 1 
        end),0) as non_returned_order_count,

        sum(case 
            when orders.valid_order_date is not null
            then orders.order_value_dollars
            else 0 
        end) as total_lifetime_value,

        sum(case 
            when orders.valid_order_date is not null
            then orders.order_value_dollars
            else 0 
        end)
            /nullif(count(case 
            when orders.valid_order_date is not null
            then 1 
        end),0) as avg_non_returned_order_value,
        
        array_agg(distinct orders.order_id) as order_ids

    from orders

    join customers

    on orders.customer_id = customers.customer_id

    group by 1,2,3,4

),
--- Step 3. Build final CTEs

final_cte as (

    select 

        orders.order_id,
        orders.customer_id,
        customers.surname,
        customers.givenname,
        first_order_date,
        last_order_date,
        order_count,
        total_lifetime_value,
        orders.order_value_dollars,
        orders.order_status as order_status,
        orders.payment_status

    from orders

    join  customers

    on orders.customer_id = customers.customer_id

    join  customer_order_history

    on orders.customer_id = customer_order_history.customer_id

)
--- Step 4. Simple Select Statement

select * from final_cte
