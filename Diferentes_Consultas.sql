-----------------CAMBIAR EL TAMAÑO DEL TIPO DE DATO---------------------

--Encontrar los diferentes tamaños de la columna COD_AGENCIA
SELECT DISTINCT LEN(COD_AGENCIA) FROM [dbo].[TB_AGENCIA]

--Encontrar las filas donde el tamaño de la columna COD_AGENCIA sea 7
SELECT * FROM [dbo].[TB_AGENCIA]
WHERE LEN(COD_AGENCIA) = 7

--Eliminar esa fila 
DELETE FROM [dbo].[TB_AGENCIA]
WHERE COD_AGENCIA = 'AGENCIA'

--Ahora si procedemos a cambiar el tamaño del tipo de dato
ALTER TABLE [dbo].[TB_AGENCIA] ALTER COLUMN COD_AGENCIA CHAR(4)

---------------------------GROUP BY--------------------------------------

--Cantidad de agencias por zona
SELECT ZONA, COUNT(*) CANTIDAD_AGENCIAS FROM [dbo].[TB_AGENCIA]
GROUP BY ZONA
ORDER BY 2

--Zonas con 46 agencias
SELECT ZONA, COUNT(*) CANTIDAD_AGENCIAS FROM [dbo].[TB_AGENCIA]
GROUP BY ZONA
HAVING COUNT(*) = 46

--Cantidad de distritos por departamentos
SELECT DISTINCT DEPARTAMENTO, COUNT(DISTRITO) CANTIDAD_DISTRITOS FROM [dbo].[TB_UBIGEO]
GROUP BY DEPARTAMENTO
ORDER BY 2

--Departamentos con más de 150 distritos
SELECT DISTINCT DEPARTAMENTO, COUNT(DISTRITO) CANTIDAD_DISTRITOS FROM [dbo].[TB_UBIGEO]
GROUP BY DEPARTAMENTO
HAVING COUNT(DISTRITO) > 150
ORDER BY 1

--Cantidad de tipos de segmentos por segmento
SELECT DISTINCT SEGMENTO, COUNT(TIPO_SEGMENTO) CANTIDAD_TIPO_SEGMENTOS FROM [dbo].[TB_SEGMENTO]
GROUP BY SEGMENTO

--Cantidad de prestamos por tipo de prestamo
SELECT COD_PRODUCTO, COUNT(CONTRATO) CANTIDAD_PRESTAMOS FROM [dbo].[TB_CLIENTE_PRESTAMOS]
GROUP BY COD_PRODUCTO
ORDER BY 2

------------------------------CONSULTAS GENERALES-----------------------------------------------

--Mostrar los clientes de sexo femenimo
SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE SEXO = 'F'

--Mostrar los clientes que tienen telefono
SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE TIENE_TELEFONO = 'S'

--Mostrar los 10 clientes con mayores ingresos
SELECT TOP(10) * FROM [dbo].[TB_CLIENTE_PERFIL]
ORDER BY INGRESO DESC

--Mostar el 20% de clientes con mayor rentabilidad
SELECT TOP 20 PERCENT * FROM [dbo].[TB_CLIENTE_RENTABILIDAD]
ORDER BY RENTABILIDAD DESC

--Mostrar clientes con saldo pasivo menor a 10000
SELECT * FROM [dbo].[TB_CLIENTE_RENTABILIDAD]
WHERE SALDO_PASIVO < 10000
ORDER BY SALDO_PASIVO DESC

--Mostrar clientes con ingreso igual a 5000
SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE INGRESO = 5000

--Mostrar clientes con saldo hipotecario no menor a 250000
SELECT * FROM [dbo].[TB_CLIENTE_PRODUCTOS]
WHERE SALDO_HIPOTECARIO >= 250000
ORDER BY SALDO_HIPOTECARIO ASC

--Mostrar clientes con saldo activo entre 1500 y 3500
SELECT * FROM [dbo].[TB_CLIENTE_RENTABILIDAD]
WHERE SALDO_ACTIVO BETWEEN 1500 AND 3500
ORDER BY SALDO_ACTIVO ASC

--Mostrar clientes que tengan prestamo hipotecario
SELECT * FROM [dbo].[TB_CLIENTE_PRESTAMOS]
WHERE COD_PRODUCTO LIKE 'H%'

---------------------BUSQUEDA EN 2 TABLAS------------------------

--Primero se busca los codigos de segmentos premium
SELECT * FROM [dbo].[TB_SEGMENTO]
WHERE TIPO_SEGMENTO LIKE '%PREMIUM%'   --CODIGOS 288011  288022

