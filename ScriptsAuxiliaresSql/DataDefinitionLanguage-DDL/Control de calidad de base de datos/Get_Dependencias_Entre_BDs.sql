/**
 * Este script SQL se utiliza para detectar las dependencias de la base de datos actual en otras bases de datos.
 * 
 * El script crea una tabla temporal llamada #DbDependencies para almacenar información sobre las dependencias encontradas.
 * 
 * Utiliza un cursor para recorrer todas las bases de datos a las que el usuario actual tiene acceso, excluyendo las bases de datos del sistema.
 * 
 * Por cada base de datos, comprueba si el usuario tiene permisos para acceder a la vista del sistema sys.sql_expression_dependencies,
 * que almacena información sobre las dependencias de expresiones en las bases de datos.
 * 
 * Si el usuario tiene permisos, el script busca las dependencias de la base de datos actual en otras bases de datos,
 * insertando los resultados en la tabla #DbDependencies.
 * 
 * Finalmente, muestra los resultados de las dependencias detectadas y limpia la tabla temporal #DbDependencies.
 */

IF OBJECT_ID('tempdb..#DbDependencies') IS NOT NULL
	DROP TABLE #DbDependencies;

CREATE TABLE #DbDependencies (
	ReferencingDatabase VARCHAR(128),
    ReferencingSchema VARCHAR(128),
    ReferencingObjectName VARCHAR(128),
    ReferencingObjectType VARCHAR(128),
	ReferencedDatabase VARCHAR(128),
	ReferencedSchema VARCHAR(128),
	ReferencedObjectName VARCHAR(128)
)

--Cursor para recorrer las BDs en las que el usuario actual tiene permisos.
DECLARE db_cursor CURSOR FOR
	SELECT 
		name 
	FROM 
		sys.databases Databases 
	WHERE 
		HAS_DBACCESS(Databases.name) = 1 AND
		Databases.Name NOT IN ('master', 'tempdb', 'model', 'msdb')

DECLARE @ReferencingDatabaseName NVARCHAR(128)
OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @ReferencingDatabaseName

WHILE @@FETCH_STATUS = 0
BEGIN
		DECLARE @SQL NVARCHAR(MAX)

		SET @SQL = '
			USE ' + QUOTENAME(@ReferencingDatabaseName) + ';

			DECLARE @HasPermission INT;
			SET @HasPermission = Permissions(OBJECT_ID(''sys.sql_expression_dependencies''))
			IF @HasPermission <> 0
            BEGIN
				PRINT ''Comprobando dependencias sobre la BD ' + @ReferencingDatabaseName + '''
				INSERT INTO #DbDependencies
					SELECT
						ReferencingDatabase = '''+@ReferencingDatabaseName+''',
						ReferencingSchema = SCHEMA_NAME(ReferencingObjects.schema_id),
						ReferencingObjectName = ReferencingObjects.name,
						ReferencingObjectType = ReferencingObjects.type_desc,
						ReferencedDatabase = ExpressionDependencies.referenced_database_name,
						ReferencedSchema = ExpressionDependencies.referenced_schema_name,
						ReferencedObjectName = ExpressionDependencies.referenced_entity_name
					FROM
						sys.sql_expression_dependencies ExpressionDependencies
						INNER JOIN sys.objects AS ReferencingObjects ON ExpressionDependencies.referencing_id = ReferencingObjects.object_id
						WHERE ExpressionDependencies.referenced_database_name IS NOT NULL
						AND ExpressionDependencies.referenced_database_name <> ''' + @ReferencingDatabaseName + '''
				END
        '
		EXEC sp_executesql @SQL

        FETCH NEXT FROM db_cursor INTO @ReferencingDatabaseName
END

CLOSE db_cursor
DEALLOCATE db_cursor

SELECT * FROM #DbDependencies

DROP TABLE #DbDependencies