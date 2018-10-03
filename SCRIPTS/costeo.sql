select c5_CRFnDOC, ofi, CONVERT(NUMERIC (18,2),sum(soles_total)) as GASTOS_SOLES from (

SELECT top 100 percent c5_ctd, c5_CRFTDOC, c5_CRFnDOC, C5_CNUMDOC, C5_CRFTDO2, C5_CRFNDO2, C5_CORDEN, C5_CGLOSA1, C6_CCODIGO, c6_cdescri, C6_NCANTID, 

soles_uni= case when c6_ccodmon = 'us' then 
					case when ISNULL(C6_NPREUN1,0) <=0 then ISNULL(ar_nprecos,0) * c6_ntipcam else c6_npreuni * C6_NTIPCAM end 
			else	case when ISNULL(C6_NPREUN1,0) <=0 then ISNULL(ar_nprecos,0) else C6_NPREUN1 end end,

soles_total = case when c6_ccodmon = 'us' then 
					case when C6_NPREUN1 <=0 then ISNULL(ar_nprecos,0) * c6_ntipcam * C6_NCANTID else c6_npreuni * C6_NTIPCAM  * C6_NCANTID end 
			else	case when C6_NPREUN1 <=0 then ISNULL(ar_nprecos,0) * C6_NCANTID else C6_NPREUN1 * C6_NCANTID end end,
estilos.CODARTICULO, estilos.dESCRIPCION, estilos.DESMODELADOR, ESTILOS.ESTCLI, view_pos.ofi

from MODELADOR..ESTILOS,RSFACCAR..al0001movC 
INNER JOIN RSFACCAR..al0001movD ON C5_CALMA = C6_CALMA AND C5_CTD = C6_CTD AND C5_CNUMDOC = C6_CNUMDOC
inner join RSFACCAR..al0001arti on c6_ccodigo = ar_ccodigo
full outer join modelador..view_pos on (c5_CRFnDOC = po  collate SQL_Latin1_General_CP1_CI_AI) or (c5_CRFnDOC = estcli  collate SQL_Latin1_General_CP1_CI_AI)
WHERE c5_CRFTDOC IN ('OP', 'PO') and c5_ctd = 'ps'  AND C5_CCODMOV IN ('PR')
AND (
(estilos.ESTCLI collate SQL_Latin1_General_CP1_CI_AI = c5_CRFnDOC AND LTRIM(RTRIM(C5_CRFTDO2)) =  '')-- OR ()
)
order by 3

) mm

group by c5_crfndoc,ofi

--SELECT * FROM AL0001ARTI WHERE AR_CCODIGO = '6001790599000200'

--SELECT * FROM MODELADOR..view_POS where po like'%u8098'