{% macro correct_date(column_name) %}

   to_char(to_date({{ column_name }}, 'MON-YYYY'), 'MM-YYYY')

{% endmacro %}