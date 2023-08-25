--A sales employee at carnival creates a new sales record for a sale they are trying to close
--The customer, last minute decided not to purchase the vehicle. Help delete the Sales record with an invoice number of '2436217483'
select * from sales s
where s.invoice_number = '2436217483'

delete 
from sales s
where s.invoice_number = '2436217483'


--An employee was recently fired so we must delete them from our database. 
--Delete the employee with employee_id of 35. What problems might you run into when deleting? 
	--not deleting any tables connected to employees
--How would you recommend fixing it?