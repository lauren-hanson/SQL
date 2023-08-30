/* 
 Trigger Types 
 1. Row-level Triggers
 2. Statement-level Triggers
 
 What is the difference? 
 example: if UPDATE statement is used and modifies 20 rows, the row-level trigger will be invoked 20 times, 
 while the statement-level trigger will be invoked 1 time. 
 
 When should I use triggers? 
 -if database is accessed by various applications & you want to keep cross-funtionality w/i the database that 
 runs automatically whenever the data of the table if modified. 
- maintain complex data integrity rules which cannot implement elsewhere except at the database level 
	ex. new row is added into the customer table, other rows must to also created in tables of banks & credits 
	
CON of Trigger = must know the trigger exists & understand it's logic to figure out the effects when data changes 

PostgreSQL trigger
- fire trigger for the TRUNCATE event
- allows you to definte the statement-level trigger on views 
- requires you to define a user-defined function as athe action of the trigger, while the SQL standard allows 
you to use any SQL command 

SUMMARY
- invoked automatically when an INSERT, UPDATE, DELETE or TRUNCATE occurs on a table 
- PostgreSQL supports row-level & statement-level triggers 
 */

-- trigger function structure
create function trigger_function () 
	returns trigger 
	language plpgsql
as $$
begin 
	-- trigger logic 
end; 
$$ 
end

-- postgreSQL create trigger statement
create trigger trigger_name 
	{before | after} {event} 
	on table_name 
	[for [each] {row | statement}]
		execute procedure trigger_function 

		
-- new table created for employees & employee_audits
drop table if exists employees; 

create table employees(
	id int generated always as identity, 
	first_name varchar(40) not null, 
	last_name varchar(40) not null, 
	primary key (id) 
); 

-- this table will log changes made to names in employees table 
create table employee_audits(
	id int generated always as identity, 
	employee_id int not null, 
	last_name varchar(40) not null, 
	change_on timestamp(6) not null
); 


-- inserts old last_name into employee_audits including their id & time of change 
-- OLD represents the row before update 
-- NEW represents new row that will be updated 
create or replace function log_last_name_changes()
	returns trigger 
	language plpgsql 
	as 
$$
begin 
	if new.last_name <> old.last_name then 
		insert into employee_audits(employee_id, last_name, change_on)
		values(old.id, old.last_name, now()); 
	end if; 
	return new; 
end; 
$$


-- binds trigger function to the employees table carnival
-- before last_name is updated, trigger function is automatically invoked to the log changes 
create trigger last_name_changes
	before update 
	on employees 
	for each row 
	execute procedure log_last_name_changes(); 

select * from employees; 
select * from employee_audits; 

insert into employees (first_name, last_name) 
values ('John', 'Doe'), ('Lily', 'Bush'); 

update employees 
set last_name = 'Brown' 
where id = 2; 

