USE MULTI
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================
-- Author:		MABEL MOLINA
-- Create date: 26-06-2014
-- Description:	HELP PARA MOSTRAR LAS CANTIDADES
--				DE PRENDAS DISPONIBLES PARA EL INGRESO
--				DE GUIAS DE PROVEEDOR POR ESTILO SIN 
--				DISCRIMINAR NI TALLA NI PO
-- ======================================================
CREATE PROCEDURE SALDO_PO_COLOR
	@EST CHAR(50),
	@COL V
	@RUC CHAR(18),
	@SER CHAR(2),
	@CON CHAR(2),
	@DEF CHAR(2)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT  ESTCLI, COLOR, SUM(SALE) AS SALDO FROM
(SELECT  ESTCLI, COLOR, 
SUM(C0) + SUM(C1) + SUM(C2)+SUM(C3)+ SUM(C4)+SUM(C5)+SUM(C6)+SUM(C7)+ SUM(C8) + SUM(C9) AS SALE , MOV
FROM VIEW_POS_MOVI
where mov = 'S' and estcli = @EST and ruc = @RUC and codser = @SER and codcon= @CON and coddef = @DEF
GROUP BY color, estcli, MOV
UNION
SELECT  ESTCLI, COLOR, 
(SUM(C0) + SUM(C1) + SUM(C2)+SUM(C3)+ SUM(C4)+SUM(C5)+SUM(C6)+SUM(C7)+ SUM(C8) + SUM(C9))*-1 AS SALE , MOV
FROM VIEW_POS_MOVI
where mov = 'I' and estcli = @EST and ruc = @RUC and codser = @SER and codcon= @CON and coddef = @DEF
GROUP BY color, estcli, MOV) SS
GROUP BY ESTCLI, COLOR
END
GO
