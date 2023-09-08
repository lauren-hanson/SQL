/*
 Why transactional stored procedures? 
 a complex SP could have a series of statements that must all execute successfully. 
 if a statement fails, anything that happened before, must be undone or rollback there fore SP must contain transactions 
 
 examples
 	- bank cash transfers (debit/credit) 
 	- inventory updates (purchase confirmation, update inventory status, ship item) 
 	- hiring an employee (new employee record, new department/employee record, payroll record created) 
 */

create or replace procedure student_add_score ( 
	student_id int, 
	score dec 
)
language plpgsql
as $$
begin 
	-- adding a new record into the grades table 
	insert into studentgrades(student_id, score) 
	values (student_id, score)
	
	commit; 

	-- calculating & updating the students new average score
	update students 
	set avg_grade = (
		select avg(score) 
		from studentgrades 
		where student_id = student_id 
	)
	where student_id = student_id; 
end;$$

-- new customer created w/ 2 sales records associated w/ new customer -- 
create or replace procedure new_customer_new_sale()
language plpgsql
as $$
declare 
	NewCustomerId integer; 
	CurrentTS date; 
begin 
	insert into customers(first_name, last_name, email, phone, street, city, state, zipcode, company_name)
	values('BILL', 'Simlet', 'r.simlet@remves.com', '615-876-1237', '77 Miner Lane', 'San Jose', 'CA', '95008', 'Remves')
	returning customer_id into NewCustomerId; 
	
commit; 

	CurrentTS = CURRENT_DATE; 

	insert into sales(sales_type_id,vehicle_id,employee_id,customer_id,dealership_id,price,deposit,purchase_date,pickup_date,invoice_number,payment_method)
	values(1,1,1,NewCustomerId,1,24333.67,6500,CurrentTS,CurrentTS + interval '7 days',1273592747, 'solo');
		
commit;
		
	insert into sales(sales_type_id,vehicle_id,employee_id,customer_id,dealership_id,price,deposit,purchase_date,pickup_date,invoice_number,payment_method)
	values(1,1,1,NewCustomerId,1,24333.67,6500,CurrentTS,CurrentTS + interval '7 days',1273592747);

end;
$$;

call new_customer_new_sale();






-- TRANSACTION WITHIN STORED PROCEDURE -- 

delimiter $$
create procedure update_value1(in usern varchar(255), in userid int(10), out status varchar(200))
begin 
start transaction; 
	update user_details 
	set username = usern
	where user_id = userid
	select * from user_details; 
commit; 
set status = 'Updated successfully'; 
select status; 
end $$
delimiter; 

call update_value1('vikrant', 3, @status)

-- STORED PROCEDURES FOR TRANSACTIONS -- 
-- used for processing data

go 
create procedure pInsCustomers
(@CustomerFirstName nvarchar(100),
(@CustomerLastName nvarchar(100), 
(@CustomerEmail nvarchar(100))
as 
begin
	begin transaction; 
		insert into customers(CustomerFirstName, CustomerLastName, CustomerEmail)
		values(@CustomerFirstName, @CustomerLastName, @CustomerEmail); 
	commit transaction; 
end
go

execute pInsCustomers
	@CustomerFirstName = 'Sue', 
	@CustomerLastName = 'Jones', 
	@CustomerEmail = 'SJones@MyCo.com'
	; 
go 

create procedure pUpdCustomers 
	(@CustomerID int, @CustomerFirstName nvarchar(100), @CustomerLastName nvarchar(100), @CustomerEmail nvarchar(100))
as 
begin 
	begin transaction 
	update customers 
	set CustomerFirstName = @CustomerFirstName, 
		CustomerLastName = @CustomerLastName, 
		CustomerEmail = @CustomerEmail 
	where CustomerID = @CustomerID; 
	commit transaction
end
go

execute pUpdCustomers
	@CustomerID = 1,
	@CustomerFirstName = 'Sue', 
	@CustomerLastName = 'Jones', 
	@CustomerEmail = 'SJones@MyCo.com'
	; 
go 






