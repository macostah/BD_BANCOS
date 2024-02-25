USE [BD_BANCO1]
GO

/****** Object:  Table [dbo].[TB_CLIENTE_PRESTAMOS]    Script Date: 25/02/2024 08:20:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TB_CLIENTE_PRESTAMOS](
	[CONTRATO] [int] IDENTITY(697274,1) NOT NULL,
	[CODIGO] [varchar](12) NULL,
	[DESEMBOLSO] [numeric](12, 0) NULL,
	[SALDO_REAL] [numeric](12, 0) NULL,
	[MONTO_CUOTA] [numeric](12, 0) NULL,
	[NUMERO_CUOTAS] [numeric](5, 0) NULL,
	[CUOTAS_PAGADAS] [numeric](5, 0) NULL,
	[CUOTAS_PENDIENTES] [numeric](5, 0) NULL,
	[TASA] [numeric](11, 2) NULL,
	[FECHA_ALTA] [varchar](10) NULL,
	[FECHA_VENCIMIENTO] [varchar](10) NULL,
	[COD_PRODUCTO] [varchar](4) NOT NULL
) ON [PRIMARY]
GO

