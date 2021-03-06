USE [MULTI]
GO
/****** Object:  StoredProcedure [dbo].[BuscaOC_Deta_Agrupado]    Script Date: 10/15/2013 09:29:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BuscaOC_Deta_Agrupado]
(
	@OC_CNUMORD		VARCHAR(20),
	@TBL1			VARCHAR(50),
	@TBL2			VARCHAR(50),
	@TBL3			VARCHAR(50),
	@TBL4			VARCHAR(50)
)
AS
SET NOCOUNT ON 
declare @strsql1    nvarchar(4000)


SET @strsql1 = ' Select A.C5_CNUMORD, B.C6_CCODIGO, SUM(B.C6_NCANTID) AS C6_NCANTID INTO  #PARTES '
SET @strsql1 = @strsql1 + ' From ' + @TBL1 + ' A '
SET @strsql1 = @strsql1 + ' INNER JOIN ' + @TBL2 + ' B '
SET @strsql1 = @strsql1 + ' ON(A.C5_CALMA=B.C6_CALMA AND A.C5_CTD=B.C6_CTD AND A.C5_CNUMDOC=B.C6_CNUMDOC) '
SET @strsql1 = @strsql1 + ' WHERE A.C5_CNUMORD = ''' + @OC_CNUMORD + ''''
SET @strsql1 = @strsql1 + '  AND C5_CTD=''PE''    and c6_ccodmov in (''CO'', ''IM'', ''ST'')'
SET @strsql1 = @strsql1 + ' GROUP BY  A.C5_CNUMORD, B.C6_CCODIGO '

SET @strsql1 = @strsql1 + ' Select A.OC_CNUMORD,A.OC_CCODIGO,B.AR_CDESCRI,A.OC_CUNIDAD,SUM(A.OC_NCANORD) OC_NCANORD'
SET @strsql1 = @strsql1 + ' INTO  #DETALLEOC '
SET @strsql1 = @strsql1 + ' From ' + (@TBL3)
SET @strsql1 = @strsql1 + ' A INNER JOIN ' +(@TBL4)
SET @strsql1 = @strsql1 + ' B ON(A.OC_CCODIGO=B.AR_CCODIGO) '
SET @strsql1 = @strsql1 + ' WHERE A.OC_CNUMORD =''' + @OC_CNUMORD +''''
SET @strsql1 = @strsql1 + ' GROUP BY A.OC_CCODIGO,B.AR_CDESCRI,A.OC_CUNIDAD,A.OC_CNUMORD '


SET @strsql1 = @strsql1 + ' Select A.OC_CCODIGO Codigo, A.AR_CDESCRI Descripcion, A.OC_CUNIDAD Unidad,A.OC_NCANORD as Cant_Ordenada'
SET @strsql1 = @strsql1 + ' , ISNULL(B.C6_NCANTID,0)AS Cant_Entregada ,(A.OC_NCANORD-ISNULL(B.C6_NCANTID,0)) AS Cant_Pendiente'
SET @strsql1 = @strsql1 + ' , CASE WHEN A.OC_NCANORD=0 THEN 0 ELSE (ISNULL(B.C6_NCANTID,0)/A.OC_NCANORD) END  as ' + 'Porcen_Aten'
SET @strsql1 = @strsql1 + ' From  #DETALLEOC  A LEFT JOIN  #PARTES  B ON (A.OC_CNUMORD=B.C5_CNUMORD AND A.OC_CCODIGO=B.C6_CCODIGO)'
SET @strsql1 = @strsql1 + ' ORDER BY A.OC_CCODIGO '

--PRINT  @strsql1 
exec sp_executesql @strsql1