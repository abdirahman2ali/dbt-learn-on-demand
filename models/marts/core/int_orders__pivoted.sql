{{ config(materialized = 'table')}}
{%- set payment_method = ['bank_transfer', 'coupon', 'credit_card', 'gift_card'] -%}

with

payments as (

    select * from {{ ref('stg_payments') }}

),

pivoted as (

    select 

        order_id,

        {% for type in payment_method -%} -- go through list of payment methods
        
            sum(case when payment_method = '{{ type }}' then payment_amount else 0 end ) as {{type}}_amount

        {%- if not loop.last -%}

            , -- if the loop is NOT last then add the comma else 

        {%- endif %}
        
        {% endfor -%}
    
    from payments
    where payment_status = 'success'
    group by 1

)

select * from pivoted
