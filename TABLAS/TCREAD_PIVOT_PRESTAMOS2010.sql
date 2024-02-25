USE [BD_BANCO1]
GO

/****** Object:  Table [dbo].[TCREAD_PIVOT_PRESTAMOS2010]    Script Date: 25/02/2024 08:24:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TCREAD_PIVOT_PRESTAMOS2010](
	[PRESTAMO] [nvarchar](255) NULL,
	[ENE_10] [numeric](38, 0) NULL,
	[FEB_10] [numeric](38, 0) NULL,
	[MAR_10] [numeric](38, 0) NULL,
	[ABR_10] [numeric](38, 0) NULL,
	[MAY_10] [numeric](38, 0) NULL,
	[JUN_10] [numeric](38, 0) NULL,
	[JUL_10] [numeric](38, 0) NULL,
	[AGO_10] [numeric](38, 0) NULL,
	[SET_10] [numeric](38, 0) NULL,
	[OCT10] [numeric](38, 0) NULL,
	[NOV_10] [numeric](38, 0) NULL,
	[DIC_10] [numeric](38, 0) NULL
) ON [PRIMARY]
GO

