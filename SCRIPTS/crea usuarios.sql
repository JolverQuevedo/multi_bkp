select *  from usuarios

--DELETE usuarios WHERE LTRIM(RTRIM(USUARIO)) = ''
--insert into [usuarios] select 'JRA', 'JOSEPH', 'JOSE RAMIREZ'
insert into [usuarios] select 'ECE', '191195', 'ELVIRA CORCUERA'
insert into [usuarios] select 'JBOL', 'JBOL', 'JULIO BOLAÑOS'

insert into [usr-cia]  select 'ece',cia from [usr-cia] where usuario ='sist'
insert into [usr-cia]  select 'jbol',cia from [usr-cia] where usuario ='sist'


SELECT * FROM [USR-OPC]
-- LOGISTICA / CONSULTA OC-CONTRA
INSERT INTO [usr-opc]  select 'CN2', MENU, SUBMENU, NULL FROM  [USR-OPC] WHERE USUARIO = 'BET'
-- LOGISTICA ORDEN DE COMPRA
INSERT INTO [usr-opc]  select 'ECE','03', '05', NULL
INSERT INTO [usr-opc]  select 'JBOL','03', '05', NULL
/*
select DISTINCT CUSUARIO from rs_usualm0001
DELETE  rs_usualm0001 WHERE CUSUARIO IN ('MHINOJO', 'ECORCUERA', 'LLLAGAS', 'LTINEO' )
*/

INSERT INTO rs_usualm0001 SELECT CALMA, 'CN2' FROM rs_usualm0001 WHERE CUSUARIO ='BET'
INSERT INTO rs_usualm0002 SELECT CALMA, 'CN2' FROM rs_usualm0001 WHERE CUSUARIO ='BET'
INSERT INTO rs_usualm0003 SELECT CALMA, 'CN2' FROM rs_usualm0001 WHERE CUSUARIO ='BET'
INSERT INTO rs_usualm0004 SELECT CALMA, 'CN2' FROM rs_usualm0001 WHERE CUSUARIO ='BET'
INSERT INTO rs_usualm0005 SELECT CALMA, 'CN2' FROM rs_usualm0001 WHERE CUSUARIO ='BET'
INSERT INTO rs_usualm0006 SELECT CALMA, 'CN2' FROM rs_usualm0001 WHERE CUSUARIO ='BET'
INSERT INTO rs_usualm0007 SELECT CALMA, 'CN2' FROM rs_usualm0001 WHERE CUSUARIO ='BET'
INSERT INTO rs_usualm0008 SELECT CALMA, 'CN2' FROM rs_usualm0001 WHERE CUSUARIO ='BET'

