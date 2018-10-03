declare @EST CHAR(50)
declare	@RUC CHAR(18)
declare	@SER CHAR(2)
declare	@CON CHAR(2)
declare	@DEF CHAR(2)
declare	@gui char(25)

set @EST = 'UW2080'
set @RUC = '20600654838' -- CM INVERSIONES ASOCIADOS E.I.R.L.  - CONFECCIONES
set @SER = '01'
set @CON = '00'
set @DEF = '00'
set @gui = ''


SELECT  ESTCLI, COLOR, SUM(SALE) AS SALDO, (GUIA) AS GUIA, PO, ruc,nompro FROM
(SELECT  ID, ESTCLI, COLOR, GUIA, PO, ruc, nompro,
SUM(C0) + SUM(C1) + SUM(C2)+SUM(C3)+ SUM(C4)+SUM(C5)+SUM(C6)+SUM(C7)+ SUM(C8) + SUM(C9) AS SALE 
FROM VIEW_POS_MOVI
where mov = 'S' and estcli = @EST --and ruc = @RUC 
and codser = @SER and codcon= @CON 
GROUP BY color, estcli, ID, GUIA,PO, MOV,ruc, nompro
UNION
SELECT  ID, ESTCLI, COLOR, GUIA, PO, ruc,nompro,
(SUM(C0) + SUM(C1) + SUM(C2)+SUM(C3)+ SUM(C4)+SUM(C5)+SUM(C6)+SUM(C7)+ SUM(C8) + SUM(C9))*-1 AS SALE 
FROM VIEW_POS_MOVI
where mov = 'I' and estcli = @EST --and ruc = @RUC 
and codser = @SER and codcon= @CON
GROUP BY  color, estcli, ID, GUIA, PO,MOV,ruc, nompro) SS

GROUP BY ESTCLI, COLOR,GUIA, po,ruc, nompro
having  SUM(SALE) > 0 -- and guia = @gui
ORDER BY estcli, ruc, guia,color,po


/*SELECT  ID, ESTCLI, COLOR, GUIA, PO,
SUM(C0) + SUM(C1) + SUM(C2)+SUM(C3)+ SUM(C4)+SUM(C5)+SUM(C6)+SUM(C7)+ SUM(C8) + SUM(C9) AS SALE 
FROM VIEW_POS_MOVI
where mov = 'S' and estcli = @EST and ruc = @RUC and codser = @SER and codcon= @CON 
GROUP BY color, estcli, ID, GUIA,PO, MOV
UNION
SELECT  ID, ESTCLI, COLOR, GUIA, PO, 
(SUM(C0) + SUM(C1) + SUM(C2)+SUM(C3)+ SUM(C4)+SUM(C5)+SUM(C6)+SUM(C7)+ SUM(C8) + SUM(C9))*-1 AS SALE 
FROM VIEW_POS_MOVI
where mov = 'I' and estcli = @EST and ruc = @RUC and codser = @SER and codcon= @CON
GROUP BY  color, estcli, ID, GUIA, PO,MOV
*/

select * from po_movi where guia in ('10095003','10094946')