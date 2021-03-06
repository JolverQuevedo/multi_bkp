USE [MULTI]
GO
/****** Object:  StoredProcedure [dbo].[BuscaOC_Contralor]    Script Date: 10/10/2013 11:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BuscaOC_Contralor]
(
	@OC_CNUMORD		VARCHAR(20),
	@OC_CCODPRO		VARCHAR(18),
	@CP_FACTURA		VARCHAR(20),
	@TBL1			VARCHAR(50),
	@TBL2			VARCHAR(50),
	@TBL3			VARCHAR(50)
)
AS
declare @strsql1    nvarchar(4000)

SET @strsql1 = 'Select	top 300 rtrim(OC_CNUMORD) as OC_CNUMORD, OC_DFECDOC Fecha,OC_CCODPRO,OC_CRAZSOC Proveedor,OC_CCODMON Mnd, Importe=CASE OC_CCODMON When ''US'' Then OC_NIMPUS Else OC_NIMPMN END, TG_CDESCRI AS Estado, '
SET @strsql1 = @strsql1 + 'OC_CTIPORD Tip,'
SET @strsql1 = @strsql1 + 'Facturas= (Select TOP 1 '+ '''  FT:''' + '+'+ 'rtrim(CP_CNUMDOC)'+ '+'+ '''/'''	
SET @strsql1 = @strsql1 + 'From '+(@TBL3)+' WHERE CP_CTIPDOC=''FT'' AND CP_CNDOCRE=rtrim(OC_CNUMORD)  Order by CP_CNUMDOC),'
SET @strsql1 = @strsql1 + 'OC_CDETENT Observacion, OC_CSOLICT Solicitante '
SET @strsql1 = @strsql1 + 'From ' + (@TBL1) 
SET @strsql1 = @strsql1 + ' Left Join ' + (@TBL2) 
SET @strsql1 = @strsql1 + ' On OC_CSITORD=TG_CCLAVE '
SET @strsql1 = @strsql1 + 'Where TG_CCOD=''31'''

IF rtrim(@OC_CNUMORD)<>''
	SET @strsql1 = @strsql1 + ' AND OC_CNUMORD LIKE ''%' + @OC_CNUMORD + ''''

IF rtrim(@OC_CCODPRO)<>''
BEGIN
	SET @strsql1 = @strsql1 + ' AND OC_CCODPRO =''' + @OC_CCODPRO + ''''

	IF rtrim(@CP_FACTURA)<>''
		SET @strsql1 = @strsql1 + ' AND OC_CNUMORD IN(SELECT DISTINCT CP_CNDOCRE FROM ' + (@TBL3) + ' WHERE CP_CVANEXO=''P'' AND CP_CTIPDOC=''FT'' AND CP_CCODIGO=''' + @OC_CCODPRO + ''' AND CP_CNUMDOC=''' + @CP_FACTURA + ''')'
END


SET @strsql1 = @strsql1 + ' Order by OC_DFECDOC DESC, OC_CNUMORD'
--print @strsql1
exec sp_executesql @strsql1 



