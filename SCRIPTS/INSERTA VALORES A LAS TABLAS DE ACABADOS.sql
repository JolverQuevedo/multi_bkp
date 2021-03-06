CREATE TABLE [dbo].MOTIVOS(
	[CODIGO] [char](2) NOT NULL PRIMARY KEY,
	[DESCRIPCION] [varchar](100) NULL,
	[USUARIO] CHAR(10) NULL,
	[FECHA] SMALLDATETIME NOT NULL DEFAULT GETDATE(),
	[ESTADO] [char](1) NOT NULL DEFAULT 'A'
) ON [PRIMARY]

GO
CREATE TABLE [dbo].LINEAS(
	[CODIGO] [char](2) NOT NULL PRIMARY KEY,
	[DESCRIPCION] [varchar](100) NULL,
	[USUARIO] CHAR(10) NULL,
	[FECHA] SMALLDATETIME NOT NULL DEFAULT GETDATE(),
	[ESTADO] [char](1) NOT NULL DEFAULT 'A'
) ON [PRIMARY]
GO

ALTER TABLE PO_MOVI ADD
[MOTIVO] CHAR(2)	REFERENCES MOTIVOS(CODIGO) DEFAULT '',
[BOLSA]  CHAR(4),
[LINEA]	 CHAR(2)	REFERENCES LINEAS(CODIGO) DEFAULT ''
GO

INSERT INTO SUBMENU SELECT '05','05', 'Motivos', 'MOTIVOS.ASP','A'
INSERT INTO SUBMENU SELECT '05','06', 'Lineas de Costura', 'LINEAS.ASP','A'
INSERT INTO [USR-OPC] SELECT 'SIST', '05', '05', NULL
INSERT INTO [USR-OPC] SELECT 'MHD',  '05', '05', NULL
INSERT INTO [USR-OPC] SELECT 'BET',  '05', '05', NULL
INSERT INTO [USR-OPC] SELECT 'SIST', '05', '06', NULL
INSERT INTO [USR-OPC] SELECT 'MHD',  '05', '06', NULL
INSERT INTO [USR-OPC] SELECT 'BET',  '05', '06', NULL



DELETE DEFECTOS
GO
INSERT INTO DEFECTOS SELECT '00', '_ OK'                   ,'SIST', GETDATE(), 'A'
INSERT INTO DEFECTOS SELECT '01', 'FALLA DE TELA'          ,'SIST', GETDATE(), 'A'
INSERT INTO DEFECTOS SELECT '02', 'MANCHAS'                ,'SIST', GETDATE(), 'A'
INSERT INTO DEFECTOS SELECT '03', 'MANCHAS FUERTES'        ,'SIST', GETDATE(), 'A'
INSERT INTO DEFECTOS SELECT '04', 'COMPOSTURAS'            ,'SIST', GETDATE(), 'A'
INSERT INTO DEFECTOS SELECT '05', 'OPCIONALES'             ,'SIST', GETDATE(), 'A'
INSERT INTO DEFECTOS SELECT '06', 'PRIMERAS'               ,'SIST', GETDATE(), 'A'
INSERT INTO DEFECTOS SELECT '07', 'CONTAMINADO '           ,'SIST', GETDATE(), 'A'
INSERT INTO DEFECTOS SELECT '08', 'SEGUNDA DE TALLER'      ,'SIST', GETDATE(), 'A'
INSERT INTO DEFECTOS SELECT '09', 'TONO'                   ,'SIST', GETDATE(), 'A'
INSERT INTO DEFECTOS SELECT '10', 'ZURCIDO ESPECIAL'       ,'SIST', GETDATE(), 'A'
INSERT INTO DEFECTOS SELECT '11', 'FALTA ESTAMPAR'         ,'SIST', GETDATE(), 'A'
INSERT INTO DEFECTOS SELECT '12', 'FALTA INSPECCION'       ,'SIST', GETDATE(), 'A'
INSERT INTO DEFECTOS SELECT '13', 'HUECOS POR RECUPERAR'   ,'SIST', GETDATE(), 'A'
INSERT INTO DEFECTOS SELECT '14', 'HUECOS'                 ,'SIST', GETDATE(), 'A'
INSERT INTO DEFECTOS SELECT '15', 'INSPECCION'             ,'SIST', GETDATE(), 'A'

DELETE SERVICIOS
GO
INSERT INTO SERVICIOS SELECT '01', 'CONFECCION      ', 'SIST', GETDATE(), 'A'
INSERT INTO SERVICIOS SELECT '02', 'LAVADO          ', 'SIST', GETDATE(), 'A'
INSERT INTO SERVICIOS SELECT '03', 'TE�IDO          ', 'SIST', GETDATE(), 'A'
INSERT INTO SERVICIOS SELECT '04', 'ACABADO         ', 'SIST', GETDATE(), 'A'
INSERT INTO SERVICIOS SELECT '05', 'BORDADO         ', 'SIST', GETDATE(), 'A'
INSERT INTO SERVICIOS SELECT '06', 'CORTE           ', 'SIST', GETDATE(), 'A'
INSERT INTO SERVICIOS SELECT '07', 'ESTAMPADO       ', 'SIST', GETDATE(), 'A'
INSERT INTO SERVICIOS SELECT '08', 'DESHILADO       ', 'SIST', GETDATE(), 'A'

