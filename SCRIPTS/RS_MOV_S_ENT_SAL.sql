USE [MULTI]
GO
/****** Object:  StoredProcedure [dbo].[RS_MOV_S_ENT_SAL]    Script Date: 10/23/2013 08:52:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[RS_MOV_S_ENT_SAL]
(
	@CALMA		char(4),
	@CNUMDOC	char(11),
	@RANGOFEC	char(1),
	@FECHAINI	VARCHAR(8),
	@FECHAFIN	VARCHAR(8),
	@CNUMORD	VARCHAR(15),
	@CTIPMOV	VARCHAR(5),
	@CCODPROV	char(18),
	@LOTE		VARCHAR(15),
	@CODTIPOMOV char(3),
	@CCODIGO	VARCHAR(25),
	@COLOR		VARCHAR(20),
	@CRFNDOC	VARCHAR(25)='',
	@TBL1		VARCHAR(50),
	@TBL2		VARCHAR(50),
	@TBL3		VARCHAR(50),
	@TBL4		VARCHAR(50)
	
)
AS
SET NOCOUNT ON 
---RS_ALMOVD_TALLA0001
DECLARE @strsql    nvarchar(4000)

SET @strsql= 'Select top 500 A.CALMA as ALM,A.CTD,A.CNUMDOC AS DOC_NUM,A.CITEM AS ITEM,A.DFECDOC AS FEC,A.CRFTDOC R_DOC,A.CRFNDOC AS DOC_REF,A.CTIPMOV AS TIP,A.CCODMOV AS MOV,A.CCODIGO,A.CDESCRI,A.NCANTID AS CANT,A.CCODPROV AS RUC,A.CNOMPROV AS PROVEEDOR,'
SET @strsql= @strsql +'A.UNIMED AS UNI,A.CNUMORD AS OC,A.COLOR,A.LOTE,A.KGBRUTO AS K_BRUTO,A.KGNETO AS K_NETO,A.KGBRUTOPROV AS BRUT_PRO,A.KGNETOPROV AS NET_PRO,A.BULTOS,A.CONOS,C.DesTipoMov AS TIP_MOV,A.CUBICACION AS UBI,A.OBSERV,A.DETALLADO,'
SET @strsql= @strsql +'Tallas=CASE WHEN Detallado=''S'' THEN LTRIM(dbo.concat_Tallas(A.CALMA,CTD,CNUMDOC,CITEM, '''+(@TBL2)+'''  )) ELSE '''' END, '
SET @strsql= @strsql +'A.CALMA+CTD+CNUMDOC+CITEM AS CAD, B.CESTANTE+'' [''+B.FILA+CAST(B.COLUMNA AS VARCHAR(5))+'']'' AS Ubicacion,A.ESTADO '
SET @strsql= @strsql +'From '+(@TBL1)+'  A LEFT JOIN '+(@TBL3)+'  B ON(A.CUBICACION=B.CUBICACION) LEFT JOIN '+(@TBL4)+'  C ON(A.CodTipoMov=C.CodTipoMov) '
SET @strsql= @strsql +'Where A.calma='''+@calma+''''

IF rtrim(@CNUMDOC)<>'' 
	SET @strsql=@strsql+' and cnumdoc like ''%'+rtrim(@CNUMDOC)+''''

IF @RANGOFEC='S'
BEGIN
	SET @strsql= @strsql + ' and  dfecdoc between '''+@FECHAINI+''''
	SET @strsql= @strsql + ' AND DateAdd(day,1,'''+@FECHAfin+''')'
END
IF rtrim(@CNUMORD)<>'' 
	SET @strsql=@strsql+' and CNUMORD like ''%'+@CNUMORD+''''

IF rtrim(@CTIPMOV)<>''
BEGIN 
	IF  @CTIPMOV='PS GS'
		SET @strsql=@strsql+' and CTD <>''PE'''
	ELSE
		SET @strsql=@strsql+' and CTD='''+@CTIPMOV+''''
END

IF rtrim(@CCODPROV)<>'' 
	SET @strsql=@strsql+' and CCODPROV='''+@CCODPROV+''''

IF rtrim(@LOTE)<>'' 
	SET @strsql=@strsql+' and LOTE like ''%'+@LOTE+'%'''

IF rtrim(@CODTIPOMOV)<>'' 
	SET @strsql=@strsql+' and c.CODTIPOMOV='''+@CODTIPOMOV+''''

IF rtrim(@CCODIGO)<>'' 
	SET @strsql=@strsql+' and A.CCODIGO like ''%'+@CCODIGO+''''

IF rtrim(@COLOR)<>'' 
	SET @strsql=@strsql+' and COLOR like ''%'+@COLOR+'%'''

IF rtrim(@CRFNDOC)<>'' 
	SET @strsql=@strsql+' and CRFNDOC like ''%'+@CRFNDOC+''''
--PRINT @strsql

exec sp_executesql @strsql





set nocount off
