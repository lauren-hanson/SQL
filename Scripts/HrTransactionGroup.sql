/* 
Create a SP with a transaction to handle hiring a new employee
Add a new record for the employee in the Employees table. 
Add a record to the Dealershipemployees table for the 2 dealerships the new employee will start at
*/ 

select * from employees 
	order by employee_id desc
	
select * from employeetypes 
select * from dealerships 
	order by dealership_id desc
	
select * from dealershipemployees 
	order by dealership_employee_id desc
	

--create or replace procedure NewHireInformation()
--language plpgsql  
--as $$
--declare 
--	NewCustomerId integer; 
--	CurrentTS date; 
--
--begin
--	insert into employees(first_name,last_name,email_address,phone,employee_type_id)
--	values('George','Hanson','george@george.com','6157245692', 7)
--	returning employee_id into NewCustomerId; 
--	
--	commit; 
--
--	CurrentTS = current_date; 
--
--	insert into dealershipemployees(dealership_id,employee_id)
--	values(75, NewCustomerId); 
--	
--	commit; 
--
--	insert into dealershipemployees(dealership_id,employee_id)
--	values(51, NewCustomerId); 
--	
--	
--end; 
--$$; 

create or replace procedure NewHireInformation()
language plpgsql  
as $$
declare 
	NewCustomerId integer; 
	CurrentTS date; 

begin
	insert into employees(first_name,last_name,email_address,phone,employee_type_id)
	values(new.first_name, new.last_name, new.email_address, new.phone, new.employee_type_id)
	returning employee_id into NewCustomerId; 
	
	commit; 

	CurrentTS = current_date; 

	insert into dealershipemployees(dealership_id,employee_id)
	values(75, NewCustomerId); 
	
	commit; 

	insert into dealershipemployees(dealership_id,employee_id)
	values(51, NewCustomerId); 
	
	
end; 
$$; 

call NewHireInformation(); 



/*
Create a SP with a transaction to handle an employee leaving. 
Remove employee record.
Remove all records associated with the employee w/ dealerships must also be removed
*/

create or replace procedure EmployeeLeaving()
language plpgsql 
as $$
declare 

begin 
	
	delete from dealershipemployees 
	where employee_id = 1085;

	commit; 

	delete from employees 
	where employee_id = 1085;
	
	

end; 
$$;

call EmployeeLeaving(); 

