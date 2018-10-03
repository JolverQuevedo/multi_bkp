SELECT  ESTCLI, COLOR, SUM(SALE) AS SALDO FROM
(SELECT  ESTCLI, COLOR, 
SUM(C0) + SUM(C1) + SUM(C2)+SUM(C3)+ SUM(C4)+SUM(C5)+SUM(C6)+SUM(C7)+ SUM(C8) + SUM(C9) AS SALE 
FROM VIEW_POS_MOVI
where mov = 'S' and estcli = '540291' and ruc = '20548229520 ' and codser = '01' and codcon= '00'
GROUP BY color, estcli
UNION
SELECT  ESTCLI, COLOR, 
(SUM(C0) + SUM(C1) + SUM(C2)+SUM(C3)+ SUM(C4)+SUM(C5)+SUM(C6)+SUM(C7)+ SUM(C8) + SUM(C9))*-1 AS SALE 
FROM VIEW_POS_MOVI
where mov = 'I'  and estcli = '540291' and ruc = '20548229520 ' and codser = '01' and codcon= '00'
GROUP BY color, estcli) SS

GROUP BY ESTCLI, COLOR
having  SUM(SALE) > 0

