USE [BD_BANCO1]
GO

/****** Object:  Table [dbo].[TB_CLIENTE_PRODUCTOS]    Script Date: 25/02/2024 08:20:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TB_CLIENTE_PRODUCTOS](
	[CODIGO] [varchar](12) NULL,
	[CTA_AHORRO] [numeric](12, 0) NULL,
	[SALDO_AHORRO] [numeric](12, 0) NULL,
	[CTA_PLAZO] [numeric](12, 0) NULL,
	[SALDO_PLAZO] [numeric](12, 0) NULL,
	[CTA_FONDO] [numeric](12, 0) NULL,
	[SALDO_FONDO] [numeric](12, 0) NULL,
	[CTA_CTS] [numeric](12, 0) NULL,
	[SALDO_CTS] [numeric](12, 0) NULL,
	[CTA_PRESTAMO] [numeric](12, 0) NULL,
	[SALDO_PRESTAMO] [numeric](12, 0) NULL,
	[CTA_HIPOTECARIO] [numeric](12, 0) NULL,
	[SALDO_HIPOTECARIO] [numeric](12, 0) NULL,
	[CTA_TARJETA] [numeric](12, 0) NULL,
	[SALDO_TARJETA] [numeric](12, 0) NULL
) ON [PRIMARY]
GO

