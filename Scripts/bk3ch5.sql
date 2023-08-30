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
create or replace trigger new_sale_record
	after insert
	on sales 
	for each row 
	execute procedure purchase_date(); 

insert into sales (price, deposit, purchase_date)
values (2000, 200, CURRENT_DATE );

select * from sales
order by sale_id desc; 

delete 


/* trigger for updates to the sales table. if the pickup date is on or before the purchase date, set 
pickup date to 7 days after the purchase date. 
if the pickup date is after the purchase date but less than 7 days out from the purchase date, add 4 additional 
days to the pickup date.
*/  

create or replace function update_pickup_date()
returns trigger 
	language plpgsql 
as 
$$
begin
	if new.pickup_date <= new.purchase_date then 
	-- used to assign a value to a variable or a column w/i a record 
		new.pickup_date := new.purchase_date + interval '7';
	end if; 
return new; 
	
end;
$$

create or replace trigger new_sale
	before update
	on sales 
	for each row 
	execute procedure update_pickup_date(); 

insert into sales (price, deposit, purchase_date)
values (2000, 200, CURRENT_DATE );

select * from sales 
order by sale_id desc; 


