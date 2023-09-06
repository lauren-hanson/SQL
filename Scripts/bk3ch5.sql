-- trigger for when a new Sales record is added, set the purchase date to 3 days from current date 
create or replace function purchase_date() 
	returns trigger 
	language plpgsql 
	as 
	$$ 
	begin 
		update sales 
		set purchase_date = new.purchase_date + interval '3 days'
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

insert into sales (vehicle_id, sales_type_id, employee_id, customer_id, dealership_id, price, deposit, purchase_date)
values (1, 2, 3, 4, 8000, 400, CURRENT_DATE );

select * from sales
order by sale_id desc; 


----------------------------------------------------------------------------------------------------------------------------


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
	if new.pickup_date <= old.purchase_date then
		new.pickup_date := old.purchase_date + interval '7 days';
	
	elseif new.pickup_date > new.purchase_date 
        AND new.pickup_date < new.purchase_date + interval '7 days' THEN
        new.pickup_date := old.pickup_date + interval '4 days';
       
    end if;
	return new; 
end;
$$


create or replace trigger NewSale
	before update
	on sales 
	for each row 
	execute procedure UpdatePickupDate(); 


insert into sales (sales_type_id, vehicle_id, employee_id, customer_id, dealership_id, price, deposit, purchase_date, pickup_date, invoice_number, payment_method, sale_returned)
values (2, 1001, 400, 22, 16, 6000, 200, '2020-12-01', '2020-12-01', '8032789882', 'MC', false);


update sales 
set pickup_date = '2020-12-06'
where sale_id = 5056;


select sale_id, purchase_date, pickup_date 
from sales 
order by sale_id desc;



