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




