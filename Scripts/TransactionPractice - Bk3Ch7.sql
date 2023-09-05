select * from dealerships 
where business_name in ('Meeler Autos of San Diego', 'Meadley Autos of California', 'Major Autos of Florida') 
-- 36, 20, 50

select * from dealershipemployees 
where dealership_employee_id in (36, 20, 50)

select * from employeetypes  

select 
	e.employee_id,
	e.first_name, 
	e.last_name, 
	et.employee_type_name 
from employees e
left join employeetypes et
on e.employee_id = et.employee_type_id 
order by e.employee_id desc
--left join dealershipemployees d 
--on e.employee_id = d.employee_id 
--where et.employee_type_name = 'Automotive Mechanic'


/* 
Write a transaction to: 
1. add a new role for employees called Automotive Mechanic
2. add 5 new mechanics(data up to you)
3. each new mechanic will be working at all three of these dealerships: Meeler Autos of San Diego, Meadley Autos of California & Major Autos of Florida
*/

do $$ 
declare 
  NewEmployeeType integer;
  NewEmployeeId integer;
  DealershipIds integer[] = array[36, 20, 50]; 
  dealer_id integer;

begin

-- add new role 
insert into employeetypes(employee_type_name)
values('Automotive Mechanic') 
returning employee_type_id into NewEmployeeType; 


-- 5 new mechanics
insert into 
	employees (
		first_name, 
		last_name, 
		email_address, 
		phone, 
		employee_type_id)
	values
		('George', 'Hanson', 'george@george.com', '516-934-4829', NewEmployeeType), 
		('Nigel', 'Hussung', 'nigel@nigel.com', '412-398-6283', NewEmployeeType),
		('Anastasia', 'Thomas', 'anastasia@anastasia.com', '689-321-4938', NewEmployeeType), 
		('Gio', 'Roggenbuck', 'gio@gio.com', '513-284-5693', NewEmployeeType), 
		('Poppy', 'Nelson', 'poppy@poppy.com', '378-276-3948', NewEmployeeType)
		returning employee_id into NewEmployeeId;
	
foreach dealer_id in array DealershipIds
loop 	
	insert into 
	dealershipemployees (
		dealership_id, 
		employee_id 
	)
	values(dealer_id, NewEmployeeId); 
end loop; 

--insert into 
--	dealershipemployees (
--		dealership_id, 
--		employee_id 
--	)
--values (36, NewEmployeeId), (20, NewEmployeeId), (50, NewEmployeeId); 

exception when others then 
  -- RAISE INFO 'name:%', SQLERRM;
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
select * from employeetypes  
select * from dealershipemployees 

do $$ 
declare 
  NewDealershipId integer;
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
		('Jennifer', 'Taylor', 'jennifer@jennifer.com', '7345-938-2739', 3), 
		('Mark', 'Browne', 'jennifer@jennifer.com', '7345-938-2739', 6), 
		('Tyler', '', 'jennifer@jennifer.com', '7345-938-2739', 4)
		returning employee_id into NewEmployeeIds; 
	
	update dealershipemployees 
	set dealership_id = NewDealershipId
	where employee_id = NewEmployeeIds;
	
	-- all employees currently working at Nelsen Autos will nto work at Cain instead 
	update dealershipemployees 
	set dealership_id = 3
	where dealership_id = 17;
	
	
exception when others then 
  -- RAISE INFO 'name:%', SQLERRM;
  rollback;

end;

$$ language plpgsql;