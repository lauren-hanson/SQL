select * from vehicletypes 
select distinct make from vehicletypes 
select distinct model from vehicletypes 
select distinct body_type from vehicletypes 

do $$ 
--declare 
--	vehiclebodytypeid int; 
--	vehiclemodelid int; 
--	vehiclemakeid int; 

begin 
	
	-- create new VehicleTypes, VehicleBodyTypes, VehicleModels, VehicleMakes 
	
	create table vehiclebodytypes (
		vehicle_body_type_id serial primary key, 
		body_type varchar not null
	); 


	create table vehiclemodels (
		vehicle_model_id serial primary key, 
		model varchar not null 
	); 

	
	create table vehiclemakes (
		vehicle_make_id serial primary key, 
		make varchar not null 
	); 
	

	-- insert info for each table 
	insert into vehiclebodytypes (body_type)
		select distinct body_type from vehicletypes; 
--	returning vehicle_body_type_id into vehiclebodytypeid; 
	

	
	insert into vehiclemodels (model)
		select distinct model from vehicletypes; 
--	returning vehicle_model_id into vehiclemodelid; 
	

	insert into vehiclemakes (make)
		select distinct make from vehicletypes; 
--	returning vehicle_make_id into vehiclemakeid; 
	
	rollback; 

	alter table vehicletypes 
	add column vehicle_body_type_id int 
	references vehiclebodytypes(vehicle_body_type_id); 

	alter table vehicletypes 
	add column vehicle_make_id int 
	references vehiclebodytypes(vehicle_make_id); 

	alter table vehicletypes 
	add column vehicle_model_id int 
	references vehiclebodytypes(vehicle_model_id); 

	rollback; 

	update vehicletypes vt
	set vt.vehicle_body_type_id = vtb.vehicle_body_type_id
	from vehiclebodytypes vtb
	where vt.body_type = vtb.body_type;
	
	update vehicletypes vt
	set vt.make = vtb.vehicle_make_id
	from vehiclemakes vm 
	where vt.make = vm.make;
	
	update vehicletypes vt 
	set vt.model = vmo.vehicle_model_id
	from vehiclemodels vmo 
	where vt.model = vmo.model;
	
	rollback; 

	
	-- need to alter table so that body_type, make, model on vehicletypes table accepts an integer
	alter table vehicletypes 
	alter column body_type set data type integer
	using body_type::integer; 

	alter table vehicletypes 
	alter column make set data type integer
	using make::integer; 

	alter table vehicletypes 
	alter column model set data type integer
	using model::integer; 

	


	rollback; 
	
	exception when others then 
		raise info 'Error:%', sqlerrm; 
	rollback; 
	
--	commit; 
end$$

-- drop original vehicletypes table 





do $$ 
--declare 
--    vehiclebodytypeid int[]; 
--    vehiclemodelid int; 
--    vehiclemakeid int; 
begin 

-- (Create new tables and insert data as you've done)
	
create table vehiclebodytypes (
		vehicle_body_type_id serial primary key, 
		body_type varchar not null
	); 

	create table vehiclemodels (
		vehicle_model_id serial primary key, 
		model varchar not null 
	); 

	
	create table vehiclemakes (
		vehicle_make_id serial primary key, 
		make varchar not null 
	); 
	

	-- insert info for each table 
	insert into vehiclebodytypes (body_type)
		select distinct body_type from vehicletypes; 
	
	insert into vehiclemodels (model)
		select distinct model from vehicletypes; 
	

	insert into vehiclemakes (make)
		select distinct make from vehicletypes; 
	
	rollback; 

-- create temporary integer columns
alter table vehicletypes
add column body_type_id INT references vehiclebodytypes(vehicle_body_type_id),
add column make_id INT references vehiclebodytypes(vehicle_make_id),
add column model_id INT references vehiclebodytypes(vehicle_model_id);

-- update data in the temporary columns based on the foreign keys
update vehicletypes 
set body_type_id = vehicle_body_type_id
from vehiclebodytypes 
where body_type = body_type;

update vehicletypes 
set make_id = vehicle_make_id
from vehiclemakes 
where make = make;

update vehicletypes 
set model_id = vehicle_model_id
from vehiclemodels 
where model = model;

-- drop the original varchar columns
alter table vehicletypes
drop column body_type,
drop column make,
drop column model;

-- rename the temporary columns to match the original column names
alter table vehicletypes
rename column body_type_id to body_type; 

alter table vehicletypes
rename column make_id to make; 

alter table vehicletypes
rename column model_id to model;

rollback; 

insert into vehiclemodels (model)
		select distinct model from vehicletypes;

 rollback; 

exception 
when others then
    raise INFO 'Error:%', sqlerrm; 
    rollback; 
end $$;
