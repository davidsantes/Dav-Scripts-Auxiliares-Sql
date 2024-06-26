/**
 * Este script SQL se utiliza para identificar procedimientos almacenados en la base de datos "EjemploScriptsSQL" que comienzan con el prefijo 'sp_'.
 * 
 * La consulta busca procedimientos almacenados cuyos nombres específicos (SPECIFIC_NAME) cumplen con el patrón 'sp_%' en la vista INFORMATION_SCHEMA.ROUTINES.
 * 
 * Se excluyen los procedimientos almacenados relacionados con diagramas.
 * 
 * Para cada procedimiento almacenado identificado, se devuelve información sobre el nombre del procedimiento almacenado, el tipo de problema y el tipo de objeto.
 * 
 * El resultado se ordena por el nombre del procedimiento almacenado.
 */

USE EjemploScriptsSQL
GO

SELECT	
	SPECIFIC_NAME As Item
	, 'Procedimiento almacenado' As TipoItem
	, 'Procedimientos almacenados que empiezan por sp_' As TipoProblema
FROM	INFORMATION_SCHEMA.ROUTINES
WHERE	SPECIFIC_NAME COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI LIKE 'sp[_]%'
		And SPECIFIC_NAME COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI NOT LIKE '%diagram%'
ORDER BY Item