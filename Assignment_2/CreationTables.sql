


CREATE SCHEMA IF NOT EXISTS `sasdb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;

USE `sasdb` ;



-- -----------------------------------------------------

-- Table `sasdb`.`members`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `sasdb`.`members` (

  `member_id` INT NOT NULL AUTO_INCREMENT ,

  `member_nm` VARCHAR(70) NOT NULL ,

  `addressline1` VARCHAR(100) NOT NULL ,

  `addressline2` VARCHAR(100) NOT NULL ,

  `category` VARCHAR(45) NOT NULL ,

  PRIMARY KEY (`member_id`) );





-- -----------------------------------------------------

-- Table `sasdb`.`subjects`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `sasdb`.`subjects` (

  `subject_id` INT NOT NULL AUTO_INCREMENT ,

  `subject_nm` VARCHAR(70) NOT NULL ,

  PRIMARY KEY (`subject_id`) );





-- -----------------------------------------------------

-- Table `sasdb`.`publishers`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `sasdb`.`publishers` (

  `publisher_id` INT NOT NULL AUTO_INCREMENT ,

  `publisher_nm` VARCHAR(45) NOT NULL ,

  PRIMARY KEY (`publisher_id`) );





-- -----------------------------------------------------

-- Table `sasdb`.`authors`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `sasdb`.`authors` (

  `author_id` INT NOT NULL AUTO_INCREMENT ,

  `author_nm` VARCHAR(45) NOT NULL ,

  PRIMARY KEY (`author_id`) );





-- -----------------------------------------------------

-- Table `sasdb`.`titles`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `sasdb`.`titles` (

  `title_id` INT NOT NULL ,

  `title_nm` VARCHAR(45) NOT NULL ,

  `subject_id` INT NOT NULL ,

  `publisher_id` INT NOT NULL ,

  PRIMARY KEY (`title_id`) ,

  INDEX `fk_titles_subjects` (`subject_id` ASC) ,

  INDEX `fk_titles_publishers1` (`publisher_id` ASC) ,

  CONSTRAINT `fk_titles_subjects`

    FOREIGN KEY (`subject_id` )

    REFERENCES `sasdb`.`subjects` (`subject_id` )

    ON DELETE CASCADE

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_titles_publishers1`

    FOREIGN KEY (`publisher_id` )

    REFERENCES `sasdb`.`publishers` (`publisher_id` )

    ON DELETE CASCADE

    ON UPDATE NO ACTION);





-- -----------------------------------------------------

-- Table `sasdb`.`books`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `sasdb`.`books` (

  `accession_no` INT NOT NULL AUTO_INCREMENT ,

  `title_id` INT NOT NULL ,

  `purchase_dt` DATETIME NOT NULL ,

  `price` INT NOT NULL ,

  `status` VARCHAR(45) NOT NULL ,

  PRIMARY KEY (`accession_no`) ,

  INDEX `fk_books_titles1` (`title_id` ASC) ,

  CONSTRAINT `fk_books_titles1`

    FOREIGN KEY (`title_id` )

    REFERENCES `sasdb`.`titles` (`title_id` )

    ON DELETE CASCADE

    ON UPDATE NO ACTION);





-- -----------------------------------------------------

-- Table `sasdb`.`book_issue`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `sasdb`.`book_issue` (

  `issue_dt` DATETIME NOT NULL ,

  `accession_no` INT NOT NULL ,

  `member_id` INT NOT NULL ,

  `due_dt` DATETIME NULL DEFAULT NULL ,

  PRIMARY KEY (`issue_dt`, `accession_no`, `member_id`) ,

  INDEX `fk_book_issue_books1` (`accession_no` ASC) ,

  INDEX `fk_book_issue_members1` (`member_id` ASC) ,

  CONSTRAINT `fk_book_issue_books1`

    FOREIGN KEY (`accession_no` )

    REFERENCES `sasdb`.`books` (`accession_no` )

    ON DELETE CASCADE

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_book_issue_members1`

    FOREIGN KEY (`member_id` )

    REFERENCES `sasdb`.`members` (`member_id` )

    ON DELETE CASCADE

    ON UPDATE NO ACTION);





-- -----------------------------------------------------

-- Table `sasdb`.`title_author`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `sasdb`.`title_author` (

  `title_id` INT NOT NULL ,

  `author_id` INT NOT NULL ,

  PRIMARY KEY (`title_id`, `author_id`) ,

  INDEX `fk_titles_has_authors_authors1` (`author_id` ASC) ,

  INDEX `fk_titles_has_authors_titles1` (`title_id` ASC) ,

  CONSTRAINT `fk_titles_has_authors_titles1`

    FOREIGN KEY (`title_id` )

    REFERENCES `sasdb`.`titles` (`title_id` )

    ON DELETE CASCADE

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_titles_has_authors_authors1`

    FOREIGN KEY (`author_id` )

    REFERENCES `sasdb`.`authors` (`author_id` )

    ON DELETE CASCADE

    ON UPDATE NO ACTION);





-- -----------------------------------------------------

-- Table `sasdb`.`book_return`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `sasdb`.`book_return` (

  `return_dt` DATETIME NOT NULL ,

  `accession_no` INT NOT NULL ,

  `member_id` INT NOT NULL ,

  `issue_dt` DATETIME NOT NULL ,

  PRIMARY KEY (`return_dt`, `accession_no`, `member_id`) ,

  INDEX `fk_book_return_members1` (`member_id` ASC) ,

  INDEX `fk_book_return_books1` (`accession_no` ASC) ,

  INDEX `fk_book_return_book_issue1` (`issue_dt` ASC) ,

  CONSTRAINT `fk_book_return_members1`

    FOREIGN KEY (`member_id` )

    REFERENCES `sasdb`.`members` (`member_id` )

    ON DELETE CASCADE

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_book_return_books1`

    FOREIGN KEY (`accession_no` )

    REFERENCES `sasdb`.`books` (`accession_no` )

    ON DELETE CASCADE

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_book_return_book_issue1`

    FOREIGN KEY (`issue_dt` )

    REFERENCES `sasdb`.`book_issue` (`issue_dt` )

    ON DELETE CASCADE

    ON UPDATE NO ACTION);







