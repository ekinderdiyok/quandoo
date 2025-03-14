# Quandoo Data Analyst Task
Applicant: Ekin Derdiyok

Contact: ekin.derdiyok@icloud.com

Tableau: https://public.tableau.com/app/profile/ekinderdiyok/vizzes

GitHub: https://github.com/ekinderdiyok

LinkedIn: https://www.linkedin.com/in/ekinderdiyok/

Date: 2025-03-14

Description: This repo contains the SQL file and Tableau Public link answering the Quandoo Data Analyst Task. Database (quandoo.db), data (.CSV files), and task brief(.PDF file) are not availabe in this repo. 

## Repo Contents
1. `quandoo.sql`: This is my SQL script
2. `README.md`: Document you are currently reading

## Steps
1. Create a local SQLite database
2. Create a .SQL script: https://github.com/ekinderdiyok/quandoo/quandoo.sql
3. Add the tables using CREATE TABLE
4. Import .CSV files into tables
5. Run data validation checks
6. Answer Question 1
7. Answer Question 2
8. Create Tableau dashboard: https://public.tableau.com/app/profile/ekinderdiyok/vizzes

## Answers to Question 1 (Available in `quandoo.sql`)
City: Singapore (based on total revenue and reservation count)
Country: Germany (based on total revenue and reservation count)
Campaign: Referral (based on total revenue and reservation count)
Note: I assumed that cancelled and no-show reservations still generate revenue, though will most likely not change the ordering.

## Answers to Question 2 (Available in Tableau)
I suggest breaking down all metrics by countries and see no value in aggregating most B2B and marketing metrics across countries. Below are the most important metrics according to my analysis: 
* CPC - Google
* CPC - Bing
* Reservations per User (How many times a user makes a reservation on average in a year per country)
* Reservations per Merchant (How many reservations on average does a merchant receive in a year per country)
* ROAS (or ACNR) would have been an important metric but cannot be calculated as the marketing_cost table does not include a revenue column. Plus, marketing_channel and marketing_subchannel categories do not match between marketing_cost and reservations tables, making it hard to join the two tables to access both the revenue and marketing cost.
* ARPU (Average Revenue Per User): How much revenue a user generates for Quandoo in 2024, in a given geo.
* Cancelation and noshow rates: May harm the merchants and make them stop working with Quandoo if they get too large.
I was unable to calculate ROAS because entries marketing_channel and marketing_subchannel columns are not matching. I think this would be the most important metric.
Customers on average reserve 1.41 times. 
Average revenue per customer is €7.07.
Facebook marketing spent has been low and may bear fruit with more investment.
CPCs are around 2-5 dollars, depending on the region and marketing subchannel (Google, Bing). More on this on the Tableau dashboard.
Each merchant received around 30-200 reservations in 2024 depending on the country. More on this on the Tableau dashboard.
Noshow and Cancellation rate hover around 3% and 15-20% respectively, with small variations across countries. More on this on the Tableau dashboard.

