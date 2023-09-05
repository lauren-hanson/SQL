select * from employeetypes e  

-- Writing a transaction
begin; 
 
insert into salestypes(sales_type_name)
values('LtoOwn'); 

commit; 

rollback;

-- Rollback a transaction 
begin; 

insert into employeetypes(employee_type_name)
values('Accountant'); 


-- Transactions & Exception Handling 
select * from customers 
where last_name = 'Simlet'

do $$ 
declare
	NewCustomerId integer; 
	CurrentTS date; 
	
begin
	
	insert into 
	customers(
		first_name, 
		last_name, 
		email, 
		phone, 
		street, 
		city, 
		state, 
		zipcode, 
		company_name 
	)
	
	values(
		'Roy', 
		'Simlet', 
		'r.simlet@remves.com',
		'615-876-1237', 
		'77 Miner Lane', 
		'San Jose', 
		'CA', 
		'95007', 
		'Remves'
	) returning customer_id into NewCustomerId; 

CurrentTS = current_date; 

insert into 
	sales(
		sales_type_id, 
		vehicle_id, 
		employee_id, 
		customer_id, 
		dealership_id, 
		price, 
		deposit, 
		purchase_date, 
		pickup_date, 
		invoice_number, 
		payment_method
	)
	
	values(
		1, 
		1, 
		1,
		NewCustomerId, 
		1, 
		24333.67,
		6500,
		CurrentTS,
		CurrentTs + interval '7 days',
		1273592747,
		'solo'
	); 

exception when others then 
rollback; 

end; 

$$ language plpgsql; 
	

