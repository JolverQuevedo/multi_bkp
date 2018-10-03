use multi
go
--select * from submenu
insert into submenu 
select '02', '08', 'Reportes Acabados', 'Reportes.asp', 'A'

--SELECT * FROM  [USR-OPC]
INSERT INTO  [USR-OPC] SELECT 'MHD',  '02', '08', NULL
INSERT INTO  [USR-OPC] SELECT 'SIST', '02', '08', NULL
INSERT INTO  [USR-OPC] SELECT 'FDEL', '02', '08', NULL
INSERT INTO  [USR-OPC] SELECT 'opal', '02', '08', NULL
INSERT INTO  [USR-OPC] SELECT 'bet', '02', '08', NULL


SELECT   ID, ESTCLI,PO, COLOR, DESSER, RUC,NOMPRO, (C0+C1+C2+C3+C4+C5+C6+C7+C8+C9) AS TOTAL , GUIA,
isnull(FACPRO,'') as FACPRO, ISNULL(FECPRO, '') AS FECPRO, ISNULL(FECEMB,'') AS FECEMB, ISNULL(FACEXP,'') AS FACEXP

FROM view_pos_movi WHERE CODCLI= '00001' and not fecemb is null


