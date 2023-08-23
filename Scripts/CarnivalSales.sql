select * from dealerships d 
select * from employees e  

-- total purchase sales income per dealership 
select 
	distinct d.business_name, 
	SUM(s.price) OVER(partition by d.business_name) as SalesIncome
from dealerships d 
inner join sales s 
	on d.dealership_id = s.dealership_id 
inner join salestypes st	
	on s.sales_type_id = st.sales_type_id 
where st.sales_type_name ='Purchase'
order by d.business_name 


-- purchase sales income per dealership for July of 2020
select 
	distinct d.business_name,
	SUM(s.price) OVER(partition by d.business_name) SalesTotal
from dealerships d 
inner join sales s 
	on d.dealership_id = s.dealership_id 
inner join salestypes st	
	on s.sales_type_id = st.sales_type_id 
where extract(year from s.purchase_date) = 2020
	and extract(month from s.purchase_date) = 7
	and st.sales_type_name = 'Purchase'



-- purchase sales income per dealership for all of 2020 
select 
	distinct d.business_name,
	st.sales_type_name,
	SUM(s.price) OVER(partition by d.business_name)
from dealerships d 
inner join sales s 
	on d.dealership_id = s.dealership_id 
inner join salestypes st	
	on s.sales_type_id = st.sales_type_id 
where extract(year from s.purchase_date) = 2020 and st.sales_type_name = 'Purchase'



-- total lease income for dealership 
select 
	distinct d.business_name as dealership,
	SUM(s.price) OVER(partition by d.business_name) LeaseTotal
from dealerships d 
inner join sales s 
	on d.dealership_id = s.dealership_id 
inner join salestypes st	
	on s.sales_type_id = st.sales_type_id 
where st.sales_type_name = 'Lease'



-- lease income per dealership for Jan of 2020 

select 
	distinct d.business_name as dealership,
	SUM(s.price) OVER(partition by d.business_name) LeaseTotal
from dealerships d 
inner join sales s 
	on d.dealership_id = s.dealership_id 
inner join salestypes st	
	on s.sales_type_id = st.sales_type_id 
where st.sales_type_name = 'Lease'	
	and extract(year from s.purchase_date) = 2020
	and extract(month from s.purchase_date) = 1


-- lease income per dealership for all of 2019 
select 
	distinct d.business_name as dealership,
	SUM(s.price) OVER(partition by d.business_name) LeaseTotal
from dealerships d 
inner join sales s 
	on d.dealership_id = s.dealership_id 
inner join salestypes st	
	on s.sales_type_id = st.sales_type_id 
where st.sales_type_name = 'Lease'	
	and extract(year from s.purchase_date) = 2019


-- total income(purchase & lease) per employee
select 
	distinct d.business_name as dealership,
	SUM(s.price) OVER(partition by d.business_name) LeaseTotal
from dealerships d 
inner join sales s 
	on d.dealership_id = s.dealership_id 
inner join salestypes st	
	on s.sales_type_id = st.sales_type_id 
	

