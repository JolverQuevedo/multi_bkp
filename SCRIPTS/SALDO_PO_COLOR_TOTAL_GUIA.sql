USE [MULTI]
GO
/****** Object:  StoredProcedure [dbo].[SALDO_PO_COLOR_TOTAL]    Script Date: 02/20/2015 14:19:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================
-- Author:		MABEL MOLINA
-- Create date: 26-02-2015
-- Description:	HELP PARA MOSTRAR LAS CANTIDADES
--				DE PRENDAS DISPONIBLES PARA EL INGRESO
--				apara amtar las guias de salida del modelador
--				con las GUIAS DE PROVEEDOR POR ESTILO SIN 
--				DISCRIMINAR NI TALLA NI PO
-- ======================================================
alter PROCEDURE [dbo].[SALDO_PO_COLOR_TOTAL_GUIA]
	@EST CHAR(50),
	@RUC CHAR(18),
	@SER CHAR(2),
	@CON CHAR(2),
	@DEF CHAR(2)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT  ESTCLI, COLOR, SUM(SALE) AS SALDO, (GUIA) AS GUIA, PO FROM
(SELECT  ID, ESTCLI, COLOR, GUIA, PO,
SUM(C0) + SUM(C1) + SUM(C2)+SUM(C3)+ SUM(C4)+SUM(C5)+SUM(C6)+SUM(C7)+ SUM(C8) + SUM(C9) AS SALE 
FROM VIEW_POS_MOVI
where mov = 'S' and estcli = @EST and ruc = @RUC and codser = @SER and codcon= @CON 
GROUP BY color, estcli, ID, GUIA,PO, MOV
UNION
SELECT  ID, ESTCLI, COLOR, GUIA, PO, 
(SUM(C0) + SUM(C1) + SUM(C2)+SUM(C3)+ SUM(C4)+SUM(C5)+SUM(C6)+SUM(C7)+ SUM(C8) + SUM(C9))*-1 AS SALE 
FROM VIEW_POS_MOVI
where mov = 'I' and estcli = @EST and ruc = @RUC and codser = @SER and codcon= @CON
GROUP BY  color, estcli, ID, GUIA, PO,MOV) SS

GROUP BY ESTCLI, COLOR,GUIA, po
having  SUM(SALE) > 0
ORDER BY estcli, COLOR
END
