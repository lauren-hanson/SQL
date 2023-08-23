
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


-- top 2 employees who have made the most sales through leasing vehicles 
