DROP TABLE #MOVC
DROP TABLE #PARTES
DROP TABLE #DETALLEOC
drop table #partes2
set dateformat dmy;
go
select C5_CALMA,C5_CTD,C5_CNUMDOC,c5_cnumord as oc,c5_cnompro,c5_dfecdoc, c5_ctipmov, c5_cnumord
 into #MOVC
from RSFACCAR..AL0001MOVC
where c5_dfecdoc BETWEEN (getdate()-90) AND getdate() 
--and c5_ctipmov='E' 
and c5_cnumord<>''  and c5_ccodmov in ('CO', 'ST', 'PS', 'GS','11','DV')



Select A.oc as oc, a.c5_cnumdoc,B.C6_CCODIGO,a.c5_cnumord,
SUM(CASE WHEN  A.c5_ctipmov = 'E' THEN B.C6_NCANTID ELSE 0 END)ENTRA  ,
SUM(CASE WHEN  A.c5_ctipmov = 'S' THEN (B.C6_NCANTID*-1) ELSE 0 END) sale,
A.C5_CNOMPRO, c5_dfecdoc
INTO #PARTES
From #MOVC A 
INNER JOIN RSFACCAR..AL0001MOVD B ON(A.C5_CALMA=B.C6_CALMA AND A.C5_CTD=B.C6_CTD  AND A.c5_cnumdoc=B.C6_CNUMDOC)
WHERE C6_CCODIGO NOT IN('TXT','.')
GROUP BY  A.oc,B.C6_CCODIGO,A.C5_CNOMPRO, c5_dfecdoc,  A.c5_ctipmov , a.c5_cnumdoc, a.c5_cnumord
--select * from #movc
select * from #partes order by 1,3

Select A.OC_CNUMORD,A.OC_CCODIGO,B.AR_CDESCRI,A.OC_CUNIDAD,SUM(A.OC_NCANORD) OC_NCANORD
INTO #DETALLEOC
From RSFACCAR..CO0001MOVD A 
INNER JOIN RSFACCAR..AL0001ARTI B ON(A.OC_CCODIGO=B.AR_CCODIGO)
WHERE A.OC_CNUMORD IN (SELECT DISTINCT oc FROM #MOVC) 
GROUP BY A.OC_CCODIGO,B.AR_CDESCRI,A.OC_CUNIDAD,A.OC_CNUMORD

select * from #detalleoc order by 1
SELECT oc, c6_ccodigo, sum(entra+sale)  as ccc, min(c5_cnompro) c5_cnompro, min(c5_dfecdoc) c5_dfecdoc into #partes2 FROM #PARTES 
group by oc, c6_ccodigo
order by 1,3
------------------------------------------
/*
SELECT b.oc, A.OC_CCODIGO, A.AR_CDESCRI, A.OC_CUNIDAD, A.OC_NCANORD, sum(ISNULL(ccc,0)) canti, C5_CNOMPRO, 
gg= (CASE WHEN A.OC_NCANORD > 0 THEN sum(ISNULL(ccc,1))/ISNULL(A.OC_NCANORD,1) ELSE 0 END),
fecha = min(CAST ( b.c5_dfecdoc AS char(12) ))
FROM #DETALLEOC A 
LEFT JOIN #PARTES2 B ON (A.OC_CNUMORD=B.oc AND A.OC_CCODIGO=B.C6_CCODIGO)
			WHERE ISNULL((ccc),1)/case when A.OC_NCANORD > 0 then ISNULL(A.OC_NCANORD,1) else 1 end >1.05

group by b.oc, A.OC_CCODIGO, A.AR_CDESCRI, A.OC_CUNIDAD, A.OC_NCANORD, C5_CNOMPRO 
ORDER BY b.oc,A.OC_CCODIGO


SELECT * FROM #MOVC WHERE C5_CTIPMOV = 'S'

sELECT *  FROM #DETALLEOC order by 1
select * from #partes2
select * from #partes
--

*/




















/*

ALTER PROCEDURE [dbo].[SP_sobre_oc]
	-- Add the parameters for the stored procedure here
/*	@tda	varchar(2),
	@descri varchar(20),
	@to     varchar(500)
*/
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @tableHTML  NVARCHAR(MAX);

select C5_CALMA,C5_CTD,C5_CNUMDOC,c5_cnumord,c5_cnompro,c5_dfecdoc, c5_ctipmov into #MOVC
from RSFACCAR..AL0001MOVC
where c5_dfecdoc BETWEEN (getdate()-90) AND getdate() 
--and c5_ctipmov='E' 
and c5_cnumord<>''  and c5_ccodmov in ('CO', 'ST', '11')

Select A.C5_CNUMORD,B.C6_CCODIGO,
C6_NCANTID = SUM(CASE WHEN  A.c5_ctipmov = 'S' THEN (B.C6_NCANTID*-1) ELSE (B.C6_NCANTID) END)

 ,A.C5_CNOMPRO, c5_dfecdoc
INTO #PARTES
From #MOVC A INNER JOIN RSFACCAR..AL0001MOVD B ON(A.C5_CALMA=B.C6_CALMA AND A.C5_CTD=B.C6_CTD 
AND A.C5_CNUMDOC=B.C6_CNUMDOC)
WHERE C6_CCODIGO NOT IN('TXT','.')
GROUP BY  A.C5_CNUMORD,B.C6_CCODIGO,A.C5_CNOMPRO, c5_dfecdoc,  A.c5_ctipmov 


