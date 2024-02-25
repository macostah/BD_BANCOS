USE [BD_BANCO1]
GO

/****** Object:  Table [dbo].[TB_UBIGEO]    Script Date: 25/02/2024 08:22:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TB_UBIGEO](
	[COD_UBIGEO] [nvarchar](10) NOT NULL,
	[AREA] [varchar](13) NOT NULL,
	[DISTRITO] [nvarchar](30) NULL,
	[PROVINCIA] [nvarchar](30) NULL,
	[DEPARTAMENTO] [nvarchar](30) NULL
) ON [PRIMARY]
GO

