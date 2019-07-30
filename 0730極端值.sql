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