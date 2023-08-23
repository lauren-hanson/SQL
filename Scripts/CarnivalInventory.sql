select * from dealerships d
select * from vehicles v 

-- model w/ lowest current inventory
select 
	distinct vt.model, 
	d.business_name,
	COUNT(vt.model) ModelInventory
from dealerships d 
inner join vehicles v 
	on d.dealership_id = v.dealership_location_id 
inner join vehicletypes vt	
	on v.vehicle_type_id = vt.vehicle_type_id
where is_sold = false
group by vt.model, d.business_name
order by d.business_name 


-- single count of single model at single dealership
select 
	COUNT(vt.model), 
	vt.model, 
	d.business_name 
from dealerships d 
join vehicles v 
	on d.dealership_id = v.dealership_location_id 
left join vehicletypes vt	
	on v.vehicle_type_id = vt.vehicle_type_id
where is_sold = false 
	and d.business_name like 'Alwell%' 
	and model = 'Corvette'
group by vt.model, d.business_name 



-- model w/ highest current inventory

-- dealerships selling the least number of vehicle models

-- dealership selling the highest number of vehicle models