USE [BD_BANCO1]
GO

/****** Object:  Table [dbo].[TB_CLIENTE_PERFIL]    Script Date: 25/02/2024 08:19:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TB_CLIENTE_PERFIL](
	[CODIGO] [varchar](12) NULL,
	[COD_AGENCIA] [varchar](4) NULL,
	[COD_SEGMENTO] [varchar](6) NULL,
	[FH_NACIMIENTO] [varchar](10) NULL,
	[ECIVIL] [varchar](1) NULL,
	[SEXO] [varchar](1) NULL,
	[FH_ALTA] [varchar](10) NULL,
	[COD_UBIGEO] [varchar](7) NULL,
	[TIENE_TELEFONO] [char](1) NULL,
	[TIENE_CORREO] [char](1) NULL,
	[USO_AGENCIA] [char](1) NULL,
	[USO_CAJERO] [char](1) NULL,
	[USO_INTERNET] [char](1) NULL,
	[CLASIFICADO_SBS] [char](1) NULL,
	[INGRESO] [numeric](9, 2) NULL
) ON [PRIMARY]
GO

