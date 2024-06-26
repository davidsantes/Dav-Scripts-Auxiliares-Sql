/**
 * Este script SQL se utiliza para identificar problemas comunes relacionados con el uso de cursores y tablas temporales en procedimientos almacenados en la base de datos "EjemploScriptsSQL".
 * 
 * La consulta busca dos tipos de problemas:
 * 1. Uso de cursores en procedimientos almacenados.
 * 2. Uso de tablas temporales en procedimientos almacenados.
 * 
 * Para cada tipo de problema identificado, se devuelve información sobre el nombre del procedimiento almacenado, el tipo de problema y el tipo de objeto.
 * 
 * La consulta utiliza las vistas del sistema SYSCOMMENTS, SYSOBJECTS y SYSUSERS para obtener información sobre los procedimientos almacenados y sus definiciones de código.
 * 
 * El resultado se ordena por el nombre del procedimiento almacenado.
 */

USE EjemploScriptsSQL
GO

SELECT DISTINCT 
		so.name AS Item
		, 'Procedimiento almacenado' As TipoItem
		, 'Uso de cursores' As TipoProblema
FROM   SYSCOMMENTS sc
	   Inner Join SYSOBJECTS so
	     On  sc.id = so.id
		 And so.xtype = 'P'
	   Inner join SYSUSERS su
		 On so.uid = su.uid
WHERE  Replace(sc.text, ' ', '') COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI Like '%CURSOR%'
       And ObjectProperty(sc.Id, N'IsMSSHIPPED') = 0

UNION

SELECT 
		so.name AS Item
		, 'Procedimiento almacenado' As TipoItem
		, 'Uso de tablas temporales' As TipoProblema
FROM   SYSCOMMENTS sc
	   Inner Join SYSOBJECTS so
	     On  sc.id = so.id
		 And so.xtype = 'P'
	   Inner join SYSUSERS su
		 On so.uid = su.uid
WHERE  Replace(sc.text, ' ', '') COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI Like '%createtable%'
       And ObjectProperty(sc.Id, N'IsMSSHIPPED') = 0

ORDER BY Item