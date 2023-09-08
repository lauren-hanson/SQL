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
	credit_amount integer, 
	debit_amount numeric(8, 2), 
	date_received date, 
	sale_id integer not null, 
	foreign key (sale_id) references sales(sale_id) 
); 

drop table accountsreceivable 
select * from AccountsReceivable 


-- set up trigger when new row is added, insert row to AR (deposit = credit_amount, timestamp = date_received, sale_id)
create or replace function NewAccountsRecord()
  returns trigger
  language plpgsql 
as $$
begin
  -- trigger function logic
  insert into AccountsReceivable(credit_amount, date_received, sale_id)
  values(new.deposit, new.purchase_date, new.sale_id);
  return null;
end;
$$

create or replace trigger new_sale
  after insert
  on sales
  for each row
  execute procedure NewAccountsRecord();
 
insert into sales(sales_type_id,vehicle_id,employee_id,customer_id,dealership_id,price,deposit,purchase_date,pickup_date,invoice_number,payment_method)
	values(1,1,1,1,1,24333.67,6500,current_date,current_date,1273592747, 'MC');
		

select * from AccountsReceivable a

select * from sales
where price = 24333.67


--------------------------------------------------------------------------------------------------------------------------


--Set up a trigger on the Sales table for when the sale_returned flag is updated. Add a new row to the Accounts Receivable table with the deposit as debit_amount, the timestamp as date_received, etc.
create or replace function returned_lemon_accountsReceivable()
  returns trigger
  language PlPGSQL
as $$
begin
  -- trigger function logic
  IF NEW.sale_returned = TRUE THEN
	  INSERT INTO accountsReceivable(debit_amount, date_received, sale_id)
	  VALUES(NEW.deposit, current_date, NEW.sale_id);
  end if; 
 	return null; 
end;
$$

create or replace trigger sale_returned_flag
	after update of sale_returned
	on sales
	for each row 
	execute procedure returned_lemon_accountsReceivable();

 
update sales
set sale_returned = true
where sale_id = 1

select * from sales s 
where sale_id = 1

select * from AccountsReceivable a


--------------------------------------------------------------------------------------------------------------------------

/*
Set up a trigger on the Sales table for when the sale_returned flag is updated. Add a new row to the Accounts Receivable table with the deposit as debit_amount, the timestamp as date_received, etc.
*/

create or replace function returned_vehicle() 
	returns trigger 
	language plpgsql
as $$
begin 
	if new.sale_returned = true then 
		insert into AccountsReceivable(debit_amount, date_received, sale_id)
 		 values(new.deposit, current_date, new.sale_id);
 	end if; 
 
 	return null; 
 
end; 
$$

create or replace trigger sale_returned_flag
	after update of sale_returned
	on sales
	for each row 
	execute procedure returned_vehicle(); 

update sales 
set sale_returned = true 
where sale_id = 4831

SELECT * FROM sales s 
where sale_id = 5056




