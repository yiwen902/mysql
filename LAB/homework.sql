CREATE TABLE `homework`.`userinfo`
 ( 
   `UID` VARCHAR(10) NOT NULL , 
   `cname` VARCHAR(40) NULL ,
   `u_pic` BLOB NOT NULL , PRIMARY KEY (`UID`)
) ENGINE = InnoDB;