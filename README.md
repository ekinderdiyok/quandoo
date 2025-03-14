# Quandoo Data Analyst Task
Applicant: Ekin Derdiyok

**Contact:** ekin.derdiyok@icloud.com

**Tableau:** https://public.tableau.com/app/profile/ekinderdiyok/vizzes

**GitHub:** https://github.com/ekinderdiyok

**LinkedIn:** https://www.linkedin.com/in/ekinderdiyok/

**Date:** 2025-03-14

**Description:** This repo contains the `quandoo.sql` script and a [link to Tableau Public](https://public.tableau.com/app/profile/ekinderdiyok/vizzes) solving the **Quandoo Data Analyst Task**.

## Repo Contents
1. `quandoo.sql`: This is my SQL script
2. `README.md`: Document you are currently reading
3. `quandoo.db`: A local SQLite database for querying. Is not available in this repo due to space constraints, but is available on demand. Send me an email if you need it.

## Steps I took
1. Create a local SQLite database
2. Create the [quandoo.sql script](https://github.com/ekinderdiyok/quandoo/blob/main/quandoo.sql)
3. Add the tables using CREATE TABLE
4. Import .CSV files into tables
5. Run data validation checks
6. Answer Question 1
7. Answer Question 2
8. Create a Tableau dashboard: https://public.tableau.com/app/profile/ekinderdiyok/vizzes

## Answers to Question 1 (Available in `quandoo.sql`)
**City:** Singapore (based on total revenue and reservation count)

**Country:** Germany (based on total revenue and reservation count)

**Campaign:** Referral (based on total revenue and reservation count)

## Answers to Question 2 (Available in Tableau)
I suggest breaking down all metrics by countries and see no value in aggregating most B2B and marketing metrics across countries. Below are the most important metrics according to my analysis: 
* CPC - Google
* CPC - Bing
* Reservations per User (How many times a user makes a reservation on average in a year per country)
* Reservations per Merchant (How many reservations on average does a merchant receive in a year per country)
* ROAS (or ACNR) would have been an important metric but cannot be calculated as the marketing_cost table does not include a revenue column. Plus, marketing_channel and marketing_subchannel categories do not match between marketing_cost and reservations tables, making it hard to join the two tables to access both the revenue and marketing cost.
* ARPU (Average Revenue Per User): How much revenue a user generates for Quandoo in 2024, in a given country.
* Cancelation and noshow rates: May harm the merchants and make them stop working with Quandoo if they get too large.
* Facebook marketing spent has been low and may bear fruit with more investment.
