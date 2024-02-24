-----Hacer una tabla que muestre los clientes que tienen solo prestamo hipotecario,------
---------------------------------mostrando algunos datos----------------------------------------

--Tablas involucradas
SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]

SELECT * FROM [dbo].[TB_CLIENTE_PRESTAMOS]

SELECT * FROM [dbo].[TB_TIPO_PRESTAMO]

SELECT * FROM [dbo].[TB_AGENCIA]

SELECT * FROM [dbo].[TB_CLIENTE_RENTABILIDAD]

--Mostrando tabla resultante del join
SELECT D.CONTRATO,C.AGENCIA, (DATEDIFF(DAY,A.FH_NACIMIENTO,GETDATE())/365.2) EDAD,
		A.SEXO, D.DESEMBOLSO,B.SALDO_PASIVO,B.SALDO_ACTIVO 
FROM [dbo].[TB_CLIENTE_PERFIL] A
INNER JOIN [dbo].[TB_CLIENTE_RENTABILIDAD] B
ON A.CODIGO = B.CODIGO
INNER JOIN [dbo].[TB_AGENCIA] C
ON A.COD_AGENCIA = C.COD_AGENCIA COLLATE Modern_Spanish_CI_AS
INNER JOIN [dbo].[TB_CLIENTE_PRESTAMOS] D 
ON A.CODIGO = D.CODIGO 
INNER JOIN [dbo].[TB_TIPO_PRESTAMO] E
ON D.COD_PRODUCTO = E.COD_PRODUCTO
WHERE E.COD_PRODUCTO LIKE 'H%'

-------------------Hacer una tabla con clientes que tengan cuenta ahorro----------------------------
---------------------por rango de edades, mostrando algunos datos-------------------------------------

--Tablas involucradas
SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]

SELECT * FROM [dbo].[TB_CLIENTE_PRODUCTOS]

--Mostrando tabla resultante del join
SELECT	(CASE WHEN DATEDIFF(DAY,A.FH_NACIMIENTO,GETDATE())/365.2 < 18 THEN '< 18'
			WHEN DATEDIFF(DAY,A.FH_NACIMIENTO,GETDATE())/365.2 <= 25 THEN '18 - 25'
			WHEN DATEDIFF(DAY,A.FH_NACIMIENTO,GETDATE())/365.2 <= 35 THEN '26 - 35'
			WHEN DATEDIFF(DAY,A.FH_NACIMIENTO,GETDATE())/365.2 <= 40 THEN '36 - 40'
			WHEN DATEDIFF(DAY,A.FH_NACIMIENTO,GETDATE())/365.2 <= 50 THEN '41 - 50'
			WHEN DATEDIFF(DAY,A.FH_NACIMIENTO,GETDATE())/365.2 <= 65 THEN '51 - 65'
			ELSE 'Mayor a 65'
		END) RANGO_EDAD,
		SUM(B.SALDO_AHORRO) SALDO_TOTAL,
		AVG(B.SALDO_AHORRO) PROMEDIO
FROM [dbo].[TB_CLIENTE_PERFIL] A
INNER JOIN [dbo].[TB_CLIENTE_PRODUCTOS] B
ON A.CODIGO = B.CODIGO
WHERE B.CTA_AHORRO > 0
GROUP BY (CASE WHEN DATEDIFF(DAY,A.FH_NACIMIENTO,GETDATE())/365.2 < 18 THEN '< 18'
			WHEN DATEDIFF(DAY,A.FH_NACIMIENTO,GETDATE())/365.2 <= 25 THEN '18 - 25'
			WHEN DATEDIFF(DAY,A.FH_NACIMIENTO,GETDATE())/365.2 <= 35 THEN '26 - 35'
			WHEN DATEDIFF(DAY,A.FH_NACIMIENTO,GETDATE())/365.2 <= 40 THEN '36 - 40'
			WHEN DATEDIFF(DAY,A.FH_NACIMIENTO,GETDATE())/365.2 <= 50 THEN '41 - 50'
			WHEN DATEDIFF(DAY,A.FH_NACIMIENTO,GETDATE())/365.2 <= 65 THEN '51 - 65'
			ELSE 'Mayor a 65'
		END)

--------------------Elavorar una tabla donde muestre la tenencia de productos-------------------
----------------------------------activos y pasivos---------------------------------------------

--Tablas involucradas
SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]

SELECT * FROM [dbo].[TB_SEGMENTO]

SELECT * FROM [dbo].[TB_CLIENTE_PRODUCTOS]

--Mostrando tabla resultante del join
SELECT A.CODIGO,C.SEGMENTO,(DATEDIFF(DAY,A.FH_NACIMIENTO,GETDATE())/365.2) EDAD,
		A.INGRESO,
		(CASE WHEN (B.CTA_AHORRO + B.CTA_PLAZO + B.CTA_CTS) <= 0 THEN 'N'
				ELSE 'S'
		END) TENENCIA_PRODUCTOS_PASIVOS,
		(CASE WHEN (B.CTA_TARJETA + B.CTA_PRESTAMO + B.CTA_HIPOTECARIO) <= 0 THEN 'N'
				ELSE 'S'
		END) TENENCIA_PRODUCTOS_ACTIVOS
		INTO TCREADA_TENECIAPRODUCTOS
		FROM [dbo].[TB_CLIENTE_PERFIL] A
