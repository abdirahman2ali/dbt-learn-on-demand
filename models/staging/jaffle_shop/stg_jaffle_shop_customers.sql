with

source as (

    select * from {{ ref('customers') }}  -- this is from a seed file. This is not best practice but for learning purposes.

),

transformed as (

    select 
        id as customer_id,
        last_name as surname,
        first_name as givenname,
        first_name || ' ' || last_name as full_name

    from source
)

select * from transformed