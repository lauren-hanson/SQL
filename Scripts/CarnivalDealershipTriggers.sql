/* anytime a new dealership is added or an existing dealership is updated, website URL should have 
 following format : http://www.carnivalcars.com/{name of the dealership with underscores separating words}
 */

create or replace function website_url()
	return trigger 
	as 
	$$
	begin 
		-- logic 
	end;
	$$
	
create trigger set_website_url 
(before | after)
[insert | update | delete]
on [table_name]
[for each row | for each column]
[trigger_body]


/* if no phone # is provided, set default to 777-111-0305 */
create or replace function default_number()
	return trigger 
	as 
	$$
	begin 
		-- logic 
	end;
	$$

/* if tax is provided, then it should be recorded into database as bv-832-2h-se8w--virginia */
create or replace function tax_records()
	return trigger 
	as 
	$$
	begin 
		-- logic 
	end;
	$$
	
