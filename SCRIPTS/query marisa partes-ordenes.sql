 
Select dfecdoc as FECHA,ccodmov as MOV, cnumord Doc_Ref,B.CODTIPOMOV as	COD_MOT,destipomov as DES_MOT, CTD,
CRFNDOC  as NUM_CTD,crftdoc as TIP, cnumdoc as NUM_DOC, CITEM as It,
calma as Alm, CCODIGO Codigo, CDESCRI Descripcion,
ccodprov as RUC, cnomprov as proveedor,
Color, Lote, UNIMED Und,   NCANTID Cantid, vv.oc_npreuni as UNIT, oc_ccodmon as MON, KGNETO, KGBRUTO, NCANTIDPROV, KGNETOPROV,  KGBRUTOPROV, B.DESTIPOMOV, 
Tallas=CASE WHEN Detallado='S' THEN LTRIM(DBO.concat_Tallas(CALMA,CTD,CNUMDOC,CITEM,'RS_ALMOVD_TALLA0001')) 
ELSE '' END , OBSERV  
--select * from rsfaccar..CO0001MOVD
From RS_ALMOVD0001 A   
LEFT JOIN AL_TiposMov0001 B  ON(A.CODTIPOMOV=B.CODTIPOMOV) 
full outer join rsfaccar..CO0001MOVD as vv on vv.oc_cnumord = a.cnumord
full outer join rsfaccar..CO0001MOVc as cc on cc.oc_cnumord = a.cnumord
Where CCODIGO = '1000790000000000'
--'6BIA00005'
--CALMA='00HD' AND CTD='GS'  AND CNUMDOC='0010090008' 
Order by num_DOC,CITEM 

