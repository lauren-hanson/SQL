/*
Provide a way for the accounting team to track all financial transactions by creating a new table called Accounts Receivable.
columns: credit_amount, debit_amount, date_received, PK & FK to associate a sale for each transaction.  
*/

/*
Trigger on the Sales table when a new row is added, add a new record to the Accounts Receivable table w/ deposit as credit_amount, the timestamp as date_received & the appropriate sale_id
*/

select * from sales
order by vehicle_id desc

select * from vehicles
order by vehicle_id desc

-- new table for accounting team 
create table AccountsReceivable (
	accounts_receivable_id int primary key generated always as identity,
	credit_amount numeric(8, 2), 
	debit_amount numeric(8, 2), 
	date_received date, 
	sale_id integer not null, 
	foreign key (sale_id) references sales(sale_id) 
); 

select * from accountsreceivable 

-- declare variable that will store the new sale id so we can pass that to accounting table 
do $$ 
declare 
	NewSaleId

-- create a new purchase 
insert into sales (sales_type_id, vehicle_id, employee_id, customer_id, dealership_id, price, deposit, purchase_date, pickup_date, invoice_number, payment_method, sale_returned)
values (1, 10005, 400, 22, 17, 45827.98, 4567, current_date, current_date, 6273849523, 'Visa', false)
returning sale_id into NewSaleId

-- update vehicle table as sold 
update vehicle v
set is_sold = true 
from sales s 
where v.sale_id = s.sale_id

-- new record for AccountsReceivable
insert into AccountsReceivable(credit_amount, date_received, sale_id)
values (20000, current_date, NewSaleId)


--------------------------------------------------------------------------------------------------------------------------


/*
Trigger on Sales table for when the sale_returned flag is updated. Add a new row to the Accounts Receivable table with the deposit as debit_amount, the timestamp as date_received, etc. 
*/