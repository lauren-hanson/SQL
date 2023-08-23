-- BEST SELLERS -- 
-- top 5 employees for generating sales income 
select 
	distinct e.last_name, 
	SUM(s.price) over(partition by e.employee_id) as TotalSalesPerEmployee
from employees e 
join sales s 
	on e.employee_id = s.employee_id 
order by TotalSalesPerEmployee desc 
limit 5


-- top 5 dealerships for generating sales income 
select 
	distinct d.business_name, 
	SUM(s.price) over(partition by d.dealership_id) as TotalSalesPerDealership
from  dealerships d  
join sales s 
	on s.dealership_id = d.dealership_id 

order by TotalSalesPerDealership desc 
limit 5

-- vehicle model with most sales income 
select 
	distinct vt.model, 
	SUM(s.price) over(partition by vt.model) as TotalSalesPerModel
from sales s 
join vehicles v 
	on s.vehicle_id = v.vehicle_id 
left join vehicletypes vt
	on v.vehicle_type_id = vt.vehicle_type_id 
order by TotalSalesPerModel desc 
limit 1


-- working on top performance 
select 
	e.first_name || ' ' || e.last_name, 
	d.business_name, 
	s.sale_id 
from employees e 
join dealershipemployees de 
	on e.employee_id = de.employee_id 
join dealerships d 
	on de.dealership_id = de.dealership_id 
join sales s 
	on d.dealership_id = s.dealership_id 

-- TOP PERFORMANCE -- 
-- employees who generated most income per dealership
select 
	distinct(e.first_name || ' ' || e.last_name) as EmployeeName, 
	s.price,
--	over (partition by e.employee_id) as TotalSalesPerEmployee, 
	d.business_name 
from employees e 
join dealershipemployees de 
	on e.employee_id = de.employee_id 
join dealerships d 
	on de.dealership_id = d.dealership_id 
join sales s 
	on d.dealership_id = s.dealership_id 
order by EmployeeName
--where e.employee_id = 1

-- VEHICLE REPORTS -- 
create view VehiclesInStock as 
select 
	v.vehicle_id,
	vt.body_type, 
	vt.make, 
	vt.model
from vehicles v
left join vehicletypes vt	
	on v.vehicle_type_id = vt.vehicle_type_id 
where v.is_sold = false

-- count of each model in stock 
select 
	distinct model, 
	COUNT(model) over (partition by model) as ModelCount
from vehiclesinstock 


-- count of each make in stock 
select 
	distinct make, 
	COUNT(make) over (partition by make) as MakeCount
from vehiclesinstock 

-- count of each body type in stock 
select 
	distinct body_type, 
	COUNT(body_type) over (partition by body_type) as BodyTypeCount
from vehiclesinstock 

-- PURCHASING POWER -- 
-- US state's customers that have highest average purchase price for vehicle 

-- 5 states that have the highest average purchase price for a vehicle per customer 

