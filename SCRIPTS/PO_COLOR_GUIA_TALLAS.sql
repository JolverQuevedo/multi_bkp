USE [MULTI]
GO
/****** Object:  StoredProcedure [dbo].[PO_COLOR_GUIA_TALLAS]    Script Date: 07/25/2014 17:08:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		MABEL MOLINA
-- Create date: 08-07-2014
-- Description:	MUESTRA LO DISPONIBLE POR TIPO 
--				DE SERVICIO PARA HACER GUIA
-- =============================================
ALTER PROCEDURE [dbo].[PO_COLOR_GUIA_TALLAS]
	-- Add the parameters for the stored procedure here
	@EST			CHAR(50),
	@RUC			CHAR(18),
	@SER			CHAR(2),
	@POS			VARCHAR(50),
	@COL			VARCHAR(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select CODART, po, color, ubi,  t0, t1, t2, t3, t4, t5, t6, t7, t8, t9,
	c0 = SUM(C0), c1 = SUM(C1), c2 = SUM(C2), c3 = SUM(C3), 
	c4 = SUM(C4), c5 = SUM(C5), c6 = SUM(C6), c7 = SUM(C7), 
	c8 = SUM(C8), c9 = SUM(C9), tot= sum(c0+c1+c2+c3+c4+c5+c6+c7+c8+c9) 
from view_pos_movi 
where MOV = 'S' AND GUIA='' 
	and estcli = @EST and ruc =  @RUC and codser=@SER
	AND PO =(LTRIM(RTRIM(@POS))) and color = @col
GROUP BY CODART, po,  color, ubi,  t0,t1,t2,t3,t4,t5,t6,t7,t8,t9
END
