with TotalDealershipSales as 

-- top 5 US states with the most customers who have puchased a vehicle from a dealership participating in the Carnival platform
select 
	distinct d.business_name,
	COUNT(c.state) over (partition by d.dealership_id) as TotalSalesByState
from customers c  
join sales s
	on c.customer_id = s.customer_id 
join dealerships d 
	on s.dealership_id = d.dealership_id 
order by TotalSalesByState desc
limit 5


-- top 5 US zipcodes with the most customers who have purchased a vehicle from a dealership participating in the Carnival platform 
select 
	COUNT(c.zipcode) TotalPurchasesPerZipcode, 
	c.zipcode
from customers c  
join sales s
	on c.customer_id = s.customer_id 
join dealerships d 
	on s.dealership_id = d.dealership_id 
group by c.zipcode 
order by TotalPurchasesPerZipcode desc
limit 5


-- top 5 dealerships with the most customers 
select 
	distinct d.business_name, 
	COUNT(c.customer_id) over (partition by d.dealership_id) CustomersPerDealership
from dealerships d 
join sales s 
	on d.dealership_id = s.dealership_id 
join customers c 
	on s.customer_id = c.customer_id 
order by CustomersPerDealership desc
limit 5
