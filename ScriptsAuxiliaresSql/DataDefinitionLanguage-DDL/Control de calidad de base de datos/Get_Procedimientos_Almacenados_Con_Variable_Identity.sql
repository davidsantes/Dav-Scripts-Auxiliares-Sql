/**
 * Este script SQL se utiliza para identificar procedimientos almacenados en la base de datos "EjemploScriptsSQL" que hacen uso de la variable @@identity.
 * 
 * La consulta busca procedimientos almacenados que contienen referencias a @@identity en su definición de código.
 * 
 * Para cada procedimiento almacenado identificado, se devuelve información sobre el nombre del procedimiento almacenado, el tipo de problema y el tipo de objeto.
 * 
 * La consulta utiliza las vistas del sistema sysobjects y syscomments para obtener información sobre los procedimientos almacenados y sus definiciones de código.
 * 
 * El resultado se ordena por el nombre del procedimiento almacenado.
 */

USE EjemploScriptsSQL
GO

SELECT  DISTINCT
	Name As Item
	, 'Procedimiento almacenado' As TipoItem
	, 'Elementos con @@identity' As TipoProblema

FROM    (
		SELECT  s.Name, c.text, SCHEMA_NAME(s.uid) As SchemaName
		FROM	sysobjects s
				INNER JOIN syscomments c
				    ON  s.id = c.id
				    And s.xtype = 'P'
		WHERE   OBJECTPROPERTY(s.id, N'IsMSShipped') = 0
				And c.text COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI Like '%@@identity%'

		UNION ALL

		SELECT	OBJECT_NAME(a.id), LeftText + RightText, SCHEMA_NAME(s.uid) As SchemaName
		FROM	sysobjects s
				INNER JOIN (
				    SELECT	id, RIGHT(text, 10) AS LeftText, ColId
				    FROM      syscomments
				    ) AS a
				    ON  s.id = a.id
				    And OBJECTPROPERTY(s.ID, N'IsMSShipped') = 0
				    And s.xtype = 'P'
				INNER JOIN (
				    SELECT	id, LEFT(text, 10) AS RightText, ColId
					FROM      syscomments
					) AS b
				    ON  a.id = b.id
				    and a.ColId = a.ColId - 1
		WHERE   LeftText COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI + RightText COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI LIKE '%@@identity%'
		) AS a
WHERE	Replace(text, ' ','') COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI Like '%@@identity%'
	AND name Not In('sp_helpdiagrams','sp_upgraddiagrams','sp_creatediagram')
ORDER BY Item