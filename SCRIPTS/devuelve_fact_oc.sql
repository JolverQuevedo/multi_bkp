USE [MULTI]
GO
/****** Object:  StoredProcedure [dbo].[DEVUELVE_FACT_OC]    Script Date: 10/10/2013 11:46:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[DEVUELVE_FACT_OC]
(
	@CNUMDOC	char(20),
	@TBL	VARCHAR(50)
)
AS

DECLARE @p VARCHAR(MAX)
	
SET	@p= 'Select  ''  FT:'''' + ''rtrim(CP_CNUMDOC)'''  + '''/''' +'	From ' + (@TBL)
SET	@P = @P + 'WHERE CP_CTIPDOC=''FT'''+ ' AND CP_CNDOCRE='+@CNUMDOC+'  Order by CP_CNUMDOC'
	
PRINT @p
exec sp_executesql @P

