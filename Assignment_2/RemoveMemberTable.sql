-- drop foreign constraint in book retrun 
-- ---------------------------------------
alter table book_return drop foreign key fk_book_return_members1;

-- drop foreign constraint in book_issue
-- --------------------------------------
alter table book_issue drop foreign key fk_book_issue_members;

-- drop members table after deleting of foreign key constraint
-- -----------------------------------------------------------
drop table members;