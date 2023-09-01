-- similar to stored procedure except it returns something

--create trigger set_website_url 
--(before | after)
--[insert | update | delete]
--on [table_name]
--[for each row | for each column]
--[trigger_body]

create function set_net_price() 
returns trigger
language plpgsql 
as $$
begin 
	-- trigger function logic -- 
	update product
	set net_price = price - price * discount
	from product_segment
	where product.segment_id = product_segment.id;

	return null 
end; 
$$

create trigger new_new_price 
after insert 
on product 
for each statement 
execute procedure set_net_price(); 




