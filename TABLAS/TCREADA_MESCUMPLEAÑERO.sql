USE [BD_BANCO1]
GO

/****** Object:  Table [dbo].[TCREADA_MESCUMPLEAÑERO]    Script Date: 25/02/2024 08:25:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TCREADA_MESCUMPLEAÑERO](
	[CODIGO] [varchar](12) NULL,
	[FH_NACIMIENTO] [varchar](10) NULL,
	[DIA_NACIMIENTO] [int] NULL,
	[MES_NACIMIENTO] [int] NULL,
	[AÑO_NACIMIENTO] [int] NULL,
	[MES_CUMPLEAÑOS] [nvarchar](30) NULL
) ON [PRIMARY]
GO

