/*
select DISTINCT COLOR  from VIEW_poS_movi
WHERE ESTCLI = 'OJ401AG' and ruc = '10108760040'
*/
SELECT  ESTCLI, COLOR, SUM(SALE) AS SALDO FROM
(SELECT  ESTCLI, COLOR, 
SUM(C0) + SUM(C1) + SUM(C2)+SUM(C3)+ SUM(C4)+SUM(C5)+SUM(C6)+SUM(C7)+ SUM(C8) + SUM(C9) AS sale , MOV
FROM VIEW_POS_MOVI
where mov = 's' and estcli = '540291' and ruc = '20548229520' and codser = '01' and codcon= '00' and coddef = '00'
GROUP BY color, estcli, MOV
UNION
SELECT  ESTCLI, COLOR, 
(SUM(C0) + SUM(C1) + SUM(C2)+SUM(C3)+ SUM(C4)+SUM(C5)+SUM(C6)+SUM(C7)+ SUM(C8) + SUM(C9))*-1 AS SALE , MOV
FROM VIEW_POS_MOVI
where mov = 'i' and estcli = '540291' and ruc = '20548229520' and codser = '01' and codcon= '00' and coddef = '00'
GROUP BY color, estcli, MOV) SS
GROUP BY ESTCLI, COLOR




-- select * from view_pos_movi