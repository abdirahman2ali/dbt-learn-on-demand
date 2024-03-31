-- Macro that generates a series of dates on databases - better alternative to union all

{{ dbt_utils.date_spine(

    datepart = "day",
    start_date = "to_date('01/01/2015', 'mm/dd/yyyy')",
    end_date = "dateadd(year, 20, current_date)"
)

}}