### Original Impression

The requirement was to make the code easier to maintain.  
This is a development requirement and the principal idea was to totally avoid having to type out each currency code.
* The successful delivery was to dynamically issue all the column names through code.
 

Initially, I wanted to create an array inside each time record which I could UNNEST to create 
* (1 unique date record x number of currencies) as total number of rows - each currency being split into two columns 
  * currency_name STRING
  * currency_value FLOAT

The next step was to transpose the currency_name from rows into columns, each with the associated currency_value underneath in a row for each date.  

I underestimated the problem at hand and began using BigQuery JSON functions.  The crux of the matter is that the keys in the list of currencies are 
variable and need to be extracted by individual name.  

It took around 30-45 minutes of the allocated time slot to realize this problem - having used most of the json bq functions to no avail.

Next up I decided to use STRING functions
* SPLIT was used to create the array needed
* REGEX was used to create the columns 

The array UNNEST and date manipulations followed.
This was pretty straight forward and compleated in another 30 mins of the allocated timeframe.

The following challenge which I have not been able to solve with SQL was the PIVOT bq function.
This PIVOT also expects the row values - ie spelling out the currency_names again - defeating the purpose of my proposed solution.

I spent over 45 minutes on stackoverflow attempting to figure out how to dynamically PIVOT on all rows. 

I then considered the power of dbt Jinja and dbt macros in being able to issue the currency list dynamically.
I have not had time to implement this as all the work so far was executed straight in bigquery and no dbt yet.

The dbt installation and creating the necessary files for submission took another 60 mins - bringing the time spent on this way past the suggested 90 mins and potentially towards disqualification.


So, my solution now at the end is as follows:

1. get_column_values macro - https://github.com/dbt-labs/dbt-utils/tree/0.8.6/#get_column_values-source
2. put the results in a {% set currency_name = get_column_values()
3. create jinja to loop through each currency_name and issue a column





