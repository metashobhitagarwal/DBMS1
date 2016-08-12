-- recreate members table inside sasdb database
-- -------------------------------------------
CREATE  TABLE IF NOT EXISTS `sasdb`.`members` (
  `member_id` INT NOT NULL AUTO_INCREMENT ,
  `member_nm` VARCHAR(80) NOT NULL ,
  `addressLine1` VARCHAR(200) NOT NULL ,
  `addressLine2` VARCHAR(200) NOT NULL ,
  `category` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`member_id`) );
  
-- add foreign key constraint inside book_return 
-- ----------------------------------------------
  alter table book_return add  constraint  fk_book_return_members1 FOREIGN KEY (member_id) REFERENCES members(member_id);
  
  -- add foreign key constraint inside book_issue 
-- ----------------------------------------------
  alter table book_issue add  constraint  fk_book_issue_members FOREIGN KEY (member_id) REFERENCES members(member_id);