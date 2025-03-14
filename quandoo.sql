-- ========================================
-- Preamble
-- ========================================

/*
Project: Quandoo Data Analyst Test
Author: Ekin Derdiyok
Contact: ekin.derdiyok@icloud.com
Tableau: https://public.tableau.com/app/profile/ekinderdiyok/vizzes
GitHub: https://github.com/ekinderdiyok
LinkedIn: https://www.linkedin.com/in/ekinderdiyok/
Date: 2025-03-14

Table of contents:
1. Create the database and tables
2. Import data from CSV files
3. Data Validity Check
4. Question 1: Identify the most important cities/countries/campaigns
5. Question 2: The most important observations
*/

-- ========================================
-- Create the database and tables
-- ========================================

-- Run the following commands in the terminal to create the database
/*
sqlite3 /Users/ekin/Documents/Projects/quandoo/quandoo.db
*/

-- Clean up the database
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS reservations;
DROP TABLE IF EXISTS marketing_cost;

-- Create merchants table
CREATE TABLE IF NOT EXISTS merchants (
    merchant_id TEXT NOT NULL PRIMARY KEY,
    city TEXT,
    merchant_country_iso3 TEXT,
    cuisine TEXT
); 

-- Create reservations table
CREATE TABLE IF NOT EXISTS reservations (
    reservation_id TEXT NOT NULL PRIMARY KEY,
    customer_id TEXT,
    reservation_created_date DATETIME,
    dining_start_date DATETIME,
    dining_end_date DATETIME,
    reservation_platform TEXT,
    reservation_status TEXT,
    merchant_id TEXT,
    FOREIGN KEY (merchant_id) REFERENCES merchants(merchant_id)
    country TEXT,
    marketing_channel TEXT,
    revenue REAL
);

-- Create marketing_cost table
CREATE TABLE IF NOT EXISTS marketing_cost (
    country TEXT,
    date DATE,
    marketing_subchannel TEXT,
    clicks INTEGER,
    impressions INTEGER,
    marketing_cost REAL,
    merchant_id TEXT
    FOREIGN KEY (merchant_id) REFERENCES merchants(merchant_id)
);

-- Check if tables are successfully created in the database
SELECT name 
FROM sqlite_master 
WHERE type='table';

-- ========================================
-- Import data from CSV files
-- ========================================

-- Open a fresh terminal, change folder path, run line by line for importing merchants.csv file
/*
sqlite3 /Users/ekin/Documents/Projects/quandoo/quandoo.db
.mode csv
.headers on
.import --skip 1 /Users/ekin/Documents/Projects/quandoo/data/merchants.csv merchants
*/

-- Open a fresh terminal, change folder path, run line by line for importing reservations.csv file
/*
sqlite3 /Users/ekin/Documents/Projects/quandoo/quandoo.db
.mode csv
.headers on
.import --skip 1 /Users/ekin/Documents/Projects/quandoo/data/reservations.csv reservations
*/

-- Open a fresh terminal, change folder path, run line by line for importing marketing_cost.csv file
/*
sqlite3 /Users/ekin/Documents/Projects/quandoo/quandoo.db
.mode csv
.headers on
.import --skip 1 /Users/ekin/Documents/Projects/quandoo/data/marketing_cost.csv marketing_cost
*/

-- ========================================
-- Data Validity Check
-- ========================================

/* 
!! For two reservations dining start date comes after the dining end date. Though this is more of an AM PM issue !!
!! There is a typo in Neapolitan cuisine. It is written as "NeapolITn" though this has no impact on the analysis. This is likely due to a Find + Replace operation in the data where ITA was replaced with IT.!!
!! There is a typo in Italian cuisine. It is written as "ITlian" though this has no impact on the analysis. This is likely due to a Find + Replace operation in the data where ITA was replaced with IT.!!
!! For 1784 reservations, revenue is below one cent. This might be due to a data entry error or some promotion !!
No missing values in any of the columns.
Time ranges seem reasonable.
No alternative spelling for categorical variables like cities, countries, or campaigns.
No leading or trailing spaces in categorical variables.
marketing_subchannel Facebook seem to generate 10k+ impressions with €2-7, this is likely an error due to grouping organic social and paid social.
*/

