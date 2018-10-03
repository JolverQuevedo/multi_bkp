Select TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='38' And TG_CCLAVE='JF      '
 select ARTI.AR_CCODIGO, ARTI.AR_CDESCRI, AR_CUNIDAD, STOC.SK_NSKDIS, ARTI.AR_CMONVTA, ARTI.AR_NPRECI1,  ARTI.AR_NPRECI2, 
ARTI.AR_NPRECI3, ARTI.AR_NPRECI4, ARTI.AR_NPRECI5, ARTI.AR_NPRECI6,  ARTI.AR_CGRUPO, ARTI.AR_CFAMILI, ARTI.AR_CMARCA, 
ARTI.AR_CMODELO, ARTI.AR_CLINEA, ARTI.AR_CFDECI FROM RSFACCAR..AL0001ARTI ARTI LEFT OUTER JOIN RSFACCAR..AL0001STOC STOC 
ON  STOC.SK_CCODIGO = ARTI.AR_CCODIGO AND STOC.SK_CALMA='00DT' WHERE ARTI.AR_CFAMILI>='jf'  AND ARTI.AR_CFAMILI<='jf' ORDER 
BY ARTI.AR_CFAMILI, ARTI.AR_CDESCRI

/*
update RSFACCAR..AL0001ARTI set ar_npreci3 = 0 where ar_npreci3 is null
update RSFACCAR..AL0001ARTI set ar_cmonvta = 'MN' where ar_cmonvta = ''
update RSFACCAR..AL0001ARTI set ar_npreci4 = 0 where ar_npreci4 is null
update RSFACCAR..AL0001ARTI set ar_npreci5 = 0 where ar_npreci5 is null
update RSFACCAR..AL0001ARTI set ar_npreci6 = 0 where ar_npreci6 is null

*/