## SQL mini-project-2

use sakila;
select * from customer;
select * from rental;

## Find the top 5 customers who have spent the most money on rentals.
select first_name,last_name,sum(amount) as money_spent
 from customer cu
 join payment py 
 on cu.customer_id = py.customer_id
 group by cu.customer_id
 order by money_spent desc limit 5;
 
## List all customers who have rented films from every store.
 ## Display Firstname, Lastname and Money Spent
 select first_name,last_name,sum(amount) as money_spent
 from customer cu
 join payment py 
 on cu.customer_id = py.customer_id
 join rental r
 on cu.customer_id = r.customer_id
 join inventory i
 on r.inventory_id = i.inventory_id 
 group by cu.customer_id
 having COUNT(DISTINCT i.store_id
 ) = (select COUNT(*) FROM store)
 order by money_spent desc
;


##Calculate the average rental duration (in days) for each film category.
##Display Film_Category and Rental Duration
select name,round(avg(DATEDIFF(return_date, rental_date)),2) AS avg_duration_days 
from rental r 
join inventory i 
on r.inventory_id = i.inventory_id
join film_category fc
on i.film_id = fc.film_id
join category ct
on fc.category_id = ct.category_id
group by ct.name;


## Find the actor who has acted in the highest number of films.
## Display Full Name of the actor and No of Films.
select * from film_actor;
select * from inventory;
select concat(first_name," ",last_name) as Full_name ,COUNT(fa.film_id) as No_of_films 
 from actor ac
join film_actor fa
on ac.actor_id = fa.actor_id
group by ac.actor_id
order by No_of_films desc ;


## List customers who rented more than the average number of rentals per
## customer. (Use a subquery)
## Display Customer Full Name and No of Rentals
SELECT concat(first_name," ",last_name) as Full_Name, COUNT(*) AS No_Of_Rentals
FROM rental r 
join customer c 
on r.customer_id = c.customer_id
GROUP BY r.customer_id;


## Determine which city has generated the highest total rental revenue.
## Display City Name, Country Name, Total_Revenue.
select city,country,sum(amount) as Total_Payment from payment py
join rental r
on py.rental_id = r.rental_id
join inventory i
on r.inventory_id = i.inventory_id
join store s
on i.store_id = s.store_id
join address ad
on s.address_id = ad.address_id
join city ct
on ad.city_id = ct.city_id
join country con
on ct.country_id = con.country_id
group by ct.city_id
order by Total_Payment desc
limit 1 ;

## Find the top 3 most rented films in each category. (Use window functions)
## Display Movie Title, No_of_Rentals, Revenue_Generated
select 
    c.name AS category_name,
    f.title AS movie_title,
    rental_stats.no_of_rentals,
    rental_stats.revenue_generated
FROM (
    select 
        fc.category_id,
        i.film_id,
        COUNT(r.rental_id) AS no_of_rentals,
        SUM(p.amount) AS revenue_generated,
        RANK() OVER (PARTITION BY fc.category_id ORDER BY COUNT(r.rental_id) DESC) AS rental_rank
    FROM 
        rental r
    JOIN 
        inventory i ON r.inventory_id = i.inventory_id
    JOIN 
        film_category fc ON i.film_id = fc.film_id
    JOIN 
        payment p ON r.rental_id = p.rental_id
    GROUP BY 
        fc.category_id, i.film_id
) AS rental_stats
JOIN film f ON rental_stats.film_id = f.film_id
JOIN category c ON rental_stats.category_id = c.category_id
WHERE rental_stats.rental_rank <= 3
ORDER BY c.name, rental_stats.rental_rank;

## List customers who have never made any payments.
#3 Display Customer Full Name.
select concat(first_name," ",last_name) as Full_Name 
from customer c
left join payment p
on c.customer_id = p.customer_id
where p.customer_id IS NULL;

## Find the staff member who processed the highest number of rentals.
## Display Staff_id and No of Rentals
select * from staff;
select * from rental;

select staff_id ,count(*) as No_Of_Rentals from rental  r
group by staff_id 
order by No_Of_Rentals desc
limit 1;

## List all customers who have rented both ‘Action’ and ‘Comedy’ films(at
## least one of each category).
## Display Customer Full Name, No_of_Rentals
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    COUNT(r.rental_id) AS no_of_rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE c.customer_id IN (
    SELECT r.customer_id
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name IN ('Action', 'Comedy')
    GROUP BY r.customer_id
    HAVING COUNT(DISTINCT c.name) = 2
)
GROUP BY c.customer_id, c.first_name, c.last_name;



## Identify the customer with the most late returns, where a return is
##  considered late if it exceeds the rental duration.
## Display Customer Full_Name
select 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name
from 
    customer c
join rental r ON c.customer_id = r.customer_id
join inventory i ON r.inventory_id = i.inventory_id
join film f ON i.film_id = f.film_id
WHERE 
    r.return_date > DATE_ADD(r.rental_date, interval f.rental_duration DAY)
GROUP BY 
    c.customer_id
ORDER BY 
    COUNT(*) desc
limit 1;



## Find all actors who have acted in at least one film of every rating.
## Display Actor Names and No of Movies acted in
select concat(first_name," ",last_name) as Full_name 
from actor a 
join film_actor fac
on a.actor_id = fac.actor_id
join film f
on fac.film_id = f.film_id;

WITH rating_count AS (
    select COUNT(DISTINCT rating) AS total_ratings
    from film
),
actor_ratings AS (
    select 
        a.actor_id,
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
        COUNT(DISTINCT f.rating) AS actor_rating_count,
        COUNT(DISTINCT f.film_id) AS total_movies
    from 
        actor a
    join film_actor fa ON a.actor_id = fa.actor_id
    join film f ON fa.film_id = f.film_id
    group by 
        a.actor_id, actor_name
)

select 
    ar.actor_name,
    ar.total_movies
from 
    actor_ratings ar,
    rating_count rc
where 
    ar.actor_rating_count = rc.total_ratings
order by 
    ar.total_movies desc;


## Challenge acceptd
-- carton would be best fit for the product as per its size.
-- For example,
-- Let&#39;s say the product size is 20 x 30 x 50.
-- And let&#39;s say there are two cartons
-- Carton one of size - 25 x 35 x 53.
-- Carton two of size - 30 X 40 X 60.
-- Although both cartons can accommodate the shipping of the product, carton one is more
-- appropriate as its smaller size can accommodate the product at a lesser cost.
-- Your job is to find the Carton ID of the best fit cotton for every product.
-- Display product ID, best fit carton ID.
use order2;
select * from product;
select * from carton;

SELECT 
    p.product_id,
    c.carton_id
from product p
join carton c ON 
    p.length <= c.length AND 
    p.width <= c.width AND 
    p.height <= c.height
WHERE NOT EXISTS (
    select 1 
    from carton c2
    where 
        p.length <= c2.length AND 
        p.width <= c2.width AND 
        p.height <= c2.height AND 
        (c2.length * c2.width * c2.height) < (c.length * c.width * c.height)
);
