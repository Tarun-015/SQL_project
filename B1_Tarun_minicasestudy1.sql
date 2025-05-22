create database project;  #making new database
use project;
select * from rental_data;  #the table is "rental_data"

# q1. Write a query to get the top 5 customers who spent the most on rentals.
select Customer_Name, Rental_Price as Total_spend 
from rental_data
order by Rental_date desc
limit 5;

# q2. Write a query to list the 3rd page of the most recent Horror genre rentals,
# assuming each page has 5 records.
select Rental_ID, Movie_Title, Rental_Date
from rental_data
where Genre="Horror"
order by rental_date desc
limit 5 offset 10;

# q3. Find all rentals over ₹200 made in the countries 'India', 'USA', or 'UK'
select Customer_Name, Country, Rental_Price
from rental_data
where Rental_Price > 200
and (Country="India" or Country="USA" or Country="UK");

# q4. Get all rentals that happened between '2024-01-01' and '2024-06-30'
select Customer_Name, Movie_Title,Rental_Date
from rental_data
where rental_Date between '2024-01-01' and '2024-06-30';  ##single quotes is compulsory otherwise empty table

# q5. Identify all records where Return_Date is not null but the Rental_Price is missing (NULL).
select Return_Date,Rental_Price
from rental_data
where Return_Date is not NULL
and Rental_Price is NULL;   #empty table

# q6. Write a query to get all rentals not in the genres 'Horror', 'Drama', or 'Thriller'.
select * from rental_data
where Genre !="Horror" and
Genre !="Drama" and
Genre !="Thriller";

#summary :-
#for what purpose concept were used
# SUM(), GROUP BY:	Total spending by customer
# LIMIT, OFFSET:	Pagination logic
# IN, WHERE:	Conditional filtering by values
# BETWEEN:	Date range filtering
# IS NULL:	Checking for missing data
# NOT IN:	Excluding certain genres
