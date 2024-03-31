-- macro that converts dollars to cents. Default to 2 decimal points.

{% macro cents_to_dollars(column_name, decimal_places=2) -%}

    round({{column_name}}/100.0, {{ decimal_places }})

{%- endmacro %}