--Segundo se hace la busqueda de los clientes premium
SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE COD_SEGMENTO IN ('288011','288022')
ORDER BY COD_SEGMENTO

------------------------------CONSULTAS GENERALES-------------------------------

--Mostrar cantidad de clientes que tienen telefono y correo
SELECT COUNT(*) CLIENTES_CON_TELEFONO_Y_CORREO FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE TIENE_TELEFONO = 'S' AND TIENE_CORREO = 'S'

--Mostrar clientes sin ingreso especificado o ingreso cero
SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE (INGRESO = 0 OR INGRESO IS NULL)

--Mostrar todos los prestamos, no considerar los prestamos vehiculares
SELECT * FROM [dbo].[TB_CLIENTE_PRESTAMOS]
WHERE COD_PRODUCTO NOT LIKE 'V%'

---------------------BUSQUEDA EN 2 TABLAS------------------------

--Primero se busca los codigos que pertenecen a lima o callao
SELECT COD_UBIGEO FROM [dbo].[TB_UBIGEO]
WHERE (DEPARTAMENTO = 'LIMA' OR DEPARTAMENTO = 'CALLAO')

--Segungo se busca los clientes que pertenecen a lima o callao
SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE COD_UBIGEO IN (SELECT COD_UBIGEO FROM [dbo].[TB_UBIGEO]
WHERE (DEPARTAMENTO = 'LIMA' OR DEPARTAMENTO = 'CALLAO'))

------------------------------CONSULTAS GENERALES-------------------------------

--Mostrar distritos que inician con C o S, pero que sean de Lima
SELECT * FROM [dbo].[TB_UBIGEO]
WHERE (DISTRITO LIKE 'C%' OR DISTRITO LIKE 'S%')
		AND DEPARTAMENTO = 'LIMA'


SELECT * FROM [dbo].[TB_UBIGEO]
WHERE DISTRITO LIKE '[CS]%'
		AND DEPARTAMENTO = 'LIMA'

--------------------ELIMINAR ESPACIOS EN BLANCO------------------------------

--Mostrar distritos que empiecen con I o A, y que sean de 3 caracteres
SELECT * FROM [dbo].[TB_UBIGEO]
WHERE DISTRITO LIKE '[IA]__' --Los guiones _ te va contar espacios en blanco

SELECT * FROM [dbo].[TB_UBIGEO]
WHERE DISTRITO LIKE '[IA]%' 
		AND LEN(DISTRITO) = 3 --La funcion LEN no te cuenta espacios en blanco

--Procedemos a eliminar los espacios en blanco y actualizar la tabla
UPDATE [dbo].[TB_UBIGEO]
SET DISTRITO = RTRIM(LTRIM(DISTRITO))

------------------------------CONSULTAS GENERALES-------------------------------

--Mostrar la suma total del saldo pasivo de todos los clientes
SELECT SUM(SALDO_PASIVO) SALDO_PASIVO_TOTAL FROM [dbo].[TB_CLIENTE_RENTABILIDAD]

--Mostrar el promedio del saldo activo de todos los cliente
SELECT AVG(SALDO_ACTIVO) SALDO_ACTIVO_PROMEDIO FROM [dbo].[TB_CLIENTE_RENTABILIDAD]

--Mostrar el desembolso máximo
SELECT MAX(DESEMBOLSO) DESEMBOLSO_MAXIMO FROM [dbo].[TB_CLIENTE_PRESTAMOS]

--Mostrar el desembolso mínimo
SELECT MIN(DESEMBOLSO) DESEMBOLSO_MINIMO FROM [dbo].[TB_CLIENTE_PRESTAMOS]

--Mostrar el desembolso promedio
SELECT AVG(DESEMBOLSO) DESEMBOLSO_PROMEDIO FROM [dbo].[TB_CLIENTE_PRESTAMOS]

--Mostrar la cantidad de clientes por agencia, mostrando su masa salarial y el promedio de ingresos
SELECT COD_AGENCIA,COUNT(*) TOTAL_CLIENTES, SUM(INGRESO) MASA_SALARIAL, AVG(INGRESO) PROMEDIO_INGRESOS 
FROM [dbo].[TB_CLIENTE_PERFIL]
GROUP BY COD_AGENCIA
ORDER BY 1

--Mostrar clientes mayores de 35 años
SELECT DATEDIFF(DAY,FH_NACIMIENTO,GETDATE())/365.2 EDAD, * FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE DATEDIFF(DAY,FH_NACIMIENTO,GETDATE())/365.2 > 35
ORDER BY 1

