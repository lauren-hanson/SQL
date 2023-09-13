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
where employee_id = 1086
	order by dealership_employee_id desc
	

create or replace procedure NewHireInformation(
	p.first_name text, 
	p.last_name text, 
	p.email_address text, 
	p.phone text, 
	p.employee_type_id int, 
	p.dealership_id1 int, 
	p.dealership_id2 int)
language plpgsql  
as $$
declare 
	v.newemployeeid integer; 

begin
	insert into employees(first_name,last_name,email_address,phone,employee_type_id)
	values(p.first_name, p.last_name, p.email_address, p.phone,p.employee_type_id)
	returning employee_id into v.newemployeeid; 

	insert into dealershipemployees(dealership_id,employee_id)
	values(p.dealership_id1, v.newemployeeid), (p.dealership_id2, v.newemployeeid); 
	
	exception when others then 
		rollback; 
		raise;
	
end; 
$$; 

call NewHireInformation('Nigel', 'Hussung', 'nigel@nigel.com', '582-894-1283', 5, 12, 18); 



/*
Create a SP with a transaction to handle an employee leaving. 
Remove employee record.
Remove all records associated with the employee w/ dealerships must also be removed
*/

create or replace procedure EmployeeLeaving(
	p.employee_id integer 
	)
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

