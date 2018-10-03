USE [multi]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[POS0001](
	[PO] char(20) NOT NULL primary key,
	[ESTILO] CHAR(50) NOT NULL,
	[ARTICULO] CHAR(10) NOT NULL,
	[CLIENTE] CHAR(5),
	[CANTIDAD] NUMERIC (10,0),
	[PRECIO] NUMERIC(10,2),
	[DESCRIPCION] VARCHAR(200) ,
	[USUARIO] CHAR(4),
	[FECHA] [SMALLdatetime] DEFAULT GETDATE(),
	[ESTADO] CHAR(1) DEFAULT 'A'
) ON [PRIMARY]

CREATE TABLE [dbo].[POS0002](
	[PO] char(20) NOT NULL primary key,
	[ESTILO] CHAR(50) NOT NULL,
	[ARTICULO] CHAR(10) NOT NULL,
	[CLIENTE] CHAR(5),
	[CANTIDAD] NUMERIC (10,0),
	[PRECIO] NUMERIC(10,2),
	[DESCRIPCION] VARCHAR(200) ,
	[USUARIO] CHAR(4),
	[FECHA] [SMALLdatetime] DEFAULT GETDATE(),
	[ESTADO] CHAR(1) DEFAULT 'A'
) ON [PRIMARY]

GO
CREATE TABLE [dbo].[POS0003](
	[PO] char(20) NOT NULL primary key,
	[ESTILO] CHAR(50) NOT NULL,
	[ARTICULO] CHAR(10) NOT NULL,
	[CLIENTE] CHAR(5),
	[CANTIDAD] NUMERIC (10,0),
	[PRECIO] NUMERIC(10,2),
	[DESCRIPCION] VARCHAR(200) ,
	[USUARIO] CHAR(4),
	[FECHA] [SMALLdatetime] DEFAULT GETDATE(),
	[ESTADO] CHAR(1) DEFAULT 'A'
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[POS0006](
	[PO] char(20) NOT NULL primary key,
	[ESTILO] CHAR(50) NOT NULL,
	[ARTICULO] CHAR(10) NOT NULL,
	[CLIENTE] CHAR(5),
	[CANTIDAD] NUMERIC (10,0),
	[PRECIO] NUMERIC(10,2),
	[DESCRIPCION] VARCHAR(200) ,
	[USUARIO] CHAR(4),
	[FECHA] [SMALLdatetime] DEFAULT GETDATE(),
	[ESTADO] CHAR(1) DEFAULT 'A'
) ON [PRIMARY]
go
CREATE TABLE [dbo].[POS0008](
	[PO] char(20) NOT NULL primary key,
	[ESTILO] CHAR(50) NOT NULL,
	[ARTICULO] CHAR(10) NOT NULL,
	[CLIENTE] CHAR(5),
	[CANTIDAD] NUMERIC (10,0),
	[PRECIO] NUMERIC(10,2),
	[DESCRIPCION] VARCHAR(200) ,
	[USUARIO] CHAR(4),
	[FECHA] [SMALLdatetime] DEFAULT GETDATE(),
	[ESTADO] CHAR(1) DEFAULT 'A'
) ON [PRIMARY]

GO
GO

