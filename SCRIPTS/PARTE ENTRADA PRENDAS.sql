Select A1_CLOCALI,A1_CALMA,A1_CDESCRI,A1_CCTLNUM From RSFACCAR..AL0001ALMA Where A1_CALMA='00M2' 
Update RSFACCAR..ALCIAS Set AC_CALMA='00M2'  WHERE AC_CCIA='0001'
Select A1_CCOSTO From RSFACCAR..AL0001ALMA Where A1_CALMA='00M2'
Select TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='93' AND TG_CCLAVE= 'SERUNI      '
Select * From RSFACCAR..AL0001ALMA Order by A1_CALMA
Select * From RSFACCAR..AL0001TABL Where TG_CCOD='03' Order by TG_CCLAVE
Select * From RSCONCAR..CT0001TAGE Where TCOD='07' Order by TCLAVE
Select * From RSFACCAR..AL0001TABL Where TG_CCOD='37' Order by TG_CCLAVE
Select TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='94' AND TG_CCLAVE='PE          '
Select * From RSFACCAR..AL0001TABM Where TM_CTIPMOV='E' And TM_CCODMOV='PP'
Select name From RSCONCAR..sysobjects Where name='CT0001ANEX'
Select TM_CDESCRI From RSFACCAR..AL0001TABM Where TM_CTIPMOV='E' AND TM_CCODMOV='PP'
Select * From RSFACCAR..AL0001TABM Where TM_CTIPMOV='E' And TM_CCODMOV='PP'
Select name From RSCONCAR..sysobjects Where name='CT0001ANEX'
SELECT AR_CDESCRI,AR_CUNIDAD,AR_CLINEA,AR_CFDECI,AR_CFLOTE,AR_CFSERIE,AR_CFCELU, AR_NIGVPOR,AR_CMONCOM,AR_NPRECOM,AR_NPRECI2 From RSFACCAR..AL0001ARTI Where 
AR_CCODIGO='1628400000'
-- ****************************************************** --
-- actualiza numerador con el PE de las prendas
-- ****************************************************** --
Update RSFACCAR..AL0001ALMA
Set A1_NNUMENT=(Select A1_NNUMENT+1 From RSFACCAR..AL0001ALMA Where A1_CALMA='00M2')  
Where A1_CALMA='00M2' 
-- ****************************************************** --
-- cabecera de prendas
-- ****************************************************** --
Insert Into RSFACCAR..AL0001MOVC(C5_CALMA,C5_CTD,C5_CTIPMOV,C5_CCODMOV,C5_CNUMDOC,C5_DFECDOC,C5_CCODPRO,C5_CRFTDOC,C5_CRFTDO2,
C5_CRFNDOC,C5_CRFNDO2,C5_CNUMORD,C5_CCIAS,C5_CORDEN,C5_CSOLI,C5_CCENCOS,C5_CRFALMA,C5_CCODCLI,C5_CCODANE,C5_CGLOSA1,C5_CGLOSA2,
C5_CGLOSA3,C5_CNOMPRO,C5_CNOMCLI,C5_DFECCRE,C5_CUSUCRE,C5_CLOCALI) 
Values('00M2','PE','E','PP','00014400508',Convert(datetime,'14/07/2014 00:00:00',103),'','','','','','','','540291','','',
'','','','SERVICIO DE CONFECCION','','','     ','',Convert(datetime,'14/07/2014 11:10:20',103),'MHD  ','0001')
-- ****************************************************** --
-- detalle 1 linea
-- ****************************************************** --
Insert Into RSFACCAR..AL0001MOVD(C6_CALMA,C6_CTD,C6_CNUMDOC,C6_CCODMOV,C6_CITEM,C6_CCODIGO,C6_CDESCRI,C6_CORDEN,C6_NCANTID,C6_DFECDOC,
C6_CLOCALI,C6_CSOLI) 
Values('00M2','PE','00014400508','PP','0001','1628400000 ','POLO BOX - BUTTON LONG SLEEVES  ','540291',336,
Convert(datetime,'14/07/2014 00:00:00',103),'0001','')
-- ****************************************************** --
-- agrega la linea a la tabla de stocks
-- ****************************************************** --
Insert Into RSFACCAR..AL0001STOC(SK_CALMA,SK_CCODIGO,SK_NSKDIS,SK_DFECMOV) Values('00M2','1628400000',336,
Convert(datetime,'14/07/2014',103))
