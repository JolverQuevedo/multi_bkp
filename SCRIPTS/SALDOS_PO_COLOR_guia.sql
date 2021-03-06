USE [MULTI]
GO
/****** Object:  StoredProcedure [dbo].[SALDOS_PO_COLOR]    Script Date: 02/27/2015 13:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================================
-- Author:		MABEL MOLINA
-- Create date: 20-06-2014
-- Description:	Devuelve los SALDOS PENDIENTES POR ESTILO PARA
--				MOVIMIENTOS DE ACABADO
-- =======================================================================
drop PROCEDURE [dbo].[SALDOS_PO_COLOR_guia]
go
create PROCEDURE [dbo].[SALDOS_PO_COLOR_guia]
	-- Add the parameters for the stored procedure here
	@EST			CHAR(50),
	@COL			VARCHAR(30),
	@RUC			CHAR(18),
	@SER			CHAR(2),
	@CON			CHAR(2),
	@DEF			CHAR(2),
	@POS			CHAR(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		SELECT   po,  ESTCLI, COLOR, UBI,
	T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, 
	case when SUM(C0) < 0 then 0 else SUM(C0) end AS S0, 
	case when SUM(C1) < 0 then 0 else SUM(C1) end AS S1, 
	case when SUM(C2) < 0 then 0 else SUM(C2) end AS S2, 
	case when SUM(C3) < 0 then 0 else SUM(C3) end AS S3, 
	case when SUM(C4) < 0 then 0 else SUM(C4) end AS S4, 
	case when SUM(C5) < 0 then 0 else SUM(C5) end AS S5, 
	case when SUM(C6) < 0 then 0 else SUM(C6) end AS S6, 
	case when SUM(C7) < 0 then 0 else SUM(C7) end AS S7, 
	case when SUM(C8) < 0 then 0 else SUM(C8) end AS S8,
	case when SUM(C9) < 0 then 0 else SUM(C9) end AS S9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	FROM ( select  po,  color, ubi,ESTCLI, ruc,  t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,
	c0= SUM(case when mov = 'i' then c0 *-1 else c0 end),
	c1= SUM(case when mov = 'i' then c1 *-1 else c1 end),
	c2= SUM(case when mov = 'i' then c2 *-1 else c2 end),
	c3= SUM(case when mov = 'i' then c3 *-1 else c3 end),
	c4= SUM(case when mov = 'i' then c4 *-1 else c4 end),
	c5= SUM(case when mov = 'i' then c5 *-1 else c5 end),
	c6= SUM(case when mov = 'i' then c6 *-1 else c6 end),
	c7= SUM(case when mov = 'i' then c7 *-1 else c7 end),
	c8= SUM(case when mov = 'i' then c8 *-1 else c8 end),
	c9= SUM(case when mov = 'i' then c9 *-1 else c9 end)

from view_pos_movi 
where estcli = @EST and ruc = @RUC and codser = @SER and codcon= @CON AND COLOR=@COL AND PO = @POS

GROUP BY  po,  color, ubi,ESTCLI, ruc,
 t0,t1,t2,t3,t4,t5,t6,t7,t8,t9) PPP
	where (c1+c2+c3+c4+c5+c6+c7+c8+c9) > 0
	GROUP BY T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, color, estcli,po, UBI

	ORDER BY ESTCLI,COLOR,po

END