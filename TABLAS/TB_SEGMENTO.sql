USE [BD_BANCO1]
GO

/****** Object:  Table [dbo].[TB_SEGMENTO]    Script Date: 25/02/2024 08:21:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TB_SEGMENTO](
	[COD_SEGMENTO] [nvarchar](255) NOT NULL,
	[SEGMENTO] [nvarchar](255) NULL,
	[TIPO_SEGMENTO] [nvarchar](255) NULL
) ON [PRIMARY]
GO

