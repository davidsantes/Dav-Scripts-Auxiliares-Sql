USE EjemploScriptsSQL
GO

SELECT 
	TABLE_NAME AS Item
	, 'Tabla' AS TipoItem
	, 'Tablas con campos de tipo numérico con Escala 0' AS TipoProblema
	, COLUMN_NAME AS NombreColumna
FROM INFORMATION_SCHEMA.COLUMNS C
WHERE
	1=1
	AND C.DATA_TYPE IN ('numeric','decimal') 
	AND NUMERIC_SCALE = 0 
	AND NUMERIC_PRECISION <= 18