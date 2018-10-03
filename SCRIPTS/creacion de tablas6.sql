USE [MULTI]
GO
/****** Object:  Table [dbo].[AL_TipoMovxAlmacen]    Script Date: 08/18/2013 10:55:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AL_TipoMovxAlmacen0001](
	[CodTipoMov] [char](3) NOT NULL ,
	[CodAlmacen] [char](4) NOT NULL,
 CONSTRAINT [PK_AL_TipoMovxAlmacen0001] PRIMARY KEY CLUSTERED 
(
	[CodTipoMov] ASC,
	[CodAlmacen] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[AL_TipoMovxAlmacen0002](
	[CodTipoMov] [char](3) NOT NULL ,
	[CodAlmacen] [char](4) NOT NULL,
 CONSTRAINT [PK_AL_TipoMovxAlmacen0002] PRIMARY KEY CLUSTERED 
(
	[CodTipoMov] ASC,
	[CodAlmacen] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[AL_TipoMovxAlmacen0006](
	[CodTipoMov] [char](3) NOT NULL ,
	[CodAlmacen] [char](4) NOT NULL,
 CONSTRAINT [PK_AL_TipoMovxAlmacen0006] PRIMARY KEY CLUSTERED 
(
	[CodTipoMov] ASC,
	[CodAlmacen] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[AL_TipoMovxAlmacen0008](
	[CodTipoMov] [char](3) NOT NULL ,
	[CodAlmacen] [char](4) NOT NULL,
 CONSTRAINT [PK_AL_TipoMovxAlmacen0008] PRIMARY KEY CLUSTERED 
(
	[CodTipoMov] ASC,
	[CodAlmacen] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO AL_TipoMovxAlmacen0001 SELECT * FROM MODELADOR..AL_TipoMovxAlmacen
INSERT INTO AL_TipoMovxAlmacen0002 SELECT * FROM MODELADOR..AL_TipoMovxAlmacen
INSERT INTO AL_TipoMovxAlmacen0006 SELECT * FROM MODELADOR..AL_TipoMovxAlmacen
INSERT INTO AL_TipoMovxAlmacen0008 SELECT * FROM MODELADOR..AL_TipoMovxAlmacen
