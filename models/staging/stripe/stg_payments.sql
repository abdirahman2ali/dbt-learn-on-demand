with

-- Step 1. Import CTEs

source as (

    select * from {{ ref('payments') }} -- this is from a seed file. This is not best practice but for learning purposes.

),

-- Step 2. Final CTE

transformed as (

    select

        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status as payment_status,
        round(amount/100.0,2) as payment_amount,

    from source
)

--- Step 3. Select Statement

select * from transformed