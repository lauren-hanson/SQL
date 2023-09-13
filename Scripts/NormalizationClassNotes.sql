/*
Data Normalization: 1NF 
1. values in each column of a table must be atomic 
2. there are no repeating groups of columns 

ensures multiple rows aren't updated 
allows for updates to be made easily

Data Normalization: 2NF
1. table must be in 1NF
2. every non candidate-key attribute must depend on the whole candidate key, not just part of it. This means that the PK must be a single column

Data Normalization: 3NF
1. table must be in 2NF
2. table has no transitive dependencies. A transitive dependency means that if you change the value of a column, the value of another column will also change 
*/