INNER JOIN [dbo].[TB_CLIENTE_PRODUCTOS] B
ON A.CODIGO = B.CODIGO
INNER JOIN [dbo].[TB_SEGMENTO] C
ON A.COD_SEGMENTO = C.COD_SEGMENTO

--Mostrar tabla creada
SELECT * FROM [dbo].[TCREADA_TENECIAPRODUCTOS]

---------------------Mostrar reporte de clientes que tiene tarjeta de crédito-------------------
------------------------------------por rango de ingresos------.........------------------------

--Tablas involucradas
SELECT * FROM [dbo].[TB_CLIENTE_PRODUCTOS]

SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]

--Mostrando tabla resultante del join
SELECT (CASE WHEN A.INGRESO < 2500 THEN '0 - 2.5M'
			WHEN A.INGRESO < 3500 THEN '2.5M - 3.5M'
			WHEN A.INGRESO < 7000 THEN '3.5M - 7M'
			ELSE '7M +'
			END) RANGO_INGRESOS,
		COUNT(A.CODIGO) CLIENTES,
		SUM(B.SALDO_TARJETA) SALDO,
		AVG(B.SALDO_TARJETA) PROMEDIO
FROM [dbo].[TB_CLIENTE_PERFIL] A
INNER JOIN [dbo].[TB_CLIENTE_PRODUCTOS] B
ON A.CODIGO = B.CODIGO
GROUP BY (CASE WHEN A.INGRESO < 2500 THEN '0 - 2.5M'
			WHEN A.INGRESO < 3500 THEN '2.5M - 3.5M'
			WHEN A.INGRESO < 7000 THEN '3.5M - 7M'
			ELSE '7M +'
			END)

--------------------Mostrar clientes con tarjeta de credito-------------------------------
-------------------------------superiores al promedio-------------------------------------

--Tablas involucradas
SELECT * FROM [dbo].[TB_CLIENTE_PRODUCTOS]

SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]

--Mostrando promedio de ingresos
SELECT AVG(INGRESO) FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE INGRESO > 0

--Mostrando tabla resultante del join
SELECT A.INGRESO,A.*
FROM [dbo].[TB_CLIENTE_PERFIL] A
INNER JOIN [dbo].[TB_CLIENTE_PRODUCTOS] B
ON A.CODIGO = B.CODIGO
WHERE B.CTA_TARJETA > 0
	AND	A.INGRESO > (SELECT AVG(INGRESO) FROM [dbo].[TB_CLIENTE_PERFIL]
					WHERE INGRESO > 0)
ORDER BY A.INGRESO ASC

-----------------------Clientes de Lima metropolitana-------------------------------
------------------con prestamo vehicular mayor a 15000------------------------------

--Tablas involucradas
SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]

SELECT * FROM [dbo].[TB_CLIENTE_PRESTAMOS]

SELECT * FROM [dbo].[TB_UBIGEO]

--Eliminar espacios vacíos
UPDATE [dbo].[TB_UBIGEO]
SET PROVINCIA = LTRIM(RTRIM(PROVINCIA))

--Mostrando tabla resultante del join
SELECT B.DESEMBOLSO,C.DISTRITO,B.COD_PRODUCTO,A.* FROM [dbo].[TB_CLIENTE_PERFIL] A
INNER JOIN [dbo].[TB_CLIENTE_PRESTAMOS] B
ON A.CODIGO = B.CODIGO
INNER JOIN [dbo].[TB_UBIGEO] C
ON A.COD_UBIGEO = C.COD_UBIGEO
WHERE C.PROVINCIA = 'LIMA' AND 
		B.COD_PRODUCTO LIKE 'V%' AND
		B.DESEMBOLSO > 15000
ORDER BY B.DESEMBOLSO ASC

------------------------Clientes con cuenta de ahorro y prestamo vehicular--------------------------------

--Tablas involucradas
SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]

SELECT * FROM [dbo].[TB_CLIENTE_PRODUCTOS]

SELECT * FROM [dbo].[TB_CLIENTE_PRESTAMOS]

--Mostrando tabla resultante del join
SELECT A.CODIGO,A.INGRESO,B.SALDO_AHORRO,'CUENTA AHORRO' TIPO_CUENTA FROM [dbo].[TB_CLIENTE_PERFIL] A
INNER JOIN [dbo].[TB_CLIENTE_PRODUCTOS] B
ON A.CODIGO = B.CODIGO
INNER JOIN [dbo].[TB_CLIENTE_PRESTAMOS] C
ON A.CODIGO = C.CODIGO
WHERE B.CTA_AHORRO > 0 AND
		C.COD_PRODUCTO LIKE 'V%'