--所有屋子裡的住戶清單
SELECT house.hid,house.address,userinfo.uid,userinfo.cname
FROM house RIGHT JOIN live ON
     house.hid = live.hid  
     RIGHT JOIN userinfo ON
     live.uid = userinfo.uid

    