---------------------------------CONVERTIR FORMATOS DE FECHA----------------------------------------------

--Generar una variable de envío de kit de bienvenida 15 dias despues a la fecha de alta
SELECT CODIGO,FH_ALTA,DATEADD(DAY,15,FH_ALTA) FECHA_KIT FROM [dbo].[TB_CLIENTE_PERFIL]

SELECT CODIGO,FH_ALTA,CONVERT(varchar,DATEADD(DAY,15,FH_ALTA),23) FECHA_KIT FROM [dbo].[TB_CLIENTE_PERFIL]

--------------------------------------CREAR TABLAS EN PLENA CONSULTA-------------------------------------------------

--Generar una tabla con una fecha de campaña que sea 20 dias antes a la fecha de vencimiento del prestamo
SELECT CODIGO,FECHA_ALTA,FECHA_VENCIMIENTO, CONVERT(varchar,DATEADD(DAY,-20,FECHA_VENCIMIENTO),23) RENOVACION_CAMPAÑA 
INTO TCREADA_CAMPAÑARENOVACION
FROM [dbo].[TB_CLIENTE_PRESTAMOS]

SELECT * FROM [dbo].[TCREADA_CAMPAÑARENOVACION]

--Generar una tabla que se vea los detalles del cumpleaños del cliente
SELECT CODIGO,FH_NACIMIENTO,DAY(FH_NACIMIENTO) DIA_NACIMIENTO, MONTH(FH_NACIMIENTO) MES_NACIMIENTO, 
		YEAR(FH_NACIMIENTO) AÑO_NACIMIENTO,DATENAME(MONTH,FH_NACIMIENTO) MES_CUMPLEAÑOS 
INTO TCREADA_MESCUMPLEAÑERO
FROM [dbo].[TB_CLIENTE_PERFIL]

SELECT * FROM [dbo].[TCREADA_MESCUMPLEAÑERO]

---------------------------------------CONSULTAS GENERALES------------------------------------------

--Crear una columna donde se reemplace el sexo M por Masculino
SELECT SEXO, REPLACE(SEXO,'M','Masculino') FROM [dbo].[TB_CLIENTE_PERFIL]

--Extraer el primer caracter del tipo de prestamo
SELECT LEFT(PRESTAMO,1) PRIMER_CARACTER,* FROM [dbo].[TB_TIPO_PRESTAMO]

--Extraer del codigo de cliente, 4 caracteres a partir de la posicion 2
SELECT CODIGO, SUBSTRING(CODIGO,2,4) FROM [dbo].[TB_CLIENTE_PERFIL]

--Mostrar el número maximo de caracteres del detalle de los distritos
SELECT MAX(LEN(DISTRITO)) MAX_NUMERO_CARACTERES FROM [dbo].[TB_UBIGEO]

--Extraer los ultimos 3 digitos del tipo de prestamo
SELECT RIGHT(RTRIM(PRESTAMO),3) PRIMER_CARACTER,* FROM [dbo].[TB_TIPO_PRESTAMO]

--Mostrar datos del cliente con rango de edades
SELECT CODIGO,FH_NACIMIENTO, 
		(DATEDIFF(DAY,FH_NACIMIENTO,GETDATE())/365.2) EDAD, 
		(CASE WHEN DATEDIFF(DAY,FH_NACIMIENTO,GETDATE())/365.2 < 18 THEN '< 18'
		 WHEN DATEDIFF(DAY,FH_NACIMIENTO,GETDATE())/365.2 <= 25 THEN '18 - 25'
		 WHEN DATEDIFF(DAY,FH_NACIMIENTO,GETDATE())/365.2 <= 35 THEN '26 - 35'
		 WHEN DATEDIFF(DAY,FH_NACIMIENTO,GETDATE())/365.2 <= 40 THEN '36 - 40'
		 WHEN DATEDIFF(DAY,FH_NACIMIENTO,GETDATE())/365.2 <= 50 THEN '41 - 50'
		 WHEN DATEDIFF(DAY,FH_NACIMIENTO,GETDATE())/365.2 <= 65 THEN '51 - 65'
		 ELSE '+65'
		END)RANGO_EDAD 
FROM [dbo].[TB_CLIENTE_PERFIL]
ORDER BY EDAD

------------------------------------IN y EXISTS------------------------------------------------

---Muestrame los cliente que tienen prestamo vehicular y que tienen ingresos mayores a 35000

--Se muestra los clientes que tienen igresos mayores a 35000
SELECT DISTINCT CODIGO FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE INGRESO > 35000

