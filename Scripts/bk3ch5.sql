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
values (5000, 200, CURRENT_DATE );

select * from sales
order by sale_id desc; 

--------------------------------------------------------------------------------------------------------------------

/* trigger for updates to the sales table. if the pickup date is on or before the purchase date, set 
pickup date to 7 days after the purchase date. 
if the pickup date is after the purchase date but less than 7 days out from the purchase date, add 4 additional 
days to the pickup date.
*/  

create or replace function UpdatePickupDate()
returns trigger 
	language plpgsql 
as 
$$
begin
	if new.pickup_date <= new.purchase_date then 
		update sales 
		set pickup_date = purchase_date + integer '7';
	
--		if new.pickup_date > new.purchase_date and new.pickup_date >= new.purchase_date or integer '7' then 
		if new.pickup_date >= new.purchase_date and new.pickup_date < new.purchase_date + integrity '7' then
			update sales 
			set pickup_date = pickup_date + integer '4'; 
		end if; 
	
	end if; 
	
	return null; 
end;
$$

create or replace trigger NewSale
	after update
	on sales 
	for each row 
	execute procedure UpdatePickupDate(); 

insert into sales (sales_type_id, vehicle_id, employee_id, customer_id, dealership_id, price, deposit, purchase_date, pickup_date, invoice_number, payment_method, sale_returned)
values (2, 1001, 400, 22, 16, 6000, 200, '2020-12-01', null, '8032789882', 'MC', false);

update sales 
set pickup_date = '2020-12-01'
-- try with purchase_date
where sale_id = 5049;

select purchase_date, pickup_date from sales 
where sale_id = 5049; 

--delete from sales 
--where sale_id in ()


