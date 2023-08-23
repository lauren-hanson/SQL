create view employee_dealership_names as 
select 
	e.first_name, 
	e.last_name, 
	d.business_name 
from employees e 
inner join dealershipemployees de 
	on e.employee_id = de.employee_id 
inner join dealerships d 
	on d.dealership_id = de.dealership_id 
	
select * from employee_dealership_names 

-- list all vehicle body types, makes, and models 
create view all_vehicles as 
select 
	vt.body_type, 
	vt.make,
	vt.model
from vehicles v 
left join vehicletypes vt	
	on v.vehicle_type_id = vt.vehicle_type_id 
	
select * from all_vehicles 


-- total number of employees for each employee type 
create view number_of_employee_types as
select 
	distinct et.employee_type_name,
	COUNT(et.employee_type_id) over(partition by et.employee_type_name) 
from employees e 
left join employeetypes et 
	on e.employee_type_id = et.employee_type_id 
	
select * from number_of_employee_types 


-- list all customers w/o exposing their emails, phone numbers & street address
create view customer_public as 
select 
	c.first_name || ' ' || c.last_name as customer_name, 
	c.company_name 
from customers c 

select * from customer_public 

-- view names 'sales2018' shows total number of sales for each sale type in 2018
create view sales2018 as 
select 
	distinct st.sales_type_name,
	SUM(s.price) over(partition by st.sales_type_id) TotalSales2018
from sales s 
join salestypes st	
	on s.sales_type_id = st.sales_type_id 
where extract(year from s.purchase_date) = 2018

select * from sales2018


-- employee at each dealership with the most number of sales -- need to come back to this
select 
	distinct d.business_name, 
	e.first_name || ' ' || e.last_name as employee_name, 
	SUM(s.price) OVER(partition by e.employee_id) as total_sales, 
	RANK() over (order by s.price desc)
from employees e 
join sales s 
on e.employee_id = s.employee_id 
join dealershipemployees de
	on e.employee_id = de.employee_id 
join dealerships d 
	on de.dealership_id = d.dealership_id 
group by d.business_name, e.employee_id, e.first_name, e.last_name, s.price
order by rank desc 

