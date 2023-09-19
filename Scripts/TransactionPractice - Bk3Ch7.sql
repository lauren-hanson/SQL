select * from dealerships 
where business_name in ('Meeler Autos of San Diego', 'Meadley Autos of California', 'Major Autos of Florida') 
-- 36, 20, 50

select * from dealershipemployees 
where dealership_id in (36, 20, 50) and employee_id = 1117

select * from employeetypes  
where employee_type_name = 'Automotive Mechanic'

select * from customers
order by company_name
select * from sales 
select * from vehicles


/* 
Write a transaction to: 
1. add a new role for employees called Automotive Mechanic
2. add 5 new mechanics(data up to you)
3. each new mechanic will be working at all three of these dealerships: Meeler Autos of San Diego, Meadley Autos of California & Major Autos of Florida
*/


do $$ 
declare 
  NewEmployeeTypeId integer;
  NewEmployeeId1 integer; 
  NewEmployeeId2 integer; 
  NewEmployeeId3 integer; 
  NewEmployeeId4 integer; 
  NewEmployeeId5 integer; 

begin

-- add new role 
insert into employeetypes (employee_type_name)
values ('Automotive Mechanic') 
returning employee_type_id into NewEmployeeTypeId; 


-- 5 new mechanics
insert into 
	employees (
		first_name, 
		last_name, 
		email_address, 
		phone, 
		employee_type_id)
		
values
	('George', 'Hanson', 'george@george.com', '516-934-4829', NewEmployeeTypeId)
			returning employee_id into NewEmployeeId1; 
		
insert into 
	employees (
		first_name, 
		last_name, 
		email_address, 
		phone, 
		employee_type_id)
values
	('Nigel', 'Hussung', 'nigel@nigel.com', '412-398-6283', NewEmployeeTypeId)
			returning employee_id into NewEmployeeId2; 
		
insert into 
	employees (
		first_name, 
		last_name, 
		email_address, 
		phone, 
		employee_type_id)
values
	('Anastasia', 'Thomas', 'anastasia@anastasia.com', '689-321-4938', NewEmployeeTypeId)
			returning employee_id into NewEmployeeId3; 
		
insert into 
	employees (
		first_name, 
		last_name, 
		email_address, 
		phone, 
		employee_type_id)
values
	('Gio', 'Roggenbuck', 'gio@gio.com', '513-284-5693', NewEmployeeTypeId)
			returning employee_id into NewEmployeeId4; 
	
insert into 
	employees (
		first_name, 
		last_name, 
		email_address, 
		phone, 
		employee_type_id)
	values
	('Poppy', 'Nelson', 'poppy@poppy.com', '378-276-3948', NewEmployeeTypeId)
		returning employee_id into NewEmployeeId5;


	
-- connecting each employee to each dealership
insert into 
	dealershipemployees (
		dealership_id, 
		employee_id 
	)

	values
		(36, NewEmployeeId1), 
		(50, NewEmployeeId1), 
		(20, NewEmployeeId1),
		
		(36, NewEmployeeId2), 
		(50, NewEmployeeId2), 
		(20, NewEmployeeId2),
		
		(36, NewEmployeeId3), 
		(50, NewEmployeeId3), 
		(20, NewEmployeeId3),
		
		(36, NewEmployeeId4), 
		(50, NewEmployeeId4), 
		(20, NewEmployeeId4),
		
		(36, NewEmployeeId5), 
		(50, NewEmployeeId5), 
		(20, NewEmployeeId5); 

commit; 

exception when others then 
  RAISE INFO 'Error:%', SQLERRM;
  rollback;


end;


$$ language plpgsql;



/* 
Create a transaction for: 
1. creating a new dealership in Washington, DC called Felphun Automotive
2. hire 3 new employees for the new dealership: Sales Manager, General Manager, & Customer Service
3. all employees that currenly work at Nelsen Autos of Illinois will n0w start working at Cain Autos of Missouri instead
*/

select * from dealerships 
where business_name = 'Felphun Automotive'

select * from dealerships 
where business_name in ('Nelsen Autos of Illinois', 'Cain Autos of Missouri')
-- Nelsen(17) => Cain(3)

select * from employees
order by employee_id desc

select * from employeetypes  
select * from dealershipemployees 

-----------------------------------------------------------------------------------

do $$ 
declare 
  NewDealershipId integer;
 -- declare an array to store employee_ids
  NewEmployeeIds integer[]; 

begin
	
	-- creating new dealership
	insert into 
	dealerships (
		business_name, 
		phone, 
		city,
		state,
		website, 
		tax_id
	)
	values(
		'Felphun Automotive', 
		null, 
		'Washington', 
		'DC', 
		null, 
		'fr-768-qje4'
	) returning dealership_id into NewDealershipId; 

	insert into 
	employees (
		first_name,
		last_name, 
		email_address, 
		phone, 
		employee_type_id 
	)
	values 
		('Jennifer', 'Taylor', 'jennifer@jennifer.com', '345-938-2739', 3), 
		('Mark', 'Browne', ' mark@mark.com', '815-483-9283', 6), 
		('Tyler', 'Martin', 'tyler@tyler.com', '214-837-5693', 4)
		returning employee_id into NewEmployeeIds; 
	
	-- all employees currently working at Nelsen Autos will nto work at Cain instead 
	update dealershipemployees 
	set dealership_id = 3
	where dealership_id = 17;

	commit; 
	
	
exception when others then 
  RAISE INFO 'Error:%', SQLERRM;
  rollback;

end;

$$ language plpgsql;