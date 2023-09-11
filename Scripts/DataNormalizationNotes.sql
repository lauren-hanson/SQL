/* 
Design technique that is used to reduce data redundancy & increase data integrity 
Helps to avoid modifying our database as it grows & simplify our queries

Three commonly used forms of database normalization: 1st, 2nd, 3rd normal form or 1NF, 2NF, 3NF

Normal Form(NF) = progressive. If a database is considered 3NF, it meets requirements for 2NF & 1NF. If database is 2NF, it satisifes all the rules for 1NF

Initial Database 

student 													Cohort 		Zoom				Instructor
Tally Corse, tcoorsef@eventbrite.com 					  1			zoom.1			Steve Brownlee, Andy Collins
patricia Camillo, pcamiloc@ustream.tv, patcam@mtv.com	  1			zoom.1			Steve Brownlee, Andy Collins
Emilia De Blasi, edeblasi2@hud.gov, deblasi@dbc.org		  2			zoom.2			Brenda Long, Joe Shepherd
Tally Corse, tally.corse@mtv.com							  4			zoom.4			Steve Brownlee, Adam Sheaffer
Evan Caulton, ecaultrona@google.de, evan.caulton@educat	  1			zoom.1			Steven Brownlee, Andy Collins

1NF
- values in each column of a table must be atomic 
- there are no repeating groups of columns 

To fulfill first requirement, we will seperate the first & last name 
FirstName     LastName	 	Zoom 		Instructor
Tally		   Corse			zoom.1		Steve Browlee, Andy Collins
Patricia		   Camillo		zoom.1		Steve Brownlee, Andy Collins
Emilia 		   De Blasi		zoom.2		Brenda Long, Joe Shepherd
Tally		   Corse			zoom.4		Steve Brownlee, Adam Sheaffer
Evan			   Caulton		zoom.1		Steve Brownlee, Andy Collins

NEW TABLE FOR EMAIL
LastName		Email
Corse		tcorsef@eventbrite.com
Camillo		pcamilloc@ustream.tv
Camillo		patcam@mtv.com
DeBlasi		edeblasi2@hud.gov
DeBlasi		deblasi.em@dbc.org
Corse		tally.corse@mtv.com
Caulton		ecaultona@google.de
Caulton		evan.caulton@educate.edu

Multiple instructors associated w/ a cohort, add additional tables. 
FirstName     LastName	 	Cohort		Zoom 		
Tally		   Corse			   1 		zoom.1		
Patricia		   Camillo		   1			zoom.1		
Emilia 		   De Blasi		   2			zoom.2		
Tally		   Corse			   4			zoom.4		
Evan			   Caulton		   1			zoom.1		

InstructorId		FullName
1				Steve Brownlee
2				Andy Collins
3				Brenda Long
4				Joe Shepherd
5				Adam Sheaffer

Cohort 		InstructorId
1				1
1				2	
2				3
2				3
4				5
4				1

2NF
- Table must be 1NF 
- Every non candidate-key attribute must depend on the whole candidate key, not just part of it = PK must be a single column

StudentEmailId	LastName		Email
1				Corse		tcorsef@eventbrite.com
2				Camillo		pcamilloc@ustream.tv
3				Camillo		patcam@mtv.com
4				DeBlasi		edeblasi2@hud.gov
5				DeBlasi		deblasi.em@dbc.org
6				Corse		tally.corse@mtv.com
7				Caulton		ecaultona@google.de
8				Caulton		evan.caulton@educate.edu

Multiple instructors associated w/ a cohort, add additional tables. 
StudentId		FirstName     LastName	 	Cohort		Zoom 		
1				Tally		   Corse			   1 		zoom.1		
2				Patricia		   Camillo		   1			zoom.1		
3				Emilia 		   De Blasi		   2			zoom.2		
4				Tally		   Corse			   4			zoom.4		
5				Evan			   Caulton		   1			zoom.1		

InstructorId		FullName
1				Steve Brownlee
2				Andy Collins
3				Brenda Long
4				Joe Shepherd
5				Adam Sheaffer

CohortInstructorId	Cohort 		InstructorId
1					1				1
2					1				2	
3					2				3
4					2				3
5					4				5
6					4				1

3NF 
- Table must be 2NF
- Table contains no transitive dependencies. This means that if a value is changed, the value of another column will change
*/ 