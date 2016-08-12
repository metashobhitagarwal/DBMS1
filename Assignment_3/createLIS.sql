CREATE SCHEMA IF NOT EXISTS `LIS` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `LIS` ;

-- -----------------------------------------------------
-- Table `LIS`.`members`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LIS`.`members` (
  `member_id` INT NOT NULL AUTO_INCREMENT ,
  `member_nm` VARCHAR(80) NOT NULL ,
  `addressLine1` VARCHAR(200) NOT NULL ,
  `addressLine2` VARCHAR(200) NOT NULL ,
  `category` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`member_id`) );


-- -----------------------------------------------------
-- Table `LIS`.`publishers`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LIS`.`publishers` (
  `publisher_id` INT NOT NULL AUTO_INCREMENT,
  `publisher_nm` VARCHAR(80) NOT NULL ,
  PRIMARY KEY (`publisher_id`) );


-- -----------------------------------------------------
-- Table `LIS`.`subjects`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LIS`.`subjects` (
  `subject_id` INT NOT NULL AUTO_INCREMENT,
  `subject_nm` VARCHAR(80) NOT NULL ,
  PRIMARY KEY (`subject_id`) );


-- -----------------------------------------------------
-- Table `LIS`.`title`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LIS`.`title` (
  `title_id` INT NOT NULL AUTO_INCREMENT,
  `title_nm` VARCHAR(80) NOT NULL ,
  `publisher_id` INT NOT NULL ,
  `subject_id` INT NOT NULL ,
  PRIMARY KEY (`title_id`) ,
  INDEX `fk_title_subjects1` (`subject_id` ASC) ,
  CONSTRAINT `fk_title_publishers1`
    FOREIGN KEY (`publisher_id` )
    REFERENCES `LIS`.`publishers` (`publisher_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_title_subjects1`
    FOREIGN KEY (`subject_id` )
    REFERENCES `LIS`.`subjects` (`subject_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `LIS`.`books`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LIS`.`books` (
  `accession_no` INT NOT NULL AUTO_INCREMENT,
  `title_id` INT NOT NULL ,
  `purchase_dt` DATE NOT NULL ,
  `price` FLOAT NOT NULL ,
  `status` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`accession_no`) ,
  INDEX `fk_books_title1` (`title_id` ASC) ,
  CONSTRAINT `fk_books_title1`
    FOREIGN KEY (`title_id` )
    REFERENCES `LIS`.`title` (`title_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `LIS`.`book_issue`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LIS`.`book_issue` (
  `issue_dt` DATE NOT NULL ,
  `due_dt` DATE NOT NULL ,
  `member_id` INT NOT NULL ,
  `accession_no` INT NOT NULL ,
  PRIMARY KEY (`issue_dt`, `member_id`, `accession_no`) ,
  INDEX `fk_book_issue_members` (`member_id` ASC) ,
  INDEX `fk_book_issue_books1` (`accession_no` ASC) ,
  CONSTRAINT `fk_book_issue_members`
    FOREIGN KEY (`member_id` )
    REFERENCES `LIS`.`members` (`member_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_book_issue_books1`
    FOREIGN KEY (`accession_no` )
    REFERENCES `LIS`.`books` (`accession_no` )
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `LIS`.`authors`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LIS`.`authors` (
  `authors_id` INT NOT NULL AUTO_INCREMENT,
  `authors_nm` VARCHAR(80) NOT NULL ,
  PRIMARY KEY (`authors_id`) );


-- -----------------------------------------------------
-- Table `LIS`.`book_return`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LIS`.`book_return` (
  `return_date` DATE NOT NULL ,
  `accession_no` INT NOT NULL ,
  `member_id` INT NOT NULL ,
  `issue_dt` DATE NOT NULL ,
  PRIMARY KEY (`return_date`, `accession_no`, `member_id`) ,
  INDEX `fk_book_return_members1` (`member_id` ASC) ,
  INDEX `fk_book_return_books1` (`accession_no` ASC) ,
  CONSTRAINT `fk_book_return_members1`
    FOREIGN KEY (`member_id` )
    REFERENCES `LIS`.`members` (`member_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_book_return_books1`
    FOREIGN KEY (`accession_no` )
    REFERENCES `LIS`.`books` (`accession_no` )
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `LIS`.`title_authors`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LIS`.`title_authors` (
  `title_id` INT NOT NULL ,
  `authors_id` INT NOT NULL ,
  PRIMARY KEY (`title_id`, `authors_id`) ,
  INDEX `fk_title_authors_title1` (`title_id` ASC) ,
  CONSTRAINT `fk_title_authors_authors1`
    FOREIGN KEY (`authors_id` )
    REFERENCES `LIS`.`authors` (`authors_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_title_authors_title1`
    FOREIGN KEY (`title_id` )
    REFERENCES `LIS`.`title` (`title_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE);

