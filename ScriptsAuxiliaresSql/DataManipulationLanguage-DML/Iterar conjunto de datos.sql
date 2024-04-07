/**
 * Este script SQL se utiliza para iterar sobre los datos de una tabla temporal en la base de datos "EjemploScriptsSQL" y realizar una acci�n espec�fica con cada conjunto de datos.
 * 
 * El script define una tabla temporal llamada @TablaConDatosParaIterar para almacenar los datos que se iterar�n.
 * 
 * Puede ser �til para temas de soporte (actualizaci�n de datos), o exportaciones de datos muy complejas.
 */
USE EjemploScriptsSQL
GO

DECLARE @IdAuditoria [uniqueidentifier]
DECLARE @TableName nvarchar(255)
DECLARE @DateTime datetime
DECLARE @KeyValues nvarchar(4000)
DECLARE @NewValues nvarchar(4000)

DECLARE @TablaConDatosParaIterar TABLE
(
	ID INT Identity(1,1),
	[IdAuditoria] [uniqueidentifier] NOT NULL,
	[TableName] [nvarchar](255) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[KeyValues] [nvarchar](4000) NULL,
	[NewValues] [nvarchar](4000) NULL
)

insert into @TablaConDatosParaIterar (IdAuditoria, TableName, DateTime, KeyValues, NewValues)
select Id, TableName, DateTime, KeyValues, NewValues
from Auditorias_DML

DECLARE @ContadorIndex INT
SET @ContadorIndex = 1  

DECLARE @NumeroTotalRegistros INT
SELECT @NumeroTotalRegistros = COUNT(*) FROM @TablaConDatosParaIterar


-- Hacemos el Loop
WHILE @ContadorIndex <= @NumeroTotalRegistros
BEGIN
	-- Imprimimos el valor
    Print @ContadorIndex	

	---------------------------------- Preparaci�n de valores ------------------------
    SELECT 
		@IdAuditoria = t.IdAuditoria
		, @TableName = t.TableName
		, @DateTime = t.DateTime
		, @KeyValues = t.KeyValues
		, @NewValues = t.NewValues
    FROM @TablaConDatosParaIterar t
    WHERE t.ID = @ContadorIndex
 	----------------------------------------------------------------------------------

	---------------------------------- Acci�n a realizar -----------------------------
	
	Print 'Aqu� podr�amos hacer algo con los datos que hemos iterado'

	----------------------------------------------------------------------------------

    SET @ContadorIndex = @ContadorIndex + 1
 
END