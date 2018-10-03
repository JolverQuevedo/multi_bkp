--select * from [USR-OPC] 
--WHERE USUARIO = 'mhd'
use multi
go

select * from usuarios
insert into usuarios select 'JCQ', 'tiki24', 'Juan Cuzcano'

INSERT INTO SUBMENU SELECT '02','07', 'Acabados Temporada', 'acatemp.ASP','A'
INSERT INTO [USR-OPC] SELECT 'wPA', '03', '09', NULL
INSERT INTO [USR-OPC] SELECT 'JCQ', '02', '03', NULL
INSERT INTO [USR-OPC] SELECT 'JCQ', '02', '08', NULL

select * from submenu