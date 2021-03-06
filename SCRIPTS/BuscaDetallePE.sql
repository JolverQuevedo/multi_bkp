USE [MULTI]
GO
/****** Object:  StoredProcedure [dbo].[BuscaDetallePE]    Script Date: 10/10/2013 11:42:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BuscaDetallePE]
(
	@C6_CALMA	VARCHAR(6),
	@C6_CTD		char(2),
	@C6_CNUMDOC	VARCHAR(20),
	@TBL1		VARCHAR(50),
	@TBL2		VARCHAR(50),
	@TBL3		VARCHAR(50)
)
AS


declare @strsql1    nvarchar(4000)

SET @strsql1 = ' Select CITEM Item, CCODIGO Codigo, CDESCRI Descripcion, CRFNDOC Doc_Ref, UNIMED Und, '
SET @strsql1 = @strsql1 + '  Color, Lote, NCANTID Cantid, KGNETO, KGBRUTO, NCANTIDPROV, KGNETOPROV, '
SET @strsql1 = @strsql1 + ' KGBRUTOPROV, B.DESTIPOMOV, '
SET @strsql1 = @strsql1 + ' Tallas=CASE WHEN Detallado=''S'''  
SET @strsql1 = @strsql1 + ' THEN LTRIM(DBO.concat_Tallas(CALMA,CTD,CNUMDOC,CITEM,''' +@TBL1+ ''''+ ')) '

SET @strsql1 = @strsql1 + ' ELSE '''' END '
SET @strsql1 = @strsql1 + ' From '+(@TBL2)+' A  ' 
SET @strsql1 = @strsql1 + ' LEFT JOIN '+(@TBL3)+' B '
SET @strsql1 = @strsql1 + ' ON(A.CODTIPOMOV=B.CODTIPOMOV)'
SET @strsql1 = @strsql1 + ' Where CALMA='''+@C6_CALMA+''''
SET @strsql1 = @strsql1 + ' AND CTD='''+@C6_CTD+''''
SET @strsql1 = @strsql1 + '  AND CNUMDOC='''+@C6_CNUMDOC +''''
SET @strsql1 = @strsql1 + ' Order by CALMA,CTD,CNUMDOC,CITEM '
--print @strsql1
exec sp_executesql @strsql1 

