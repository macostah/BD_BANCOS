USE [BD_BANCO1]
GO

/****** Object:  StoredProcedure [dbo].[SP_CLIENTES10PRODUCTOS]    Script Date: 25/02/2024 08:33:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CLIENTES10PRODUCTOS] AS
BEGIN

SELECT A.CODIGO,A.INGRESO, 
		(B.CTA_AHORRO+B.CTA_CTS+B.CTA_FONDO+B.CTA_HIPOTECARIO+B.CTA_PLAZO+B.CTA_PRESTAMO+B.CTA_TARJETA) CUENTAS 
FROM [dbo].[TB_CLIENTE_PERFIL] A
INNER JOIN [dbo].[TB_CLIENTE_PRODUCTOS] B 
ON A.CODIGO = B.CODIGO	
INNER JOIN [dbo].[TB_AGENCIA] C
ON A.COD_AGENCIA = C.COD_AGENCIA COLLATE Modern_Spanish_CI_AS
WHERE A.INGRESO > 35000 AND
	(B.CTA_AHORRO+B.CTA_CTS+B.CTA_FONDO+B.CTA_HIPOTECARIO+B.CTA_PLAZO+B.CTA_PRESTAMO+B.CTA_TARJETA) > 10 AND
	C.ZONA = 'LIMA CENTRO'
ORDER BY 2

END
GO

