select * from employees e 
join dealershipemployees de 
	on e.employee_id = de.employee_id 
where e.last_name = 'Blumfield'
-- employee_id = 9

-- updating dealership location on the joined table 
update dealershipemployees
set dealership_id = 20 
from dealershipemployees de
join employees e
	on de.employee_id = e.employee_id 
where e.employee_id = 9


select 
	c.first_name || ' ' || c.last_name as CustomerName, 
	s.payment_method, 
	s.invoice_number 
from customers c
join sales s 
	on c.customer_id = s.customer_id 
where invoice_number = '9086714242' and c.last_name like 'Abeau'

update sales 
set payment_method = 'MC'
from sales s
join customers c 
	on s.customer_id = c.customer_id 
where s.invoice_number = '9086714242' and c.last_name like 'Abeau'