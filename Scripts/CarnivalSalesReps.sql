
-- employees for each role 
select 
	distinct et.employee_type_name,
	COUNT(et.employee_type_id) OVER(partition by et.employee_type_name) as EmployeeRole
from employees e 
left join employeetypes et
	on e.employee_type_id = et.employee_type_id 


-- finance managers work at each dealership
select 
	distinct d.business_name, 
	et.employee_type_name, 
	COUNT(et.employee_type_name) over (partition by d.business_name)
from dealerships d 
join dealershipemployees de
	on d.dealership_id = de.dealership_id 
join employees e 
	on de.employee_id = e.employee_id 
join employeetypes et
	on e.employee_type_id = et.employee_type_id 
where et.employee_type_name = 'Finance Manager'


-- names of the top 3 employees who work shifts at the most dealerships
select 
	distinct e.first_name || ' ' || e.last_name as EmployeeName,
	COUNT(d.business_name) over (partition by e.employee_id) NumOfDealerships
--	count(e.employee_id) over(partition by e.employee_id) NumOfDealerships
from employees e 
left join dealershipemployees de
	on e.employee_id = de.employee_id 
join dealerships d 
	on de.dealership_id = de.dealership_id 
order by NumOfDealerships desc
limit 3



-- top 2 employees who have made the most sales through leasing vehicles 
select 
	distinct(e.first_name || ' ' || e.last_name) as EmployeeName,
	SUM(s.price) over(partition by e.employee_id) as TotalLeaseSales
from employees e 
join sales s 
	on e.employee_id = s.employee_id 
left join salestypes st	
	on s.sales_type_id = st.sales_type_id
where st.sales_type_name = 'Lease' 
order by TotalLeaseSales desc
limit 2


