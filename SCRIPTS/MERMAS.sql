if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[MERMAS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[MERMAS]
GO

CREATE TABLE [dbo].[MERMAS] (
	[SERVICIOS] [float] NULL ,
	[TELAS] [float] NULL ,
	[AVIOS] [float] NULL ,
	[HILO] [float] NULL ,
	[TEJIDO] [float] NULL ,
	[TENIDO] [float] NULL ,
	[USUARIO] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FECHA] [smalldatetime] NULL ,
	[ESTADO] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CORTE] [float] NULL ,
	[ACABADO] [float] NULL ,
	[COSTURA] [float] NULL ,
	[EMBALAJE] [float] NULL ,
	[ENCONADO] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MERMAS] WITH NOCHECK ADD 
	CONSTRAINT [DF__MERMAS__ESTADO__08012052] DEFAULT ('A') FOR [ESTADO],
	CONSTRAINT [DF_MERMAS_SINTETICOS] DEFAULT (0) FOR [ENCONADO]
GO

