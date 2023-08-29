DROP TABLE IF EXISTS links;

CREATE TABLE links (
    id serial PRIMARY KEY,
    url varchar(255) NOT NULL,
    name varchar(255) NOT NULL,
    description varchar(255),
    rel varchar(10),
    last_update date DEFAULT now()
);

INSERT INTO  
   links 
VALUES 
   ('1', 'https://www.postgresqltutorial.com', 'PostgreSQL Tutorial', 'Learn PostgreSQL fast and easy', 'follow', '2013-06-02'),
   ('2', 'http://www.oreilly.com', 'O''Reilly Media', 'O''Reilly Media', 'nofollow', '2013-06-02'),
   ('3', 'http://www.google.com', 'Google', 'Google', 'nofollow', '2013-06-02'),
   ('4', 'http://www.yahoo.com', 'Yahoo', 'Yahoo', 'nofollow', '2013-06-02'),
   ('5', 'http://www.bing.com', 'Bing', 'Bing', 'nofollow', '2013-06-02'),
   ('6', 'http://www.facebook.com', 'Facebook', 'Facebook', 'nofollow', '2013-06-01'),
   ('7', 'https://www.tumblr.com/', 'Tumblr', 'Tumblr', 'nofollow', '2013-06-02'),
   ('8', 'http://www.postgresql.org', 'PostgreSQL', 'PostgreSQL', 'nofollow', '2013-06-02');
   
 select * from links
 
 delete from links 
 where id = 8
 

 -- deletes row with id 7 & returns the deleted row to the client 
 delete from links 
 where id = 7 
 returning * 
 
 -- deleting multiple rows & return values in the id column of deleted rows 
 delete from links 
 where id in (6,5)
 returning * 
 
 -- this will delete ALL rows 
 delete from links 
 
 
 /* DELETE W/ JOINS*/
 
 drop table if exists contacts; 
 create table contacts( 
 	contact_id serial primary key, 
 	first_name varchar(50) not null, 
 	last_name varchar(50) not null, 
 	phone varchar(15) not null
 );
 
 drop table if exists blacklist; 
 create table blacklist (
 	phone varchar(15) primary key 
 );
 
 insert into contacts(first_name, last_name, phone) 
 values ('John', 'Doe', '(408)-523-9874'),
 ('Jane', 'Doe', '(408)-511-9886'), 
 ('Lily', 'Bush', '(408)-124-9221'); 
 
insert into blacklist(phone)
values ('(408)-523-9874'), ('(408)-511-9876');

select * from contacts
select * from blacklist 

-- delete contacts in contacts table where phone # exists in blacklist table 
delete from contacts 
using blacklist 
where contacts.phone = blacklist.phone; 

-- delete join using a subquery 
delete from contacts 
where phone in (select phone from blacklist); 