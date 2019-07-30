--極端值
SELECT tel,max_sum_fee
FROM
(
    SELECT max(sum_fee) as max_sum_fee
    FROM (
         select tel,sum(fee) as sum_fee
         from bill
         GROUP BY tel
         ) as a 
)as aa,(
    select tel,sum(fee)as sum_fee
    from bill
    group by tel
      ) as bb
WHERE aa.max_sum_fee = bb.sum_fee


--哪個人擁有最多電話
select uid,max_n
FROM(
    SELECT max(n) as max_n
    from(
        SELECT userinfo.uid,COUNT(tel) as n
        FROM userinfo LEFT JOIN live ON userinfo.uid =  live.uid
             LEFT JOIN phone ON live.hid = phone.hid
    GROUP BY userinfo.uid
        ) as a
    )as aa,(
           SELECT userinfo.uid,COUNT(tel) as n
           FROM userinfo LEFT JOIN live ON userinfo.uid = live.uid
               LEFT JOIN phone ON live.hid = phone.hid
           GROUP BY userinfo.uid
           )as bb
WHERE aa.max_n = bb.n


--使用limit
SELECT tel,aa.sum_fee
FROM(
     select sum(fee) as sum_fee
     from bill
     GROUP BY tel
     ORDER BY sum_fee DESC
     limit 1
    )as aa,(
    select tel,sum(fee) as sum_fee
    from bill
    group by tel
    ) as bb
WHERE aa.sum_fee = bb.sum_fee


--視觀表 VIEW

create view vw_檢視表 as 
SELECT tel,aa.sum_fee
FROM(
     select sum(fee) as sum_fee
     from bill
     GROUP BY tel
     ORDER BY sum_fee DESC
     limit 1
    )as aa,(
    select tel,sum(fee) as sum_fee
    from bill
    group by tel
    ) as bb
WHERE aa.sum_fee = bb.sum_fee

--以上建立之後，可以用以下語法查看到表格內容
select * from vw_視觀表


