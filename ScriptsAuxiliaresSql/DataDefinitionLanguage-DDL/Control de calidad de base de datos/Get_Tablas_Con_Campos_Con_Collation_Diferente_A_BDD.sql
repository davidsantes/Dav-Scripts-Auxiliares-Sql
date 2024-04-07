USE EjemploScriptsSQL
GO

SELECT
	C.TABLE_NAME AS Item
	, 'Tabla' As TipoItem
	, 'Tablas con campos con collation diferente a la de la base de datos' As TipoProblema
	, C.COLUMN_NAME As NombreColumna
FROM	
	INFORMATION_SCHEMA.COLUMNS C
	INNER JOIN INFORMATION_SCHEMA.TABLES T ON C.Table_Name = T.Table_Name 
WHERE	
	T.Table_Type = 'BASE TABLE'          
	AND COLLATION_NAME <> convert(VarChar(100), DATABASEPROPERTYEX(db_name(), 'Collation'))
	AND COLUMNPROPERTY(OBJECT_ID(C.TABLE_NAME), COLUMN_NAME, 'IsComputed') = 0 
Order By Item