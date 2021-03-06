/*
   Sábado, 30 de Agosto de 200807:14:38 p.m.
   Usuario: molina
   Servidor: 67.19.166.82
   Base de datos: icresil
   Aplicación: 
*/

/* Para evitar posibles problemas de pérdida de datos, debe revisar esta secuencia de comandos detalladamente antes de ejecutarla fuera del contexto del diseñador de base de datos.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE molina.UNIDADES
	DROP COLUMN FACTOR, DESTINO, DOS
GO
COMMIT
select Has_Perms_By_Name(N'molina.UNIDADES', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'molina.UNIDADES', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'molina.UNIDADES', 'Object', 'CONTROL') as Contr_Per 