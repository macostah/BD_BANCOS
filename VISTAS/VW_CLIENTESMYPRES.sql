USE [BD_BANCO1]
GO

/****** Object:  View [dbo].[VW_CLIENTESMYPRES]    Script Date: 25/02/2024 08:30:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VW_CLIENTESMYPRES] AS
SELECT TOP(4) DESEMBOLSO, CODIGO, COD_PRODUCTO FROM [dbo].[TB_CLIENTE_PRESTAMOS]
ORDER BY DESEMBOLSO DESC
GO

