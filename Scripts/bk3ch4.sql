select * from sales 

 -- updating vehicle inventory when a sale occurs -- 
create procedure vehicle_sale(p_vehicle_id int)
language plpgsql
as $$ 
begin 
	update vehicles 
	set is_sold = true 
	where vehicle_id = p_vehicle_id;
end 
$$; 

call vehicle_sale(1);



-- returning a vehicle -- 
select * from oilchangelogs  

create or replace procedure vehicle_return(p_vehicle_id int) 
language plpgsql 
as $$ 
begin 
	
	-- is_sold = false 
	update vehicles 
	set is_sold = false 
	where vehicles.vehicle_id = p_vehicle_id; 

	-- sales.sale_returned = true 
	update sales 
	set sale_returned = true 
	where sales.vehicle_id = p_vehicle_id;

	-- oil change? 
	insert into oilchangelogs (date_occured, vehicle_id) values (CURRENT_DATE, p_vehicle_id);
	
	
end
$$; 


call vehicle_return(5); 

-- check to make sure SP is adding information correctly
select 
	distinct v.vehicle_id,
	v.is_sold, 
	s.sale_returned, 
	o.*
from vehicles v
join sales s 
on v.vehicle_id = s.vehicle_id
join oilchangelogs o 
on v.vehicle_id = o.vehicle_id 
where v.vehicle_id = 5








