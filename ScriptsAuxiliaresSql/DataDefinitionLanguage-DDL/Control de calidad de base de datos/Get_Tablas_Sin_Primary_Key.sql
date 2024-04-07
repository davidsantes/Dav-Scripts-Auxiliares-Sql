USE EjemploScriptsSQL
GO

SELECT
	AllTables.Name As Item
	, 'Tabla' As TipoItem
	, 'Tablas sin primary key' As TipoProblema
FROM	(
		SELECT	Name, id, uid
		From	sysobjects
		WHERE	xtype = 'U'
		) AS AllTables
		INNER JOIN sysusers su
			On AllTables.uid = su.uid
		LEFT JOIN (
			SELECT parent_obj
			From sysobjects
			WHERE  xtype = 'PK'
			) AS PrimaryKeys
			ON AllTables.id = PrimaryKeys.parent_obj
WHERE	
	PrimaryKeys.parent_obj Is Null
ORDER BY Item