Select A.OC_CNUMORD,A.OC_CCODIGO,B.AR_CDESCRI,A.OC_CUNIDAD,SUM(A.OC_NCANORD) OC_NCANORD
INTO #DETALLEOC
From RSFACCAR..CO0001MOVD A INNER JOIN RSFACCAR..AL0001ARTI B ON(A.OC_CCODIGO=B.AR_CCODIGO)
WHERE A.OC_CNUMORD IN (SELECT DISTINCT c5_cnumord FROM #MOVC) 
GROUP BY A.OC_CCODIGO,B.AR_CDESCRI,A.OC_CUNIDAD,A.OC_CNUMORD


set dateformat dmy
SET @tableHTML =
N'<table border="1" cellpadding="5" cellspacing="0">'+
N'<thead>'+
N'<tr style=''background: gainsboro;    color: black;font-weight: bold;''>'+
N'<th>O/C</th>'+
N'<th>Codigo</th>'+
N'<th>Descripcion</th>'+
N'<th>Uni</th>'+
N'<th>Ped</th>'+
N'<th>Recibido</th>'+
N'<th>%</th>'+
N'<th>Proveedor</th>'+
N'<th>Fec_Doc</th>'+
N'</tr>'+
N'</thead>'+
N'<tbody>'+
CAST ( ( SELECT td = B.C5_CNUMORD, '',
        td = A.OC_CCODIGO, '',
		td = A.AR_CDESCRI, '',
		td = A.OC_CUNIDAD, '',
		td = A.OC_NCANORD, '',
		td = ISNULL(B.C6_NCANTID,0), '',
		td = CASE WHEN A.OC_NCANORD > 0 THEN (ISNULL(B.C6_NCANTID,1)/ISNULL(A.OC_NCANORD,1))
		ELSE 0 END , '',
        td = B.C5_CNOMPRO, '',
		td = CAST ( b.c5_dfecdoc AS char(12) ), ''
      FROM #DETALLEOC A LEFT JOIN #PARTES B ON (A.OC_CNUMORD=B.C5_CNUMORD AND A.OC_CCODIGO=B.C6_CCODIGO)
			WHERE ISNULL(B.C6_NCANTID,1)/case when A.OC_NCANORD > 0 then ISNULL(A.OC_NCANORD,1) else 1 end >1.05
			ORDER BY B.C5_CNUMORD,A.OC_CCODIGO
      FOR XML PATH('tr'), TYPE
    ) AS NVARCHAR(MAX) ) +
N'</tbody>'+
N'</tr>'+
N'</table>'
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'DBMailProfile',--Perfil de correo configurado.
--  @recipients = 'earellano@elmodelador.com.pe;sistemas@elmodelador.com.pe; rmalaga@elmodelador.com.pe; csaba@elmodelador.com.pe', -- A quien se va enviar el correo.
	@recipients = 'mmolina@elmodelador.com.pe;',
--	@recipients = 'mhinojo@elmodelador.com.pe;jramos@elmodelador.com.pe;almacentelas@elmodelador.com.pe;opalomino@elmodelador.com.pe;jbolanos@elmodelador.com.pe;elevano@elmodelador.com.pe;jenciso@elmodelador.com.pe;jramirez@elmodelador.com.pe;fdelacruz@elmodelador.com.pe;rbenavente@elmodelador.com.pe;ecorcuera@elmodelador.com.pe;ohurtado@elmodelador.com.pe;almacenatelas@elmodelador.com.pe;', 
 	-- A quien se va enviar el correo.
    @subject = 'O/C SOBREATENDIDAS ',
    @body = @tableHTML,
    @body_format = 'HTML',
    @importance = 'High'


END



/*
SELECT * FROM RSFACCAR..AL0001MOVC WHERE C5_CNUMORD = '0000026012'
SELECT * FROM RSFACCAR..AL0001MOVD WHERE 
*/





*/