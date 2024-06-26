{{ config(materialized = 'view')}}

with

-- Step 1. Import CTEs

source as (

    select * from {{ ref("orders") }}  -- this is from a seed file. This is not best practice but for learning purposes.

),

-- Step 2. Final CTE

transformed as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status as order_status,

        case 
            when status not in ('returned','return_pending') 
            then order_date 
        end as valid_order_date,

        row_number() over (
            partition by user_id 
            order by order_date, id
        ) as user_order_seq

    from source
)

--- Step 3. Select Statement

select * from transformed