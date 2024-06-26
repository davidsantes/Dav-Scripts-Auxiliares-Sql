/**
 * Este script SQL se utiliza para identificar procedimientos almacenados en la base de datos "EjemploScriptsSQL" que contienen instrucciones DDL (Data Definition Language) específicas.
 * 
 * La consulta busca procedimientos almacenados que contienen las siguientes instrucciones DDL:
 * - ALTER
 * - DROP
 * - ADD
 * - REVOKE
 * - GRANT
 * - REFERENCES
 * - TRUNCATE
 * - ENABLE
 * - DISABLE
 * - RENAME
 * - EXECUTE
 * 
 * Para cada tipo de problema identificado, se devuelve información sobre el nombre del procedimiento almacenado, el tipo de problema y el tipo de objeto.
 * 
 * La consulta utiliza las vistas del sistema sys.sql_modules y sys.objects para obtener información sobre los procedimientos almacenados y sus definiciones.
 * 
 * El resultado se ordena por el tipo de problema.
 */

USE EjemploScriptsSQL
GO

SELECT DISTINCT so.name As Item, 'Procedimiento almacenado' AS TipoItem, 'Procedimiento almacenado con DDL: ALTER' AS TipoProblema
FROM
	sys.sql_modules m INNER JOIN sys.objects so ON m.object_id = so.object_id
WHERE 
	so.type = 'P' AND so.is_ms_shipped = 0 AND m.definition Like '%ALTER%'
	
UNION

SELECT DISTINCT so.name As Item, 'Procedimiento almacenado' AS TipoItem, 'Procedimiento almacenado con DDL:DROP' AS TipoProblema
FROM
	sys.sql_modules m INNER JOIN sys.objects so ON m.object_id = so.object_id
WHERE 
	so.type = 'P' AND so.is_ms_shipped = 0 AND m.definition Like '%DROP%'
	
UNION

SELECT DISTINCT so.name As Item, 'Procedimiento almacenado' AS TipoItem, 'Procedimiento almacenado con DDL:ADD' AS TipoProblema
FROM
	sys.sql_modules m INNER JOIN sys.objects so ON m.object_id = so.object_id
WHERE 
	so.type = 'P' AND so.is_ms_shipped = 0 AND m.definition Like '%ADD%'
	
UNION

SELECT DISTINCT so.name As Item, 'Procedimiento almacenado' AS TipoItem, 'Procedimiento almacenado con DDL:REVOKE' AS TipoProblema
FROM
	sys.sql_modules m INNER JOIN sys.objects so ON m.object_id = so.object_id
WHERE 
	so.type = 'P' AND so.is_ms_shipped = 0 AND m.definition Like '%REVOKE%'
	
UNION

SELECT DISTINCT so.name As Item, 'Procedimiento almacenado' AS TipoItem, 'Procedimiento almacenado con DDL:GRANT' AS TipoProblema
FROM
	sys.sql_modules m INNER JOIN sys.objects so ON m.object_id = so.object_id
WHERE 
	so.type = 'P' AND so.is_ms_shipped = 0 AND m.definition Like '%GRANT%'

UNION

SELECT DISTINCT so.name As Item, 'Procedimiento almacenado' AS TipoItem, 'Procedimiento almacenado con DDL:REFERENCES' AS TipoProblema
FROM
	sys.sql_modules m INNER JOIN sys.objects so ON m.object_id = so.object_id
WHERE 
	so.type = 'P' AND so.is_ms_shipped = 0 AND m.definition Like '%REFERENCES%'

UNION

SELECT DISTINCT so.name As Item, 'Procedimiento almacenado' AS TipoItem, 'Procedimiento almacenado con DDL:TRUNCATE' AS TipoProblema
FROM
	sys.sql_modules m INNER JOIN sys.objects so ON m.object_id = so.object_id
WHERE 
	so.type = 'P' AND so.is_ms_shipped = 0 AND m.definition Like '%TRUNCATE%'

UNION

SELECT DISTINCT so.name As Item, 'Procedimiento almacenado' AS TipoItem, 'Procedimiento almacenado con DDL:ENABLE' AS TipoProblema
FROM
	sys.sql_modules m INNER JOIN sys.objects so ON m.object_id = so.object_id
WHERE 
	so.type = 'P' AND so.is_ms_shipped = 0 AND m.definition Like '%ENABLE%'

UNION

SELECT DISTINCT so.name As Item, 'Procedimiento almacenado' AS TipoItem, 'Procedimiento almacenado con DDL:DISABLE' AS TipoProblema
FROM
	sys.sql_modules m INNER JOIN sys.objects so ON m.object_id = so.object_id
WHERE 
	so.type = 'P' AND so.is_ms_shipped = 0 AND m.definition Like '%DISABLE%'

UNION

SELECT DISTINCT so.name As Item, 'Procedimiento almacenado' AS TipoItem, 'Procedimiento almacenado con DDL:RENAME' AS TipoProblema
FROM
	sys.sql_modules m INNER JOIN sys.objects so ON m.object_id = so.object_id
WHERE 
	so.type = 'P' AND so.is_ms_shipped = 0 AND m.definition Like '%RENAME%'

UNION

SELECT DISTINCT so.name As Item, 'Procedimiento almacenado' AS TipoItem, 'Procedimiento almacenado con DDL:EXECUTE' AS TipoProblema
FROM
	sys.sql_modules m INNER JOIN sys.objects so ON m.object_id = so.object_id
WHERE 
	so.type = 'P' AND so.is_ms_shipped = 0 AND m.definition Like '%EXECUTE%'

ORDER BY TipoProblema