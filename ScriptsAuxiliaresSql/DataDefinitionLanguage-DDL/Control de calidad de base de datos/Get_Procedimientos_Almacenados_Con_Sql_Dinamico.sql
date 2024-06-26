/**
 * Este script SQL se utiliza para identificar procedimientos almacenados en la base de datos "EjemploScriptsSQL" que utilizan la ejecución dinámica de consultas.
 * 
 * La consulta busca dos tipos de problemas:
 * 1. Uso de la función EXEC en el cuerpo del procedimiento almacenado.
 * 2. Uso de la función sp_executesql en el cuerpo del procedimiento almacenado.
 * 
 * Para cada tipo de problema identificado, se devuelve información sobre el nombre del procedimiento almacenado, el tipo de problema y el tipo de objeto.
 * 
 * La consulta utiliza las vistas del sistema sys.sql_modules y sys.sysobjects para obtener información sobre los procedimientos almacenados y sus definiciones de código.
 * 
 * El resultado se ordena por el nombre del procedimiento almacenado.
 */

USE EjemploScriptsSQL
GO

SELECT DISTINCT
	so.name AS Item
	, 'Procedimiento almacenado' As TipoItem
	, 'Exec' AS Problema
From   sys.sql_modules sm
		Inner Join sys.sysobjects so
			On  sm.object_id = so.id
			And so.type = 'P'
Where  Replace(sm.definition, ' ', '') COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI Like '%Exec(%'
		And OBJECTPROPERTY(so.Id, N'IsMSSHIPPED') = 0

UNION

SELECT
	so.name AS Item
	, 'Procedimiento almacenado' As TipoItem
	, 'sp_Executesql' AS Problema
FROM   SYSCOMMENTS sc
	   Inner Join SYSOBJECTS so
	     On  sc.id = so.id
		 And so.xtype = 'P'
	   Inner join SYSUSERS su
		 On so.uid = su.uid
WHERE  Replace(sc.text, ' ', '') COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI Like '%sp_Executesql%'
       And ObjectProperty(sc.Id, N'IsMSSHIPPED') = 0

ORDER BY Item