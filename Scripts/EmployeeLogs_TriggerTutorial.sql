CREATE TABLE employees (

	id serial PRIMARY key not null,
	old_address varchar(20), 
	new_address varchar(20),
	name varchar(20),
);

CREATE TABLE company (

	id serial PRIMARY key not null,
	name varchar(20),
	age varchar(20),
	address varchar(20),
	salary int
);

select * from company

insert into company(name, age, address, salary) 
values('Rahul',20,'Kolkata',50000)


create or replace function log_change() 
	returns trigger 
	language plpgsql 
	as 
$$
begin
	if new.address<>old.address then 
	insert into employee_logs values (old.id, old.address, new.address, old.name);
	end if; 
	return new; 
end; 
$$

create trigger loc_changer
before update 
on company 
for each row 
execute procedure log_change(); 

update company 
set address ='Delhi'
where id = 1