--Se muestra el resultado usando IN
SELECT * FROM [dbo].[TB_CLIENTE_PRESTAMOS]
WHERE COD_PRODUCTO LIKE 'V%' AND
	CODIGO IN (SELECT DISTINCT CODIGO FROM [dbo].[TB_CLIENTE_PERFIL]
				WHERE INGRESO > 35000)

--Se muestra el resultado usando EXISTS
SELECT * FROM [dbo].[TB_CLIENTE_PRESTAMOS] T
WHERE COD_PRODUCTO LIKE 'V%' AND
	EXISTS (SELECT DISTINCT CODIGO FROM [dbo].[TB_CLIENTE_PERFIL]
				WHERE INGRESO > 35000 AND CODIGO = T.CODIGO)

--Se muestra el resultado usando JOINS
SELECT * FROM [dbo].[TB_CLIENTE_PERFIL] A
INNER JOIN [dbo].[TB_CLIENTE_PRESTAMOS] B
ON A.CODIGO = B.CODIGO
WHERE B.COD_PRODUCTO LIKE 'V%' AND A.INGRESO > 35000 

------------------------------DECLARACION DE VARIABLES----------------------------------------
-------------------------------------USO DEL CAST---------------------------------------------

--Hacer un procedimiento donde se ingrese el codigo del cliente y te muestre la cantidad de productos
--y si es un cliente vinculado( mas de 3 productos)

DECLARE @CODIGO VARCHAR(12),
		@CANTIDAD_PRODUCTOS FLOAT
SET @CODIGO = '469237411901'
SET @CANTIDAD_PRODUCTOS = (SELECT CTA_AHORRO FROM [dbo].[TB_CLIENTE_PRODUCTOS] WHERE CODIGO = @CODIGO)+
						(SELECT CTA_CTS FROM [dbo].[TB_CLIENTE_PRODUCTOS] WHERE CODIGO = @CODIGO)+
						(SELECT CTA_FONDO FROM [dbo].[TB_CLIENTE_PRODUCTOS] WHERE CODIGO = @CODIGO)+
						(SELECT CTA_HIPOTECARIO FROM [dbo].[TB_CLIENTE_PRODUCTOS] WHERE CODIGO = @CODIGO)+
						(SELECT CTA_PLAZO FROM [dbo].[TB_CLIENTE_PRODUCTOS] WHERE CODIGO = @CODIGO)+
						(SELECT CTA_PRESTAMO FROM [dbo].[TB_CLIENTE_PRODUCTOS] WHERE CODIGO = @CODIGO)+
						(SELECT CTA_TARJETA FROM [dbo].[TB_CLIENTE_PRODUCTOS] WHERE CODIGO = @CODIGO)

SELECT @CODIGO CODIGO_CLIENTE,@CANTIDAD_PRODUCTOS CANTIDAD_PRODUCTOS

IF @CANTIDAD_PRODUCTOS > 3
	BEGIN
	PRINT 'ES UN CLIENTE VINCULADO POR TENER '+CAST(@CANTIDAD_PRODUCTOS AS VARCHAR(2))+' PRODUCTOS'
	END
ELSE
	BEGIN
	PRINT 'NO ES UN CLIENTE VINCULADO'
	END

--------------------------------------------TRIGGER----------------------------------------------------
SELECT * FROM [dbo].[TB_ESTADO_CIVIL]

--Trigger para insertar datos
CREATE TRIGGER ESTADO_CIVIL_ALERTA
ON [dbo].[TB_ESTADO_CIVIL]
AFTER INSERT
AS
BEGIN
	PRINT('SE INSERTARON LOS DATOS CORRECTAMENTE')
END

--Probando trigger de insertar datos
INSERT INTO [dbo].[TB_ESTADO_CIVIL](ECIVIL,ESTADO_CIVIL)
VALUES ('X','INDEFINIDO')

--Verificar datos insertado
SELECT * FROM [dbo].[TB_ESTADO_CIVIL]

--Trigger para eliminar datos
CREATE TRIGGER ESTADO_CIVIL_ALERTA2
ON [dbo].[TB_ESTADO_CIVIL]
AFTER DELETE
AS
BEGIN
	PRINT('SE ELIMINARON LOS DATOS CORRECTAMENTE')
END

--Probado trigger de eliminar datos
DELETE FROM [dbo].[TB_ESTADO_CIVIL]
WHERE ECIVIL = 'X'

--Verificar datos eliminado
SELECT * FROM [dbo].[TB_ESTADO_CIVIL]