-- Check if data are successfully imported to the tables
SELECT * FROM merchants LIMIT 5;
SELECT * FROM reservations LIMIT 5;
SELECT * FROM marketing_cost LIMIT 5;

-- Count the total number of rows
SELECT COUNT(*) FROM merchants;
SELECT COUNT(*) FROM reservations;
SELECT COUNT(*) FROM marketing_cost;

-- Check the time range of the data
SELECT MIN(reservation_created_date) AS min_date, MAX(reservation_created_date) AS max_date FROM reservations;
SELECT MIN(dining_start_date) AS min_date, MAX(dining_start_date) AS max_date FROM reservations;
SELECT MIN(dining_end_date) AS min_date, MAX(dining_end_date) AS max_date FROM reservations;
SELECT MIN(date) AS min_date, MAX(date) AS max_date FROM marketing_cost;

-- Find missing values in any of the columns in the tables
SELECT COUNT(*) FROM merchants WHERE merchant_id IS NULL OR city IS NULL OR merchant_country_iso3 IS NULL OR cuisine IS NULL;
SELECT COUNT(*) FROM reservations WHERE reservation_id IS NULL OR customer_id IS NULL OR reservation_created_date IS NULL OR dining_start_date IS NULL OR dining_end_date IS NULL OR reservation_platform IS NULL OR reservation_status IS NULL OR merchant_id IS NULL OR country IS NULL OR marketing_channel IS NULL OR revenue IS NULL;
SELECT COUNT(*) FROM marketing_cost WHERE country IS NULL OR date IS NULL OR marketing_subchannel IS NULL OR clicks IS NULL OR impressions IS NULL OR marketing_cost IS NULL OR merchant_id IS NULL;

-- !! For these two reservations, the dining start date is after the dining end date. !!
SELECT *
FROM reservations
WHERE dining_start_date > dining_end_date;

-- See if there are any reservations where the dining start date is in the future and the reservation status is noshow. Logically this would not make sense
SELECT *
FROM reservations
WHERE dining_start_date > CURRENT_DATE
AND reservation_status = 'noshow';

-- Find alternative spellings for categorical variables like cities, countries, and campaigns
SELECT DISTINCT city FROM merchants;
SELECT DISTINCT country FROM reservations;
SELECT DISTINCT marketing_channel FROM reservations;
SELECT DISTINCT marketing_subchannel FROM marketing_cost;
SELECT DISTINCT cuisine FROM merchants;
SELECT DISTINCT merchant_country_iso3 FROM merchants;
SELECT DISTINCT reservation_platform FROM reservations;
SELECT DISTINCT reservation_status FROM reservations;

-- Find leading or trailing spaces in categorical variables
SELECT DISTINCT city FROM merchants WHERE city LIKE ' %' OR city LIKE '% ';
SELECT DISTINCT country FROM reservations WHERE country LIKE ' %' OR country LIKE '% ';
SELECT DISTINCT marketing_channel FROM reservations WHERE marketing_channel LIKE ' %' OR marketing_channel LIKE '% ';
SELECT DISTINCT marketing_subchannel FROM marketing_cost WHERE marketing_subchannel LIKE ' %' OR marketing_subchannel LIKE '% ';
SELECT DISTINCT cuisine FROM merchants WHERE cuisine LIKE ' %' OR cuisine LIKE '% ';
SELECT DISTINCT merchant_country_iso3 FROM merchants WHERE merchant_country_iso3 LIKE ' %' OR merchant_country_iso3 LIKE '% ';
SELECT DISTINCT reservation_platform FROM reservations WHERE reservation_platform LIKE ' %' OR reservation_platform LIKE '% ';
SELECT DISTINCT reservation_status FROM reservations WHERE reservation_status LIKE ' %' OR reservation_status LIKE '% ';

