/**
 * Este script SQL se utiliza para identificar procedimientos almacenados en la base de datos "EjemploScriptsSQL" que no contienen la instrucción SET NOCOUNT ON.
 * 
 * La consulta busca procedimientos almacenados que no contienen la cadena 'SET NOCOUNT ON' en su definición de código.
 * 
 * Para cada procedimiento almacenado identificado, se devuelve información sobre el nombre del procedimiento almacenado, el tipo de problema y el tipo de objeto.
 * 
 * La consulta utiliza las vistas del sistema sysobjects y syscomments para obtener información sobre los procedimientos almacenados y sus definiciones de código.
 * 
 * El resultado se ordena por el nombre del procedimiento almacenado.
 */
USE EjemploScriptsSQL
GO

SELECT DISTINCT	
	so.name As Item
	, 'Procedimiento almacenado' As TipoItem
	, 'Elementos sin SET NOCOUNT ON' As TipoProblema
From	sysobjects so
		LEFT JOIN (
			SELECT	id
			FROM	syscomments
			WHERE	text COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI LIKE '%SET NOCOUNT ON%'
		) As GoodProcs	
			On so.id = GoodProcs.id
Where	so.xtype = 'P'
		And GoodProcs.id Is NULL
		AND so.name Not In('sp_helpdiagrams','sp_upgraddiagrams')
Order BY Item