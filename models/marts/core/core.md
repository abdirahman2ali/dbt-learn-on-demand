{% docs fct_customer_orders %}

    One row per order. This view joins customers table to identify customers that purchased and brings in aggregated metrics from int_orders.

{% enddocs %}

{% docs int_orders_pivoted %}

    One row per order but payment method (ie: credit card, gift card, etc) is pivoted.

{% enddocs %}

{% docs customer_daily_summary %}

    Daily customer orders. The primary key is the combination of both customer_id and order_date.

{% enddocs %}