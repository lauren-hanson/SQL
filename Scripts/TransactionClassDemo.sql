create table petowners(
	ownerId serial PRIMARY key,
	ownername varchar(30),
	ownerphone int,
	hasexotic boolean
)

create table dogs (
dogId serial PRIMARY key,
	dogName varchar(30),
	color varchar(20),
	ownerId int,
	FOREIGN KEY(ownerId) REFERENCES petowners(petownersId)
)

create table cats (
	catId serial PRIMARY key,
	catName varchar(30),
	color varchar(20),
	ownerId int,
	FOREIGN KEY(ownerId) REFERENCES petowners(petownersId)
)

create table vetClinic (
	vetClinicId serial PRIMARY key,
	catName varchar(30),
	color varchar(20),
	ownerId int,
	FOREIGN KEY(ownerId) REFERENCES petowners(petownersId)
)


create table vetClinicCustomer(
	vetClinicCustomerId serial PRIMARY key,
	
	FOREIGN KEY(ownerId) REFERENCES petowners(petownersId)
)



-- Basic transaction syntax & outline what needs to be done 

do $$
declare
-- variables go here
CatId integer; 
DogId integer; 

begin
	-- create new tables 
	CREATE TABLE AnimalsTypes(
	    animalTypeId SERIAL PRIMARY KEY,
	    animalTypeName VARCHAR NOT NULL
	);
	
	CREATE TABLE Animals(
	    animalId SERIAL PRIMARY KEY,
	    animalName VARCHAR NOT NULL,
	    color VARCHAR,
	    ownerId INT not null,
	    animalTypeId INT NOT null,
	    FOREIGN KEY(animalTypeId) REFERENCES AnimalTypes(animalTypeId),
	    FOREIGN KEY(ownerId) REFERENCES PetOwners(ownerId)
	);

	-- migrate data from the cats & dogs table to the new table structure
	-- Need to Insert the animalTypes first
	insert into AnimalTypes (animalTypeName) 
	values ('Cat') 
	returning animalTypeId into CatId;

	insert into AnimalTypes (animalTypeName) 
	values ('Dog') returning animalTypeId 
	into DogId;


	-- Now we need to copy the data from the Cats table to the Animals Table
	INSERT INTO Animals (animalName, color, ownerId, animalTypeId)
	
	-- vars = variables 
	-- declaring vars as catid & give it a value of CatId(declared variable)
	-- this allows for multiples to be added 
    with vars (catid) as (values (CatId))
    
 	select 
 		c.catname, 
 		c.color, 
 		c.ownerid, 
 		v.catid 
 	from vars v 
 	left join cats c 
 	on 1=1;

 	INSERT INTO 
 		Animals (animalName, color, ownerId, animalTypeId)
 	
	-- How do I do this with using some from a query and then a variable?
    with vars (dogid) as (values (DogId))
    
 	select 
 		d.dogname, 
 		d.color, 
 		d.ownerid, 
 		v.dogid 
 	from vars v 
 	left join dogs d 
 	on 1=1;
 
	-- check if data migrated
	-- drop cats & dogs table

	
exception when others then 
rollback; 

commit; 
end $$; 
	
end