DELETE CONDICIONES
GO
INSERT INTO CONDICIONES SELECT '00', '_OK    				  ', 'SIST', GETDATE(), 'A'
INSERT INTO CONDICIONES SELECT '01', 'COMPOSTURAS             ', 'SIST', GETDATE(), 'A'
INSERT INTO CONDICIONES SELECT '02', 'DESMANCHE               ', 'SIST', GETDATE(), 'A'
INSERT INTO CONDICIONES SELECT '03', 'ENCAJADO                ', 'SIST', GETDATE(), 'A'
INSERT INTO CONDICIONES SELECT '04', 'INCOMPLETA              ', 'SIST', GETDATE(), 'A'
INSERT INTO CONDICIONES SELECT '05', 'OBSERVACION             ', 'SIST', GETDATE(), 'A'
INSERT INTO CONDICIONES SELECT '06', 'OJAL Y BOTON            ', 'SIST', GETDATE(), 'A'
INSERT INTO CONDICIONES SELECT '07', 'PEGADO DE BOTON         ', 'SIST', GETDATE(), 'A'
INSERT INTO CONDICIONES SELECT '08', 'PEGADO DE BROCHES       ', 'SIST', GETDATE(), 'A'
INSERT INTO CONDICIONES SELECT '09', 'PLANCHADO               ', 'SIST', GETDATE(), 'A'
INSERT INTO CONDICIONES SELECT '10', 'POR INSPECCION          ', 'SIST', GETDATE(), 'A'
INSERT INTO CONDICIONES SELECT '11', 'PROTOTIPO               ', 'SIST', GETDATE(), 'A'
INSERT INTO CONDICIONES SELECT '12', 'REPROCESO               ', 'SIST', GETDATE(), 'A'
INSERT INTO CONDICIONES SELECT '13', 'SEGUNDAS                ', 'SIST', GETDATE(), 'A'
INSERT INTO CONDICIONES SELECT '14', 'TERMINO DE CONFECCION   ', 'SIST', GETDATE(), 'A'
INSERT INTO CONDICIONES SELECT '15', 'TOP SAMPLE              ', 'SIST', GETDATE(), 'A'
INSERT INTO CONDICIONES SELECT '16', 'VAPORIZADO              ', 'SIST', GETDATE(), 'A'
INSERT INTO CONDICIONES SELECT '17', 'TERCERA                 ', 'SIST', GETDATE(), 'A'

DELETE PIEZAS
GO
INSERT INTO PIEZAS SELECT '00', '_PRENDA           ', 'SIST', GETDATE(), 'A'
INSERT INTO PIEZAS SELECT '01', 'PU�OS             ', 'SIST', GETDATE(), 'A'
INSERT INTO PIEZAS SELECT '02', 'DELANTERO         ', 'SIST', GETDATE(), 'A'
INSERT INTO PIEZAS SELECT '03', 'ESPALDA           ', 'SIST', GETDATE(), 'A'
INSERT INTO PIEZAS SELECT '04', 'MANGA             ', 'SIST', GETDATE(), 'A'
INSERT INTO PIEZAS SELECT '05', 'MEDIA LUNA        ', 'SIST', GETDATE(), 'A'
INSERT INTO PIEZAS SELECT '06', 'SEMICONFECCIONADA ', 'SIST', GETDATE(), 'A'
INSERT INTO PIEZAS SELECT '07', 'PA�O              ', 'SIST', GETDATE(), 'A'
INSERT INTO PIEZAS SELECT '08', 'CUELLO            ', 'SIST', GETDATE(), 'A'
INSERT INTO PIEZAS SELECT '09', 'BOLSILLOS         ', 'SIST', GETDATE(), 'A'
GO


INSERT INTO MOTIVOS SELECT '01', 'SERVICIO           ', 'SIST', GETDATE(), 'A'
GO
INSERT INTO LINEAS SELECT  '00', '', 'SIST', GETDATE(), 'A'
INSERT INTO LINEAS SELECT  '01', 'LINEA  1', 'SIST', GETDATE(), 'A'
INSERT INTO LINEAS SELECT  '02', 'LINEA  2', 'SIST', GETDATE(), 'A'
INSERT INTO LINEAS SELECT  '03', 'LINEA  3', 'SIST', GETDATE(), 'A'
INSERT INTO LINEAS SELECT  '04', 'LINEA  4', 'SIST', GETDATE(), 'A'
INSERT INTO LINEAS SELECT  '05', 'LINEA  5', 'SIST', GETDATE(), 'A'
INSERT INTO LINEAS SELECT  '06', 'LINEA  6', 'SIST', GETDATE(), 'A'
INSERT INTO LINEAS SELECT  '07', 'LINEA  7', 'SIST', GETDATE(), 'A'
INSERT INTO LINEAS SELECT  '08', 'LINEA  8', 'SIST', GETDATE(), 'A'
INSERT INTO LINEAS SELECT  '09', 'LINEA  9', 'SIST', GETDATE(), 'A'
GO
