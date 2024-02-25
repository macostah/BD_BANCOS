USE [BD_BANCO1]
GO

/****** Object:  Table [dbo].[TB_AGENCIA]    Script Date: 25/02/2024 08:19:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TB_AGENCIA](
	[COD_AGENCIA] [char](4) NULL,
	[ZONA] [nvarchar](255) NULL,
	[AGENCIA] [nvarchar](255) NULL
) ON [PRIMARY]
GO

