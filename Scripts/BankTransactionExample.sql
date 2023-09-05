-- how to transfer 1000USD from Bob's account to Alice's accoutn 
select * from accounts; 

-- start transaction
begin; 

-- deduct 1000 from account 1
update accounts
set balance = balance - 1000
where id = 1; 

-- add 1000 to account 2 
update accounts 
set balance = balance + 1000 
where id = 3; 

--select data from accounts
select id, name, balance 
from accounts; 

-- commit transaction
commit; 


