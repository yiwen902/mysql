 CREATE TABLE `homework`.`userinfo`
 ( 
   `UID` VARCHAR(10) NOT NULL , 
   `cname` VARCHAR(40) NOT NULL ,
   `u_pic` BLOB NOT NULL ,PRIMARY KEY (`UID`)
 )
 ENGINE = InnoDB;

 CREATE TABLE `homework`.`orderinfo` 
 ( 
   `uid` VARCHAR(10) NOT NULL ,
   `order_no` int(6) NOT NULL AUTO_INCREMENT  ,
   `time` DATETIME NOT NULL,PRIMARY KEY (`order_no`)
 ) 
 ENGINE = InnoDB;

 CREATE TABLE `homework`.`buy`
  ( 
    `order_no` int(6) NOT NULL AUTO_INCREMENT ,
    `pid` VARCHAR(10) NOT NULL  , 
    `amout` INT(10) NOT NULL , PRIMARY KEY (`order_no`, `pid`)
  )
  ENGINE = InnoDB;

  CREATE TABLE `homework`.`product` 
  ( 
    `pid` VARCHAR(10) NOT NULL , 
    `img` BLOB NOT NULL , PRIMARY KEY (`pid`)
  ) 
  ENGINE = InnoDB;