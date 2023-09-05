/* 
add 5 brand new 2021 honda cr-vs to the inventory
engines: I4
crossover SUV or CUV
interior: beige
exterior: Lilac, Dark REd, Lime, Navy & Sand 
price: $21755
MSR: $18999	
*/

select * from vehicles
where vehicle_type_id = 31

do $$ 
declare 
	NewVehicleTypeId integer;

-- start a transaction
begin

-- insert the new vehicles to inventory
insert into 
vehicletypes(
	body_type, 
	make, 
	model
)
values('CUV', 'Honda', 'CR-V')
returning vehicle_type_id into NewVehicleTypeId;

insert into 
vehicles(
	vin, engine_type, vehicle_type_id, exterior_color, interior_color, floor_price, msr_price, miles_count, year_of_car, is_sold, is_new, dealership_location_id 
)
values
	('1HGCM82633A123456', 'I4', NewVehicleTypeId, 'Lilac', 'Beige', 21755, 18999, 57, 2021, false, true, null), 
	('3GNFK16396G123789', 'I4', NewVehicleTypeId, 'Dark Red', 'Beige', 21755, 18999, 42, 2021, false, true, null), 
	('JH4KA8260MC123654', 'I4', NewVehicleTypeId, 'Lime', 'Beige', 21755, 18999, 38, 2021, false, true, null),
	('1GCEC14H7BZ123321', 'I4', NewVehicleTypeId, 'Navy', 'Beige', 21755, 18999, 64, 2021, false, true, null),
	('5YJSA1E29HF123987', 'I4', NewVehicleTypeId, 'Sane', 'Beige', 21755, 18999, 25, 2021, false, true, null);

-- commit the change
exception when others then 
  -- RAISE INFO 'name:%', SQLERRM;
  rollback;

end;

$$ language plpgsql;


/* 
for cx-5s & cx-9s that have not been sold: 
change year to 2021
for unsold Mazdas: 
update year to 2020
newer Mazdas = red & black interiors
*/

-- query for Mazda CX-5, CX-9
select 
	v.vehicle_id,
	v.exterior_color,
	v.interior_color,
	v.is_sold,
	vt.make,
	vt.model
from vehicles v
join vehicletypes vt 
on v.vehicle_id = vt.vehicle_type_id 
where vt.model in ('CX-5', 'CX-9') and v.is_sold = false
-- vt.make = 'Mazda' and



begin; 

update vehicles 
set year_of_car = 2021
where model in (
	select * 
	from vehicletypes 
	where make = 'Mazda' and model in ('CX-5', 'CX-9')
) and is_sold = false

commit; 


/*
Vehicle w/ vin KNDPB3A20D7558809 is about to be returned. 
most recently hired employee accepts returned vehicle at 70% of the cost is previously sold for
the employee & dealership who sold the car originally will beon the new sales transaction
*/