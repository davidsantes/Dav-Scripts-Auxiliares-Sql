USE EjemploScriptsSQL
GO

SELECT DISTINCT 
	SchemaName + '.' + Name As Item
	, 'Procedimiento almacenado' As TipoItem
	, 'Elementos con SET ROWCOUNT' As TipoProblema	
	FROM    (
				SELECT	s.Name, c.text, SCHEMA_NAME(s.uid) As SchemaName
				FROM	sysobjects s
						INNER JOIN syscomments c
							ON  s.id = c.id
							And s.xtype = 'P'
				WHERE   OBJECTPROPERTY(s.id, N'IsMSShipped') = 0
						AND c.Text COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI LIKE '%SET ROWCOUNT%'

				UNION ALL

				SELECT	OBJECT_NAME(a.id), LeftText + RightText, SCHEMA_NAME(s.uid) As SchemaName
				FROM	sysobjects s
						INNER JOIN (
							SELECT	id, RIGHT(text, 10) AS LeftText, ColId
							FROM	syscomments
						) AS a
						ON  s.id = a.id
						AND OBJECTPROPERTY(s.ID, N'IsMSShipped') = 0
						AND s.xtype = 'P'
						INNER JOIN (
							SELECT	id, LEFT(text, 10) AS RightText, ColId
							FROM	syscomments
						) AS b
						ON  a.id = b.id
						AND a.ColId = b.ColId - 1
				WHERE	LeftText COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI + RightText COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI LIKE '%SET ROWCOUNT%'
				) AS a
	WHERE	REPLACE(text, ' ','') COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI LIKE '%SETROWCOUNT%'
	ORDER BY SchemaName + '.' + Name