-- Find minimum and maximum values for numerical variables
SELECT MIN(revenue) AS min_revenue, MAX(revenue) AS max_revenue FROM reservations;
SELECT MIN(clicks) AS min_clicks, MAX(clicks) AS max_clicks FROM marketing_cost;
SELECT MIN(impressions) AS min_impressions, MAX(impressions) AS max_impressions FROM marketing_cost;
SELECT MIN(marketing_cost) AS min_cost, MAX(marketing_cost) AS max_cost FROM marketing_cost;

-- Find reservations where revenue is super small but not zero
SELECT *
FROM reservations
WHERE revenue < 0.01
AND revenue > 0;

-- Find marketing_cost with most impressions
SELECT *
FROM marketing_cost
ORDER BY impressions DESC
LIMIT 5;

-- ========================================
-- Question 1: Identify the most important cities/countries/campaigns
-- ========================================

-- ANSWERS
/* 
City: Singapore (based on total revenue and reservation count)
Country: Germany (based on total revenue and reservation count)
Campaign: Referral (based on total revenue and reservation count)
Note: I assumed that cancelled and no-show reservations still generate revenue, though will most likely not change the ordering.
*/

-- Find the top 5 cities with the highest revenue
SELECT city, SUM(revenue) AS total_revenue
FROM merchants
JOIN reservations
ON merchants.merchant_id = reservations.merchant_id
GROUP BY city
ORDER BY total_revenue DESC
LIMIT 5;

-- Find the top 5 countries with the highest revenue
SELECT country, SUM(revenue) AS total_revenue
FROM reservations
GROUP BY country
ORDER BY total_revenue DESC
LIMIT 5;

-- Find the top 5 marketing channels with the highest revenue
SELECT marketing_channel, SUM(revenue) AS total_revenue
FROM reservations
GROUP BY marketing_channel
ORDER BY total_revenue DESC
LIMIT 5;

-- Find the top 5 cities with the highest reservation count
SELECT city, COUNT(reservation_id) AS total_reservations
FROM merchants
RIGHT JOIN reservations
ON merchants.merchant_id = reservations.merchant_id
GROUP BY city
ORDER BY total_reservations DESC
LIMIT 5;

-- Find the top 5 countries with the highest reservation count
SELECT country, COUNT(reservation_id) AS total_reservations
FROM reservations
GROUP BY country
ORDER BY total_reservations DESC
LIMIT 5;

-- Find the top 5 marketing channels leading to the highest reservation count
SELECT marketing_channel, COUNT(reservation_id) AS total_reservations
FROM reservations
GROUP BY marketing_channel
ORDER BY total_reservations DESC
LIMIT 5;

-- ========================================
-- Question 2: The most important observations
-- ========================================

-- ANSWERS
/* 
I was unable to calculate ROAS because entries marketing_channel and marketing_subchannel columns are not matching. I think this would be the most important metric.
Customers on average reserve 1.41 times. 
Average revenue per customer is €7.07.
Facebook marketing spent has been low and may bear fruit with more investment.
CPCs are around 2-5 dollars, depending on the region and marketing subchannel (Google, Bing). More on this on the Tableau dashboard.
Each merchant received around 30-200 reservations in 2024 depending on the country. More on this on the Tableau dashboard.
Noshow and Cancellation rate hover around 3% and 15-20% respectively, with small variations across countries. More on this on the Tableau dashboard.
*/

-- Find the average number of reservations per customer
SELECT ROUND(AVG(reservation_count), 2) AS avg_reservations_per_customer
FROM (
    SELECT customer_id, COUNT(reservation_id) AS reservation_count
    FROM reservations
    GROUP BY customer_id
);

-- Find the average revenue per customer, not by reservation
SELECT ROUND(AVG(revenue), 2) AS avg_revenue_per_customer
FROM (
    SELECT customer_id, SUM(revenue) AS revenue
    FROM reservations
    GROUP BY customer_id
);

-- Find total revenue by marketing channel
SELECT marketing_channel, SUM(revenue) AS total_revenue
FROM reservations
GROUP BY marketing_channel
ORDER BY total_revenue DESC;

-- Find total spent by marketing channel
SELECT marketing_subchannel, SUM(marketing_cost) AS total_cost
FROM marketing_cost
GROUP BY marketing_subchannel
ORDER BY total_cost DESC;
