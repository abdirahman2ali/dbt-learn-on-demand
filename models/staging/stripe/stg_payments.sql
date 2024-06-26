{{ config(materialized = 'view')}}

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
        {{ cents_to_dollars('amount') }} as payment_amount,

    from source
)

--- Step 3. Select Statement

select * from transformed