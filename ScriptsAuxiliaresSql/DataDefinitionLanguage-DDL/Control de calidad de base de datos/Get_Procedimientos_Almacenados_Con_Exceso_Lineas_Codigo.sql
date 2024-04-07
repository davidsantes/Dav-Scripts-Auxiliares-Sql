/**
 * Este script SQL se utiliza para identificar procedimientos almacenados y funciones en la base de datos "EjemploScriptsSQL" que exceden un número máximo de líneas de código.
 * 
 * La consulta calcula el número de líneas de código de cada procedimiento almacenado y función y compara este número con un valor máximo definido en la variable @numeroMaxLineasCodigo.
 * 
 * Para cada objeto que excede el número máximo de líneas de código, se devuelve información sobre el nombre del objeto, el tipo de objeto y el tipo de problema.
 * 
 * La consulta utiliza las vistas del sistema sysobjects y syscomments para obtener información sobre los procedimientos almacenados y funciones, así como sus definiciones de código.
 * 
 * El resultado se ordena por el número total de líneas de código en orden descendente.
 */

USE EjemploScriptsSQL
GO

DECLARE @numeroMaxLineasCodigo INT
SET @numeroMaxLineasCodigo = 200

SELECT
	t.sp_name AS Item
	, t.type_desc AS TipoItem
	, 'Objetos con exceso de líneas de código' As TipoProblema	
	, sum(t.lines_of_code) - 1 AS TotalLineasCodigo
FROM
	(
		select o.name as sp_name, 
		(len(c.text) - len(replace(c.text, char(10), ''))) as lines_of_code,
		case when o.xtype = 'P' then 'Procedimiento almacenado'
		when o.xtype in ('FN', 'IF', 'TF') then 'Funcion'
		end as type_desc
		from sysobjects o
		inner join syscomments c
		on c.id = o.id
		where o.xtype in ('P', 'FN', 'IF', 'TF')
		and o.category = 0
		and o.name not in ('fn_diagramobjects', 'sp_alterdiagram', 'sp_creatediagram', 'sp_dropdiagram', 'sp_helpdiagramdefinition', 'sp_helpdiagrams', 'sp_renamediagram', 'sp_upgraddiagrams', 'sysdiagrams')
	) t
GROUP BY t.sp_name, t.type_desc
HAVING SUM(t.lines_of_code) - 1 >= @numeroMaxLineasCodigo
ORDER BY TotalLineasCodigo DESC