USE [MULTI]
GO
/****** Object:  StoredProcedure [dbo].[BuscaFT_OC_Contra_ACUM]    Script Date: 10/10/2013 11:43:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BuscaFT_OC_Contra_ACUM]
(
	@CNUMOC		CHAR(11),
	@CODPROV	VARCHAR(18),
	@TBL1		VARCHAR(50),
	@TBL2		VARCHAR(50),
	@TBL3		VARCHAR(50),
	@TBL4		VARCHAR(50)
)
AS
SET NOCOUNT ON
declare @strsql1    nvarchar(4000)

SET @strsql1 = ' select C.CP_CNUMDOC, IMPUSMOV=ISNULL(SUM(C6_NUSIMPO),0), IMPMNMOV=ISNULL(SUM(C6_NMNIMPO),0) '
SET @strsql1 = @strsql1 + ' INTO #RECIBIDOS from ' + (@TBL2)  
SET @strsql1 = @strsql1 + '	A INNER JOIN ' + (@TBL1)
SET @strsql1 = @strsql1 + ' B ON(A.C6_CALMA=B.C5_CALMA AND A.C6_CTD=B.C5_CTD AND A.C6_CNUMDOC=B.C5_CNUMDOC) '
SET @strsql1 = @strsql1 + '	INNER JOIN ' + (@TBL3)
SET @strsql1 = @strsql1 + ' C ON(A.C6_CALMA collate Modern_Spanish_CI_AS=C.C5_CALMA'
SET @strsql1 = @strsql1 + ' AND A.C6_CTD collate Modern_Spanish_CI_AS =C.C5_CTD '
SET @strsql1 = @strsql1 + ' AND A.C6_CNUMDOC collate Modern_Spanish_CI_AS=C.C5_CNUMDOC) '
SET @strsql1 = @strsql1 + ' WHERE B.C5_CSITUA<>''A'' AND B.C5_CTD=''PE'' AND B.C5_CNUMORD='''+@CNUMOC +''' AND C.CP_CTIPDOC=''FT'''
SET @strsql1 = @strsql1 + ' GROUP BY C.CP_CNUMDOC  ; '
SET @strsql1 = @strsql1 + ' SELECT 	isnull(sum((A.CP_NIMPOUS' + '-' + 'A.CP_NIGVUS)),0) as DOLARES, '
SET @strsql1 = @strsql1 + '	isnull(sum((A.CP_NIMPOMN'+'-' +'A.CP_NIGVMN)),0) as SOLES  FROM ' + (@TBL4)
SET @strsql1 = @strsql1 + ' A LEFT JOIN #RECIBIDOS B ON (A.CP_CNUMDOC '
SET @strsql1 = @strsql1 + ' collate SQL_Latin1_General_CP1_CI_AI=B.CP_CNUMDOC collate SQL_Latin1_General_CP1_CI_AI)'
SET @strsql1 = @strsql1 + ' WHERE A.CP_CVANEXO=''P'' AND A.CP_CCODIGO='''+@CODPROV +'''AND A.CP_CTIPDOC=''FT'' AND A.CP_CNDOCRE='''+@CNUMOC + ''''
--print @strsql1
exec sp_executesql @strsql1