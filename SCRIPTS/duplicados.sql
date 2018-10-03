select * into rs_almovd0001_duplicados from rs_almovd0001
-- count = 945735  -->946740

SELECT calma, ctd , cnumdoc, citem, col3=count(*)
INTO holdkey
FROM rs_almovd0001
GROUP BY calma, ctd , cnumdoc, citem
HAVING count(*) > 1
order by calma, ctd , cnumdoc, citem
-- count = 472800 --> 472798


SELECT DISTINCT t1.CALMA,t1.CTD,t1.CNUMDOC,t1.CITEM,DFECDOC,CRFTDOC,CRFNDOC,CTIPMOV,CCODMOV,CCODIGO,CDESCRI,
NCANTID,NCANTIDPROV,CCODPROV,CNOMPROV,UNIMED,CNUMORD,COLOR,LOTE,BULTOS,CONOS,KGNETO,KGBRUTO,KGNETOPROV,
KGBRUTOPROV,TIPSERVICIO,CUBICACION,cast(OBSERV as varchar(1000)) as observ,DETALLADO,VBCC,ESTADO,CodTipoMov,
NumPurOrd,NumEstilo
INTO holddups
FROM rs_almovd0001 as t1, holdkey
WHERE t1.calma = holdkey.calma
AND t1.ctd = holdkey.ctd
AND t1.cnumdoc = holdkey.cnumdoc
AND t1.citem = holdkey.citem
-- count 472811  -->  472809

SELECT  calma, ctd , cnumdoc, citem, count(*)
FROM holddups
GROUP BY  calma, ctd , cnumdoc, citem
-- count 472800 -->472798

DELETE t1
FROM rs_almovd0001 as t1, holdkey
WHERE t1.calma = holdkey.calma
AND t1.ctd = holdkey.ctd
AND t1.cnumdoc = holdkey.cnumdoc
AND t1.citem = holdkey.citem
-- count 945600  -->945596


INSERT rs_almovd0001 SELECT * FROM holddups
-- count 472811  --> 472809


select * from rs_almovd0001
-- count = 472946 --> 473981
drop table holdkey
drop table holddups