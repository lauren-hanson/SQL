select distinct 
	concat(c.first_name, ' ', c.last_name) as Customer, 
	c.email as CustomerEmail, 
	concat(a.address, ' ', c2.city, ' ', a.district, ' ', a.postal_code) as CustomerAddress, 
	f.title, 
	Sum(p.amount) over(partition by c.customer_id) CustomerTotal, 
	concat(st.first_name, ' ', st.last_name) as StaffMember, 
	concat(a2.address, ' ', c3.city, ' ', a2.district, ' ', a2.postal_code) as StoreAddress, 
	s.store_id
from rental r 
join customer c 
	on c.customer_id = r.customer_id
join address a 
	on a.address_id = c.address_id 
join city c2 
	on c2.city_id = a.city_id 
join inventory i 
	on i.inventory_id = r.inventory_id 
join store s 
	on s.store_id = i.store_id 
join staff st	
	on st.staff_id = s.manager_staff_id 
join address a2 
	on a2.address_id = s.address_id 
join city c3 
	on c3.city_id = a2.city_id 
join payment p 
	on p.rental_id = r.rental_id 
join film f 
	on f.film_id = i.film_id 
	
	
-- creating a view from query ^^
create or replace view customerRentals as 
select distinct 
	concat(c.first_name, ' ', c.last_name) as Customer, 
	c.email as CustomerEmail, 
	concat(a.address, ' ', c2.city, ' ', a.district, ' ', a.postal_code) as CustomerAddress, 
	f.title, 
	Sum(p.amount) over(partition by c.customer_id) CustomerTotal, 
	concat(st.first_name, ' ', st.last_name) as StaffMember, 
	concat(a2.address, ' ', c3.city, ' ', a2.district, ' ', a2.postal_code) as StoreAddress, 
	s.store_id
from rental r 
join customer c 
	on c.customer_id = r.customer_id
join address a 
	on a.address_id = c.address_id 
join city c2 
	on c2.city_id = a.city_id 
join inventory i 
	on i.inventory_id = r.inventory_id 
join store s 
	on s.store_id = i.store_id 
join staff st	
	on st.staff_id = s.manager_staff_id 
join address a2 
	on a2.address_id = s.address_id 
join city c3 
	on c3.city_id = a2.city_id 
join payment p 
	on p.rental_id = r.rental_id 
join film f 
	on f.film_id = i.film_id 

-- this is how you can call your view now that is has been created
select * from customerrentals 
select distinct 
	concat(c.first_name, ' ', c.last_name) as Customer, 
	c.email as CustomerEmail, 
	concat(a.address, ' ', c2.city, ' ', a.district, ' ', a.postal_code) as CustomerAddress, 
	f.title, 
	Sum(p.amount) over(partition by c.customer_id) CustomerTotal, 
	concat(st.first_name, ' ', st.last_name) as StaffMember, 
	concat(a2.address, ' ', c3.city, ' ', a2.district, ' ', a2.postal_code) as StoreAddress, 
	s.store_id
from rental r 
join customer c 
	on c.customer_id = r.customer_id
join address a 
	on a.address_id = c.address_id 
join city c2 
	on c2.city_id = a.city_id 
join inventory i 
	on i.inventory_id = r.inventory_id 
join store s 
	on s.store_id = i.store_id 
join staff st	
	on st.staff_id = s.manager_staff_id 
join address a2 
	on a2.address_id = s.address_id 
join city c3 
	on c3.city_id = a2.city_id 
join payment p 
	on p.rental_id = r.rental_id 
join film f 
	on f.film_id = i.film_id 
	
	
-- creating a view from query ^^
create or replace view customerRentals as 
select distinct 
	concat(c.first_name, ' ', c.last_name) as Customer, 
	c.email as CustomerEmail, 
	concat(a.address, ' ', c2.city, ' ', a.district, ' ', a.postal_code) as CustomerAddress, 
	f.title, 
	Sum(p.amount) over(partition by c.customer_id) CustomerTotal, 
	concat(st.first_name, ' ', st.last_name) as StaffMember, 
	concat(a2.address, ' ', c3.city, ' ', a2.district, ' ', a2.postal_code) as StoreAddress, 
	s.store_id
from rental r 
join customer c 
	on c.customer_id = r.customer_id
join address a 
	on a.address_id = c.address_id 
join city c2 
	on c2.city_id = a.city_id 
join inventory i 
	on i.inventory_id = r.inventory_id 
join store s 
	on s.store_id = i.store_id 
join staff st	
	on st.staff_id = s.manager_staff_id 
join address a2 
	on a2.address_id = s.address_id 
join city c3 
	on c3.city_id = a2.city_id 
join payment p 
	on p.rental_id = r.rental_id 
join film f 
	on f.film_id = i.film_id 

-- this is how you can call your view now that is has been created
select * from customerrentals 
