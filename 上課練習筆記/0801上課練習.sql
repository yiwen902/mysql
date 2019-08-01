 CREATE TABLE `addressbook`.`log` 
 ( 
 `id` INT(10) NOT NULL AUTO_INCREMENT , 
 `body` VARCHAR(40) NOT NULL , 
 `dd` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP , 
 PRIMARY KEY (`id`)
 ) ENGINE = InnoDB;

 /*Trigger 紀錄LOG用，一定要有文件 */


DELIMITER $$
CREATE TRIGGERtr_trigger_name
AFTER INSERT
ON table_name FOR EACH ROW
BEGIN
--trigger 觸發後要做的事情寫這裡
END $$DELIMITER;




DELIMITER $$
create trigger tr_log_userinfo_insert
after 
insert on userinfo for each row
begin
set @body = concat
('將[', new.uid, ', ', new.cname, '] 加到userinfo資料表中');
insert into log (body) values (@body);
end $$
DELIMITER;

--中斷trigger  範例：擋住一次兩筆以上的資料異動 --

DELIMITER $$
create trigger tr_log_userinfo_update 
before update on userinfo for each row
BEGIN
     set @count = if (@count is null,1,(@count+1));
     if @count > 1 then
     signal sqlstate '45001' set message_text ='stop!!';
     end if;
END
DELIMITER;

--建立預取程序 (帶參數) --
DELIMITER $$
CREATE PROCEDURE live_where(location varchar(20))
BEGIN
     SELECT * from vw_user WHERE address like concat(location , '%');
end $$


--參數類型  可以設定成 in(輸入)  out(輸出)  inout(輸入與輸出) --
DELIMITER $$
CREATE PROCEDURE double_value (v int,out res int)
BEGIN
     set res = v * 2;
END;

--function 建立函式--
CREATE FUNCTION f_add(v1 float,v2 float) RETURNS float
RETURN v1+v2 ;


SELECT f_add(1.1,2,2);   --可得到 f_add = 3.3

set @r = f_add(2.2,1.1);  ---將f_add 設置成@r
SELECT @r;

--變數宣告--  
set @n =10;  --宣告預設為10
SET @n =(SELECT COUNT(*) FROM userinfo); 
SELECT @n;

set @n =10;
SELECT @n := COUNT(*) FROM userinfo;
SELECT @n;



DELIMITER $$
CREATE PROCEDURE pro_name()
BEGIN
     update userinfo set cname ='豬小弟' WHERE uid = "A09"
     INSERT INTO userinfo (uid) VALUES ('A01');
END $$


CREATE PROCEDURE pro_name() 
BEGIN 
     DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'error'; 
     INSERT INTO userinfo (uid) VALUES ('A01'); 
     update userinfo set cname ='朱小妹' WHERE uid = "A04"; 
END



DELIMITER $$
CREATE PROCEDURE pro_name()
BEGIN
     declare _rollback bool default false ;
     declare CONTINUE HANDLER FOR SQLEXCEPTION SET _rollback = true;
     
     start TRANSACTION;
     INSERT INTO userinfo (uid) VALUES ('A04');
     update userinfo set cname ='朱小妹' WHERE uid = "A01";
     if _rollback THEN
        SELECT 'rollback'
        ROLLBACK;
     ELSE
        SELECT 'commit'
        COMMIT;
     end IF;
END $$

--FETCH 讓資料可以一筆一筆處理 --      

DELIMITER $$
CREATE PROCEDURE pro_test1()
BEGIN
     DECLARE done int DEFAULT false;
     DECLARE tmp_fee int;
     DECLARE total int DEFAULT 0;
     DECLARE curs CURSOR for SELECT fee FROM bill;
     DECLARE CONTINUE HANDLER FOR NOT FOUND set done = true;
     
     open curs;
     FETCH curs INTO tmp_fee;
     
     WHILE NOT done DO
         set total = total + tmp_fee;
         FETCH curs into tmp_fee;
     end WHILE;
     
     close curs;
     SELECT total;
end $$

--阿拉伯數字轉大寫數字--

delimiter $$
create procedure chinese()
begin
    declare done int default false;
    declare tmp_fee int;
    declare tmp_tel varchar(20);
    declare tmp_dd datetime;

    declare word varchar(30) default '零壹貳叁肆伍陸柒捌玖';
    declare str varchar(20);
    declare tmp_word varchar(40);
    declare n int;

    declare c cursor for select tel, dd, fee from bill;
    declare continue handler for not found set done = true;

    open c;
    fetch c into tmp_tel, tmp_dd, tmp_fee;
    while not done do
        set str = convert(tmp_fee, varchar(20));
        select str;
        
        set tmp_word = '';
        set n = 1;
        while n <= length(str) do
            set tmp_word = concat(tmp_word, substring(word, convert(substring(str, n, 1), int) + 1, 1));
            set n = n + 1;
        end while;
        select tmp_word;
        update bill set chinese = tmp_word where tel = tmp_tel and dd = tmp_dd;

        fetch c into tmp_tel, tmp_dd, tmp_fee;
    end while;

    close c;
end$$

delimiter ;

-----------------------------------------------------------

DELIMITER $$
CREATE PROCEDURE pro_test1()
BEGIN
     DECLARE done int DEFAULT false;
     DECLARE fee int;
     DECLARE chn int DEFAULT 0;
     DECLARE curs CURSOR for SELECT fee FROM bill;
     DECLARE CONTINUE HANDLER FOR NOT FOUND set done = true;
     
     open curs;
     FETCH curs INTO fee;
     WHILE NOT done DO
         set chn = '零';
         FETCH curs into fee;
     end WHILE;
  end $$

