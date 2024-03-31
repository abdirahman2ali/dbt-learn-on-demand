{{ config(materialized = 'view')}}

with

-- Step 1. Import CTEs

source as (

    select * from {{ ref('customers') }}  -- this is from a seed file. This is not best practice but for learning purposes.

),

-- Step 2. Final CTE

transformed as (

    select 
        id as customer_id,
        last_name as surname,
        first_name as givenname,
        first_name || ' ' || last_name as full_name

    from source
)

--- Step 3. Select Statement

select * from transformed