/*
Provide a way for the accounting team to track all financial transactions by creating a new table called Accounts Receivable.
columns: credit_amount, debit_amount, date_received, PK & FK to associate a sale for each transaction.  
*/

select * from sales

/*
Trigger on the Sales table when a new row is added, add a new record to the Accounts Receivable table w/ deposit as credit_amount, the timestamp as date_received & the appropriate sale_id
*/

/*
Trigger on Sales table for when the sale_returned flag is updated. Add a new row to the Accounts Receivable table with the deposit as debit_amount, the timestamp as date_received, etc. 
*/