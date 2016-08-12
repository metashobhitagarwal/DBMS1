
 select * from title where title_id=1;
 select * from title_authors where title_id=1;
 select * from books where title_id=1;
 
 -- deleting row from title table where publisher id is 1
 -- -------------------------------------------------------
 delete from title where publisher_id=1;