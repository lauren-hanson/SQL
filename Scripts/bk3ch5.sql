-- trigger for when a new Sales record is added, set the purchase date to 3 days from current date 
create or replace function purchase_date() 
	returns trigger 
	language plpgsql 
	as 
	$$ 
	begin 
		update sales 
		set purchase_date = new.purchase_date + 3
		where sales.sale_id = new.sale_id; 
	return null; 
	end; 
	$$
	
-- binds trigger function to the sales table 
create trigger new_sale_record
	after insert 
	on sales 
	for each row 
	execute procedure purchase_date(); 

update sales 
set  
where id = 2; 
	

/* trigger for updates to the sales table. if the pickup date is on or before the purchase date, set 
pickup date to 7 days after the purchase date. 
if the pickup date is after the purchase date but less than 7 days out from the purchase date, add 4 additional 
days to the pickup date.
*/  