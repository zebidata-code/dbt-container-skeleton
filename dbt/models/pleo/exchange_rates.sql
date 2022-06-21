WITH split_rates AS
(
  SELECT
  time,
  rates,
  SPLIT(rates,',') AS split_value
  --loaded into GCS first and then into bq - I did not seed this in dbt but could have
  FROM {{ ref('rates') }}
),

split_currenty_value AS
(
  SELECT
  time,

  --extracts only the letters - thus they can any length
  REGEXP_EXTRACT(split_values, r'[a-zA-Z]+') AS currency_name,
  --extracts only the numbers and .(dots for the decimal place
  REGEXP_EXTRACT(split_values, r'[0-9\.]+') AS currency_value,
  DATE(time) AS date,
  DATE_TRUNC(DATE(time), MONTH) AS month

  FROM split_rates
  CROSS JOIN UNNEST(split_value) AS split_values
),

currency_value_month AS
(
  SELECT
  *,
  DENSE_RANK() OVER(PARTITION BY month ORDER BY date ASC ) AS _row_order
  FROM split_currenty_value
)

SELECT *
FROM currency_value_month
WHERE _row_order = 1

--the transpose PIVOT also expects to have the row values which to pivot - thus not a dynamic issue of columns as was hoping

-- no time to implement the new solution see challange_diary for description of what follows





