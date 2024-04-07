USE EjemploScriptsSQL
GO

SELECT  DISTINCT
		O.Name AS Item
		, 'Tabla' As TipoItem
		, 'Uso de campos no recomendados' AS TipoProblema	 
        , col.name AS NombreColumna
        , systypes.name AS TipoColumna
From    syscolumns col 
        Inner Join sysobjects O On col.id = O.id
        Inner join systypes On col.xtype = systypes.xtype
Where   O.Type = 'U'
        And ObjectProperty(o.ID, N'IsMSShipped') = 0
        And systypes.name In ('text','ntext','nvarchar','nchar','image','float','real')
Order By Item, NombreColumna