-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
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
CREATE PROCEDURE SALDOS_PO
	-- Add the parameters for the stored procedure here
	@EST			CHAR(50),
	@COL			VARCHAR(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT   po,  ESTCLI, COLOR, UBI,
	T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, 
	MIN(Q0) AS Q0, MIN(Q1) AS Q1, MIN(Q2) AS Q2, MIN(Q3) AS Q3, MIN(Q4) AS Q4, 
	MIN(Q5) AS Q5, MIN(Q6) AS Q6, MIN(Q7) AS Q7, MIN(Q8) AS Q8, MIN(Q9) AS Q9,
	SUM(C0) AS S0, SUM(C1) AS S1, SUM(C2) AS S2, SUM(C3) AS S3, SUM(C4) AS S4, 
	SUM(C5) AS S5, SUM(C6) AS S6, SUM(C7) AS S7, SUM(C8) AS S8, SUM(C9) AS S9 
	FROM 

	(SELECT po,  ESTCLI, COLOR, UBI,
	T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, 
	MIN(Q0) AS Q0, MIN(Q1) AS Q1, MIN(Q2) AS Q2, MIN(Q3) AS Q3, MIN(Q4) AS Q4, 
	MIN(Q5) AS Q5, MIN(Q6) AS Q6, MIN(Q7) AS Q7, MIN(Q8) AS Q8, MIN(Q9) AS Q9,
	SUM(C0) AS C0, SUM(C1) AS C1, SUM(C2) AS C2, SUM(C3) AS C3, SUM(C4) AS C4, 
	SUM(C5) AS C5, SUM(C6) AS C6, SUM(C7) AS C7, SUM(C8) AS C8, SUM(C9) AS C9 
	FROM VIEW_POS_MOVI
	where MOV = 'S' AND
	estcli = @EST and color  = @COL
	GROUP BY T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, color, estcli,po, MOV,UBI
	UNION
	SELECT po,  ESTCLI, COLOR, UBI,PO
	T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, 
	MIN(Q0) AS Q0, MIN(Q1) AS Q1, MIN(Q2) AS Q2, MIN(Q3) AS Q3, MIN(Q4) AS Q4, 
	MIN(Q5) AS Q5, MIN(Q6) AS Q6, MIN(Q7) AS Q7, MIN(Q8) AS Q8, MIN(Q9) AS Q9,
	SUM(C0)*-1 AS C0, SUM(C1)*-1 AS C1, SUM(C2)*-1 AS C2, SUM(C3)*-1 AS C3, SUM(C4)*-1 AS C4, 
	SUM(C5)*-1 AS C5, SUM(C6)*-1 AS C6, SUM(C7)*-1 AS C7, SUM(C8)*-1 AS C8, SUM(C9)*-1 AS C9 
	FROM VIEW_POS_MOVI
	where MOV = 'I' AND
	estcli = @EST and color  = @COL
	GROUP BY T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, color, estcli,po, MOV,UBI
	) PPP
	GROUP BY T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, color, estcli,po, UBI


	ORDER BY ESTCLI,COLOR,po
END
GO
