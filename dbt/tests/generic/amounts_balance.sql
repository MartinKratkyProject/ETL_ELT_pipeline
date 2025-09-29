{% test amounts_balance(model) %}
    select *
    from {{ model }}
    where fine_amount + penalty_amount + interest_amount
          - reduction_amount - payment_amount
        != amount_due
{% endtest %}
