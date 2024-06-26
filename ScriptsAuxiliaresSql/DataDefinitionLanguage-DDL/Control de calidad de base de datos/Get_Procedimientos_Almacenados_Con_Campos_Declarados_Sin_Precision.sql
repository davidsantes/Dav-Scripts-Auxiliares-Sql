/**
 * Este script SQL se utiliza para identificar problemas comunes relacionados con la declaración de campos en procedimientos almacenados en la base de datos "EjemploScriptsSQL".
 * 
 * La consulta busca dos tipos de problemas:
 * 1. Campos declarados sin precisión en procedimientos almacenados: decimal y numeric.
 * 2. Campos declarados sin precisión en procedimientos almacenados: varchar.
 */

USE EjemploScriptsSQL
GO

SELECT DISTINCT
	name AS Item
	, 'Procedimiento almacenado' As TipoItem
	, 'Campos declarados sin precisión: decimal, numeric' AS Problema
FROM sys.objects
WHERE  
	1=1
	AND REPLACE(Object_Definition(Object_ID), 'decimal]','decimal') COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI LIKE '%decimal[^(]%'
	OR REPLACE(Object_Definition(Object_ID), 'numeric]','numeric') COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI LIKE '%[^i][^s]numeric[^(]%'
	   
UNION

SELECT
	so.name As Item
	, 'Procedimiento almacenado' As TipoItem
	, 'Campos declarados sin precisión: varchar' AS Problema
FROM   syscomments sc
	   INNER JOIN sysobjects so
		 ON sc.id = so.id
		 AND so.xtype = 'P'
	   INNER JOIN sys.schemas su
		 ON so.uid = su.schema_id
WHERE  REPLACE(REPLACE(sc.Text, ' ', ''), 'varchar]', 'varchar') COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI LIKE '%varchar[^(]%'
	   AND OBJECTPROPERTY(sc.Id, N'IsMSSHIPPED') = 0
	
ORDER BY Item