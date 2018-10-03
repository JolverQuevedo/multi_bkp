 USE [MULTI]
GO
/****** Object:  StoredProcedure [dbo].[DATOS_avios_OFI]    Script Date: 19/02/2016 10:31:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================
-- Author:		MABEL MOLINA
-- Create date: 20-FEB-2016
-- Description:	ACUMULA EL CALCULO POR ID DEL PROTO EL CONSUMO
--				DE AVIOS POR TALLA COLOR DE LAS POS SELECCIONADAS
-- ===============================================================
ALTER PROCEDURE [dbo].[SP_AVIOS_POS]
	-- Add the parameters for the stored procedure here
	@POS	VARCHAR(300), 
	@TIP CHAR(1)
AS
BEGIN
DECLARE @POS2  VARCHAR(300)
	SET @pos2 = (select replace(@pos,'*', ''''))
	
	PRINT @POS2
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   -- Insert statements for procedure here
DECLARE @strsql    nvarchar(4000)

SET @strsql= '	 SELECT	DISTINCT pp.po,	PP.color , PD.ID, PD.ADICIONAL AS OBS, min(av.unidad) as uni, '
SET @strsql= @strsql +'			T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, min(pd.codigo) as avio, AV.DESCRIPCION AS desavi,	'
SET @strsql= @strsql +'			SUM((CAN0 * CC.COBERTURA/100)+Can0) AS C0, SUM((CAN1 * CC.COBERTURA/100)+can1) AS C1, 		'
SET @strsql= @strsql +'			SUM((CAN2 * CC.COBERTURA/100)+can2) AS C2, SUM((CAN3 * cc.COBERTURA/100)+can3) AS C3, 		'
SET @strsql= @strsql +'			SUM((CAN4 * cc.cobertura/100)+can4) AS C4, SUM((CAN5 * CC.COBERTURA/100)+can5) AS C5, 		'
SET @strsql= @strsql +'			SUM((CAN6 * CC.COBERTURA/100)+can6) AS C6, SUM((CAN7 * CC.COBERTURA/100)+can7) AS C7,		'
SET @strsql= @strsql +'			SUM((CAN8 * CC.COBERTURA/100)+can8) AS C8, SUM((CAN9 * CC.COBERTURA/100)+can9) AS C9,		'	
SET @strsql= @strsql +'			SUM(((CAN0 * CC.COBERTURA/100) + Can0) * ((PESO*(isnull(merma,1)/100)+peso) ) ) AS CN0,		'
SET @strsql= @strsql +'			SUM(((CAN1 * CC.COBERTURA/100) + Can1) * ((PESO*(isnull(merma,1)/100)+peso) ) ) AS CN1,		'
SET @strsql= @strsql +'			SUM(((CAN2 * CC.COBERTURA/100) + Can2) * ((PESO*(isnull(merma,1)/100)+peso) ) ) AS CN2,		'
SET @strsql= @strsql +'			SUM(((CAN3 * CC.COBERTURA/100) + Can3) * ((PESO*(isnull(merma,1)/100)+peso) ) ) AS CN3,		'
SET @strsql= @strsql +'			SUM(((CAN4 * CC.COBERTURA/100) + Can4) * ((PESO*(isnull(merma,1)/100)+peso) ) ) AS CN4,		'
SET @strsql= @strsql +'			SUM(((CAN5 * CC.COBERTURA/100) + Can5) * ((PESO*(isnull(merma,1)/100)+peso) ) ) AS CN5,		'
SET @strsql= @strsql +'			SUM(((CAN6 * CC.COBERTURA/100) + Can6) * ((PESO*(isnull(merma,1)/100)+peso) ) ) AS CN6,		'
SET @strsql= @strsql +'			SUM(((CAN7 * CC.COBERTURA/100) + Can7) * ((PESO*(isnull(merma,1)/100)+peso) ) ) AS CN7,		'
SET @strsql= @strsql +'			SUM(((CAN8 * CC.COBERTURA/100) + Can8) * ((PESO*(isnull(merma,1)/100)+peso) ) ) AS CN8,		'
SET @strsql= @strsql +'			SUM(((CAN9 * CC.COBERTURA/100) + Can9) * ((PESO*(isnull(merma,1)/100)+peso) ) ) AS CN9,		'

SET @strsql= @strsql +'			SUM((((CAN0+CAN1+CAN2+CAN3+CAN4+CAN5+CAN6+CAN7+CAN8+CAN9) * CC.COBERTURA/100) '
SET @strsql= @strsql +'			+ (CAN0+CAN1+CAN2+CAN3+CAN4+CAN5+CAN6+CAN7+CAN8+Can9)) * ((PESO*(isnull(merma,1)/100)+peso) ) ) AS TOT'
SET @strsql= @strsql +'	FROM	modelador..[PO-DETA] AS PP '
SET @strsql= @strsql +'	INNER JOIN modelador..POS ON POS.PO = PP.PO '
SET @strsql= @strsql +'	INNER JOIN modelador..COTIZACION CC ON CC.COTIZACION = POS.COTIZACION '
SET @strsql= @strsql +'	INNER JOIN modelador..PROTOS AS PRO ON CC.PROTO = PRO.PROTO AND CC.[VERSION] = PRO.[VERSION] '
SET @strsql= @strsql +'	INNER JOIN modelador..[PROTO-DETALLES] PD ON PRO.PROTO = PD.PROTO AND PRO.[VERSION] = PD.[VERSION] '
SET @strsql= @strsql +'	INNER JOIN modelador..OFI_POS OP ON OP.PO = POS.PO '
SET @strsql= @strsql +'	INNER JOIN modelador..AVIOS AV ON AV.CODIGO = PD.CODIGO '
SET @strsql= @strsql +'	WHERE  pos.po in ('+@pos2+')  AND PD.TIPODETALLE = ''AV'' and tipavi ='''+ @tip +''''
SET @strsql= @strsql +'	and PP.estado = ''A'''
SET @strsql= @strsql +'	GROUP BY PP.COLOR, T0, T1,T2, T3,T4,T5,T6,T7,T8,T9, PD.ID, PD.ADICIONAL, av.DESCRIPCION, pp.po '
SET @strsql= @strsql +'    order by 1,2 '

PRINT @strsql

exec sp_executesql @strsql
	end
	
/*

	

	SELECT * FROM MODELADOR..POS WHERE CLIENTE = '00001' AND PO LIKE '%4%'

	*/