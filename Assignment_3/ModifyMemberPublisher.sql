use lis;

-- change address lines in members table
-- ------------------------------
SET SQL_SAFE_UPDATES=0;
update members set `addressLine2` = 'jaipur' ;

update members set `addressLine1` = 'EPIP, Sitapura' where category = 'F' ;

SET SQL_SAFE_UPDATES=1;
select * from members;


-- drop foreign constraint in publishers 
-- ---------------------------------------
alter table title drop foreign key fk_title_publishers1;

-- deleting all data from publisher table
-- --------------------------------------
TRUNCATE TABLE publishers;
select * from publishers;


-- inserting sample data into publisher table using substitution variables
-- ------------------------------------------------------------------------
set @publisher = 'TMH';
 INSERT INTO publishers(publisher_nm)VALUES(@publisher);
 
 set @publisher = 'Shobhit';
 INSERT INTO publishers(publisher_nm)VALUES(@publisher);