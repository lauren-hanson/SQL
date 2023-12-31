/* anytime a new dealership is added or an existing dealership is updated, website URL should have 
 following format : http://www.carnivalcars.com/{name of the dealership with underscores separating words}
 */

select * from dealerships
order by dealership_id desc; 

create or replace function website_url()
	returns trigger 
	language plpgsql 
	as 
	$$
	begin 
		update dealerships
		set website = 'http://www.carnivalcars.com/'||city;
		return new;
		
	end;
	$$


create or replace trigger set_website_url
	after insert
	on dealerships 
	for each row
	execute procedure website_url(); 

insert into dealerships (business_name, phone, city, state, website, tax_id)
values('Hussung Autos of Bon Aqua', '333-333-3333', 'Bon Aqua', 'Tennessee', 'http://www.hussungautos.com', 'jk-098-qw-a76h')


/* if no phone # is provided, set default to 777-111-0305 */
select * from dealerships
order by dealership_id desc; 

create or replace function default_number()
	returns trigger 
	language plpgsql 
	as 
	$$
	begin 
		if new.phone is null then 
			new.phone := '777-111-0305';
		end if; 
		return new; 
		
	end;
	$$;
	
create or replace trigger set_default_number
	before insert
	on dealerships 
	for each row
	execute procedure default_number(); 

insert into dealerships (business_name, phone, city, state, website, tax_id)
values('Thomas Autos or North Carolina', null, 'Bryson City', 'North Carolina', 'http://www.brysoncityautos.com', 'er-932-th-e87w')



/* if tax is provided, then it should be recorded into database as bv-832-2h-se8w--virginia */
create or replace function tax_records()
	returns trigger 
	language plpgsql 
	as 
	$$
	begin 
		new.tax_id := new.tax_id||'--'||new.state;
		return new;
	end;
	$$
	
	create or replace trigger set_tax_id
	before insert
	on dealerships 
	for each row
	execute procedure tax_records(); 



insert into dealerships (business_name, phone, city, state, website, tax_id)
values('Tomita Autos of Florida', null, 'Tampa', 'Florida', 'http://www.tampaautos.com', 'kl-578-bf-d49a')

update dealerships 
set tax_id = replace(tax_id, '--'||city, '--'|| state) 

--WHERE tax_id = tax_id||'--'||city
