--insert into po_movi select '0000001123','7970-A','1','0001','I','','10108760040','00','00','04','00',3,8,6,2,1,0,0,0,0,0,'sist',getdate(), getdate(),'a','01','','00'

-- AGREGO COLUMNA QUE NO AFECTA A LA INTRANET QUE INDICA SI EL COLOR DE LA PO
-- ESTA CERRADA POR INGRESOS DE ACABADO
--ALTER TABLE MODELADOR..[PO-DETA]
--ADD STAT CHAR(1) NULL

-- colores que han salido para el estilo seleccionado
-- al taller ....
exec SALDO_PO_COLOR_TOTAL '540291'  , '20548229520' , '01' ,'00' ,'00'
exec SALDOs_PO_COLOR '540291' ,'ANTRACITA19' , '20548229520' , '01' ,'00' ,'00'


/*
	1 data en bruto
	2 sumariza por tipo de movimiento (MULTIPLICA *-1 LOS INGRESOS PARA NETEAR LOS SALDOS )
	3 sp con saldos calculados
*/
-- ******************************************************* --
-- data en bruto
-- ******************************************************* --
 SELECT po,  ESTCLI, COLOR, UBI,
T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, 
Q0, Q1, Q2, Q3, Q4, 
Q5, Q6, Q7, Q8, Q9,
C0, C1, C2, C3, C4, 
C5, C6, C7, C8, C9 ,mov
FROM VIEW_POS_MOVI
where 
estcli = '540291' and color  = 'ANTRACITA19'  and ruc = '20548229520' and codser = '01' and codcon= '00' and coddef = '00'
-- ************************************************************** --
-- sumariza ingresos *-1 / salidas para poder tener los saldos
-- ************************************************************** --
SELECT po,  ESTCLI, COLOR, 
T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, 
MIN(Q0) AS Q0, MIN(Q1) AS Q1, MIN(Q2) AS Q2, MIN(Q3) AS Q3, MIN(Q4) AS Q4, 
MIN(Q5) AS Q5, MIN(Q6) AS Q6, MIN(Q7) AS Q7, MIN(Q8) AS Q8, MIN(Q9) AS Q9,
SUM(C0) AS C0, SUM(C1) AS C1, SUM(C2) AS C2, SUM(C3) AS C3, SUM(C4) AS C4, 
SUM(C5) AS C5, SUM(C6) AS C6, SUM(C7) AS C7, SUM(C8) AS C8, SUM(C9) AS C9 , MOV
FROM VIEW_POS_MOVI
where MOV = 'S' AND
estcli = '540291' and color  = 'ANTRACITA19'  and ruc = '20548229520' and codser = '01' and codcon= '00' and coddef = '00'
GROUP BY T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, color, estcli,po, MOV
UNION
SELECT po,  ESTCLI, COLOR, 
T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, 
MIN(Q0) AS Q0, MIN(Q1) AS Q1, MIN(Q2) AS Q2, MIN(Q3) AS Q3, MIN(Q4) AS Q4, 
MIN(Q5) AS Q5, MIN(Q6) AS Q6, MIN(Q7) AS Q7, MIN(Q8) AS Q8, MIN(Q9) AS Q9,
SUM(C0)*-1 AS C0, SUM(C1)*-1 AS C1, SUM(C2)*-1 AS C2, SUM(C3)*-1 AS C3, SUM(C4)*-1 AS C4, 
SUM(C5)*-1 AS C5, SUM(C6)*-1 AS C6, SUM(C7)*-1 AS C7, SUM(C8)*-1 AS C8, SUM(C9)*-1 AS C9 , MOV
FROM VIEW_POS_MOVI
where MOV = 'I' AND
estcli = '540291' and color  = 'ANTRACITA19'  and ruc = '20548229520' and codser = '01' and codcon= '00' and coddef = '00'
GROUP BY T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, color, estcli,po, MOV
-- ******************************************************* --
-- el sp ya arroja los saldos pendientes de ingreso
-- ******************************************************* --
go
 EXEC SAldos_po_COLOR '540291','ANTRACITA19' , '20548229520' , '01' , '00' ,'00'
 -- ******************************************************* --
go
 /*
 SELECT po,  ESTCLI, COLOR, UBI,
T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, 
MIN(Q0) AS Q0, MIN(Q1) AS Q1, MIN(Q2) AS Q2, MIN(Q3) AS Q3, MIN(Q4) AS Q4, 
MIN(Q5) AS Q5, MIN(Q6) AS Q6, MIN(Q7) AS Q7, MIN(Q8) AS Q8, MIN(Q9) AS Q9,
SUM(C0) AS C0, SUM(C1) AS C1, SUM(C2) AS C2, SUM(C3) AS C3, SUM(C4) AS C4, 
SUM(C5) AS C5, SUM(C6) AS C6, SUM(C7) AS C7, SUM(C8) AS C8, SUM(C9) AS C9 ,mov
FROM VIEW_POS_MOVI
where 
estcli = 'Oj401ag' and color  = 'INDIGO/STORMBLUE' 
GROUP BY T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, color, estcli,po, MOV, UBI,mov
-- ******************************************************* --
--select * from view_pos_movi where estcli = 'Oj401ag'  and color  = 'INDIGO/STORMBLUE' order by po

*/