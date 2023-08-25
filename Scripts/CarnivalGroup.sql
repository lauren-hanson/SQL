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



-- TOP PERFORMANCE -- 

-- employees who generated most income per dealership

-- this joins the employee to each dealership that they work for 
with AllDealershipEmployees as (
	select
		d.business_name,
		e.employee_id,
		d.dealership_id, 
		e.first_name || ' ' || e.last_name as EmployeeName 
	from dealerships d 
	join dealershipemployees de 
		on d.dealership_id = de.dealership_id 
	join employees e 
		on de.employee_id = e.employee_id 
		
)
select 
	distinct ade.EmployeeName, 
	ade.business_name,
	SUM(s.price) as sales_income, 
--	over (partition by ade.dealership_id) as TotalSalesPerEmployee
	RANK() over (partition by ade.dealership_id order by SUM(s.price) desc) as sales_rank 
from AllDealershipEmployees ade
join sales s 
	on ade.dealership_id = s.dealership_id

--SELECT
--	dealership_id,
--	business_name,
--	employee_id,
--	CONCAT(first_name, ' ', last_name) AS employee_name,
--	sales_income
--FROM (
--	SELECT
--		d.dealership_id,
--		d.business_name,
--		e.employee_id,
--		e.first_name,
--		e.last_name,
--		SUM(s.price) AS sales_income,
--		RANK() OVER (PARTITION BY d.dealership_id ORDER BY SUM(s.price) DESC) AS sales_rank
--	FROM sales s
--	JOIN employees e ON s.employee_id = e.employee_id
--	JOIN dealerships d ON s.dealership_id = d.dealership_id
--	GROUP BY d.dealership_id, d.business_name, e.employee_id, e.first_name, e.last_name
--) ranked_sales
--WHERE sales_rank = 1
--
select 
	distinct(e.first_name || ' ' || e.last_name) as EmployeeName, 
	SUM(s.price) over (partition by e.employee_id) as TotalSalesPerEmployee
from employees e 
join dealershipemployees de 
	on e.employee_id = de.employee_id 
join dealerships d 
	on de.dealership_id = d.dealership_id 
join sales s 
	on d.dealership_id = s.dealership_id 
order by TotalSalesPerEmployee desc 
-- RANK() over (order by s.price desc)


-- VEHICLE REPORTS -- 
create view VehiclesInStock as 
select 
	v.vehicle_id,
	vt.body_type, 
	vt.make, 
	vt.model, 
	v.is_sold
from vehicles v
left join vehicletypes vt	
	on v.vehicle_type_id = vt.vehicle_type_id 
where v.is_sold = false

-- count of each model in stock 
select 
	distinct model, 
	COUNT(model) over (partition by model) as ModelCount
from vehiclesinstock 
order by modelcount desc

-- count of each make in stock 
select 
	distinct make, 
	COUNT(make) over (partition by make) as MakeCount
from vehiclesinstock 
order by makecount desc

-- count of each body type in stock 
select 
	distinct body_type, 
	COUNT(body_type) over (partition by body_type) as BodyTypeCount
from vehiclesinstock 
order by bodytypecount desc

-- truck 969 suv 1202 car 2663 van 226


-- PURCHASING POWER -- 

-- US state's customers that have highest average purchase price for vehicle 
-- average per customer's state
select 
	distinct c.state, 
	ROUND(AVG(s.price) OVER (PARTITION BY c.state), 2) AS RoundedAverageSalesPerState
from sales s 
join customers c 
	on s.customer_id = c.customer_id 
order by RoundedAverageSalesPerState desc 
limit 1 


-- 5 states that have the highest average purchase price for a vehicle per customer 
select 
	distinct c.state, 
	ROUND(AVG(s.price) OVER (PARTITION BY c.state), 2) AS RoundedAverageSalesPerState
from sales s 
join customers c 
	on s.customer_id = c.customer_id 
order by RoundedAverageSalesPerState desc 
limit 5

