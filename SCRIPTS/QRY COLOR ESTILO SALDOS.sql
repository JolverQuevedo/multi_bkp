SELECT ESTCLI, COLOR, (guia) as GUIA,sum(sale) AS CANT FROM
(
SELECT  ID, ESTCLI, COLOR, GUIA, GUIA2, PO,
SUM(C0) + SUM(C1) + SUM(C2)+SUM(C3)+ SUM(C4)+SUM(C5)+SUM(C6)+SUM(C7)+ SUM(C8) + SUM(C9) AS SALE ,MOV
FROM VIEW_POS_MOVI
where mov = 'S' and estcli = '540391' and ruc = '20565578902' and codser = '01' and codcon= '00'
GROUP BY color, estcli, ID, GUIA,PO, MOV, guia2
UNION
SELECT  id, ESTCLI, COLOR, GUIA, GUIA2, PO, 
(SUM(C0) + SUM(C1) + SUM(C2)+SUM(C3)+ SUM(C4)+SUM(C5)+SUM(C6)+SUM(C7)+ SUM(C8) + SUM(C9))*-1 AS SALE , MOV
FROM VIEW_POS_MOVI
where mov = 'I'  and estcli = '540391' and ruc = '20565578902' and codser = '01' and codcon= '00'
GROUP BY color, estcli, ID, GUIA, PO,MOV,guia2

) SS
GROUP BY ESTCLI, COLOR,GUIA
having  SUM(SALE) > 0
--where color in ('black09', 'cadminio362', 'cobalto795','LINO883')
ORDER BY estcli, COLOR
