/* 
1. My partner and I want to come by each of the stores in person and meet the managers. 
Please send over the managers’ names at each store, with the full address 
of each property (street address, district, city, and country please).  
*/
SELECT 
first_name AS First_Name,
last_name AS Last_Name,
address.address,
city.city,
country.country,
address.district
FROM store
left join staff on staff.staff_id = store.manager_staff_id
left join address on address.address_id = store.address_id
left join city on city.city_id = address.address_id
left join country on country.country_id = city.country_id

/*
2.	I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, 
the inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost.*/


select inventory.inventory_id , store.store_id , title, rating, rental_rate, replacement_cost
from inventory
left  join store on inventory.store_id = store.store_id
left join film on film.film_id = inventory.film_id


/* 
3.	From the same list of films you just pulled, please roll that data up and provide a summary level overview 
of your inventory. We would like to know how many inventory items you have with each rating at each store. 
*/
select rating, count(inventory_id) , store.store_id , title, rental_rate, replacement_cost
from inventory
left  join store on inventory.store_id = store.store_id
left join film on film.film_id = inventory.film_id
group by store.store_id,title,rental_rate, replacement_cost, rating

/* 
4. Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to 
see how big of a hit it would be if a certain category of film became unpopular at a certain store.
We would like to see the number of films, as well as the average replacement cost, and total replacement cost, 
sliced by store and film category. 
*/
select store_id, 
category.name AS category,
count(inventory.inventory_id),
sum(film.replacement_cost) AS avg_replacement_cost,
avg(film.replacement_cost) AS sum_replacement_cost
from inventory
left join film on inventory.film_id = film.film_id
left join film_category on film.film_id = film_category.film_id
left join category on category.category_id = film_category.category_id

group by store_id, 
category.name
order by sum(film.replacement_cost) DESC






/*
5.	We want to make sure you folks have a good handle on who your customers are. Please provide a list 
of all customer names, which store they go to, whether or not they are currently active, 
and their full addresses – street address, city, and country. 
*/
-- use mavenmovies;
select customer.first_name AS First_Name,
	    customer.last_name AS Last_Name,
        store.store_id,
        customer.active,
        address.address,city.city,country.country
        from customer
        left join store on customer.store_id = store.store_id
        left join address on address.address_id = customer.address_id
        left join city on address.city_id = city.city_id
        left join country on country.country_id = city.country_id
        

/*
6.	We would like to understand how much your customers are spending with you, and also to know 
who your most valuable customers are. Please pull together a list of customer names, their total 
lifetime rentals, and the sum of all payments you have collected from them. It would be great to 
see this ordered on total lifetime value, with the most valuable customers at the top of the list. 
*/

select customer.first_name,
customer.last_name,
count(rental.rental_id) AS lifetime_rentals,
sum(payment.amount) AS Toatal_lifetime_rentals,
customer.customer_id
from customer
left  join rental on customer.customer_id = rental.customer_id
left  join payment on payment.rental_id = rental.rental_id
group by customer.first_name,
customer.last_name, customer.customer_id
order by sum(payment.amount) DESC


/*
7. My partner and I would like to get to know your board of advisors and any current investors.
Could you please provide a list of advisor and investor names in one table? 
Could you please note whether they are an investor or an advisor, and for the investors, 
it would be good to include which company they work with. 
*/
select 'investor' AS Type, company_name , first_name, last_name
from investor
union 
select 'advisor' AS Type, first_name , last_name, Null 
from advisor


/*
8. We're interested in how well you have covered the most-awarded actors. 
Of all the actors with three types of awards, for what % of them do we carry a film?
And how about for actors with two types of awards? Same questions. 
Finally, how about actors with just one award? 
*/
SELECT 
CASE 
     when actor_award.awards = 'Emmy, Oscar, Tony' Then '3 Awards'
     when actor_award.awards IN ('Emmy, oscar', 'Emmy,tony','oscar,tony') Then '2 awards'
     else '1 award'
     End as number_of_awards,
     AVG(Case when actor_award.actor_id IS NULL THEN 0 ELSE 1 END) AS pct_w_one_film
     From actor_award
    Group By
     Case 
        when actor_award.awards = 'Emmy, Oscar, Tony' Then '3 awards'
     when actor_award.awards IN ('Emmy, Oscar', 'Emmy, tony' , 'oscar, Tony') Then '2 awards'
     Else '1 award'
     End 




        










