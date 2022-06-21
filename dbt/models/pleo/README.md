### dbt installation details

This dbt environment is running in a docker container.  

Steps taken to run were as follows:

1. a pre-installed Python package management tool - miniconda
2. a local DIR on MacOS laptop with git init into which docker container github repo was cloned from https://github.com/gnilrets/dbt-container-skeleton
3. started a virtual environment in which I installed the packages listed in docker container - requrements.txt
4. built the docker image and activated the dbt shell
5. used Pycharm as editor - the free edition

### dbt version 

root@60da1873e282:/dbt-runner/dbt# dbt --version

installed version: 1.0.4

   latest version: 1.1.1


###  dbt model run

1. created a subfolder under models in dbt dir structure called pleo
2. I did not seed the raw data file in dbt - I loaded the file to GCS and then into BigQuery as table rates
3. created the relevant models

dbt run -m 