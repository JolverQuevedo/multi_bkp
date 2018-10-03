USE RSFACCAR
GO
/*
select * from al0001movc
where c5_calma = '00m2' and c5_ctd = 'gs' and c5_ccodmov = '12' and year(c5_dfecdoc)>= 2015
and c5_cnumdoc in ('0010099106', '0010099100')


update al0001movc 
set 
c5_ccodmon = 'US',
c5_ntipcam = 3.25,
c5_ctipo = 'C',
c5_csitua = 'V'
where c5_calma = '00m2' and c5_ctd = 'gs' 
and c5_ccodmov = '12' and year(c5_dfecdoc)>= 2015

*/
-- 1680 REGISTROS
-- valoriza materia prima
UPDATE T1
SET  c6_ntipcam = 3.25,
C6_CESTADO = 'V',
C6_NPREUNI = ar_nprecos,
C6_NPREUN1 = ar_nprecos,
c6_nusprun = case when ar_cmoncos = 'US' THEN ar_nprecos ELSE ar_nprecos*3.25 END, 
c6_nmnprun = case when ar_cmoncos = 'US' THEN ar_nprecos/3.25 ELSE ar_nprecos END, 
c6_nvaltot =  C6_NCANTEN * c6_npreun1, 
C6_NusIMPO = case when ar_cmoncos = 'US' THEN (C6_NCANTEN * ar_nprecos) ELSE C6_NCANTEN * ar_nprecos*3.25 END,
c6_nmnimpo = CASE WHEN ar_cmoncos = 'US' THEN C6_NCANTEN * ar_nprecos/3.25 ELSE C6_NCANTEN * ar_nprecos  END
FROM AL0001MOVD T1 INNER JOIN AL0001ARTI ON T1.C6_CCODIGO = AR_CCODIGO
where c6_ctd = 'gs' and C6_CALMA = '00m2'  AND  YEAR(C6_DFECDOC) >=  2015 
and c6_ccodigo not in ('', '.', 'txt', 'prendas', 'prendasc')
AND AR_CFAMILI ='MP' 
/*
select *
FROM AL0001MOVD  T1 INNER JOIN AL0001ARTI ON T1.C6_CCODIGO = AR_CCODIGO
where c6_ctd = 'gs' and C6_CALMA = '00m2'  AND  YEAR(C6_DFECDOC) >=  2015 
and c6_ccodigo not in ('', '.', 'txt', 'prendas', 'prendasc')
AND AR_CFAMILI ='MP' 
AND ar_nprecos IS NULL

*/
-- PRODUCTOS TERMINADOS

UPDATE T1
SET  c6_ntipcam = 3.25,
C6_CESTADO = 'V',
C6_NPREUNI = 0.01,
C6_NPREUN1 = 0.01,
c6_nusprun = 0.01, 
c6_nmnprun = 0.01*3.25, 
c6_nvaltot =  C6_NCANTID * 0.01, 
C6_CCODMON = 'US',
C6_NusIMPO = C6_NCANTID * 0.01,
c6_nmnimpo = C6_NCANTID * 0.01 * 3.25 
FROM AL0001MOVD T1 INNER JOIN AL0001ARTI ON T1.C6_CCODIGO = AR_CCODIGO
where c6_ctd IN ('gs','PE') AND C6_CCODMOV IN ('12', 'PP') and C6_CALMA = '00m2'  AND  YEAR(C6_DFECDOC) >=  2015 
and c6_ccodigo not in ('', '.', 'txt', 'prendas', 'prendasc') AND AR_CFAMILI <> 'MP' 

select * from al0001movd where c6_calma ='00m2' and c6_ctd = 'pe' AND C6_CCODMOV ='PP'  AND  YEAR(C6_DFECDOC) >=  2015 