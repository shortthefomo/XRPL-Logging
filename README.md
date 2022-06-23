# XRPL-Logging
This is the backend to the threexrp.dev site where CEX and DEX data is abstracted from the XRPL. The data then saved from this service is used to query and build out the views.


Added the Schema, you will need advanced knowledge of materialized views here is the basis of what I used to get to understand them https://fromdual.com/mysql-materialized-views

Steps to stanup up env.
1. clone repo
2. add schema to a MySQL instance
3. copy .env-sample to .env and alter variables as needed
4. run npm install
5. run yarn dev
