/*
Este script SQL crea una tabla llamada "Auditorias_DDL" en la base de datos "EjemploScriptsSQL" para registrar eventos de nivel de base de datos, como creación, modificación o eliminación de objetos.

Además, crea un disparador (trigger) llamado "Trigger_Auditorias_DDL" que se activa en eventos de nivel de base de datos (DDL_DATABASE_LEVEL_EVENTS) y registra la información relevante en la tabla "Auditorias_DDL".
*/

USE [EjemploScriptsSQL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Auditorias_DDL](
	[EventDate] [datetime] NOT NULL,
	[EventType] [nvarchar](64) NULL,
	[EventDDL] [nvarchar](max) NULL,
	[DatabaseName] [nvarchar](255) NULL,
	[SchemaName] [nvarchar](255) NULL,
	[ObjectName] [nvarchar](255) NULL,
	[ProgramName] [nvarchar](255) NULL,
	[LoginName] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[Auditorias_DDL] ADD  DEFAULT (getdate()) FOR [EventDate]
GO

CREATE TRIGGER [Trigger_Auditorias_DDL]
    ON DATABASE
    FOR DDL_DATABASE_LEVEL_EVENTS
AS
BEGIN
    SET NOCOUNT ON;
       SET ANSI_PADDING ON;
    DECLARE
        @EventData XML = EVENTDATA();
 
    DECLARE
        @ip VARCHAR(32) = ''
 
    BEGIN TRY
        BEGIN TRAN nombreTransaccion
 
            INSERT dbo.Auditorias_DDL
            (
                EventType,
                EventDDL,
                DatabaseName,
                SchemaName,
                ObjectName,
                ProgramName,
                LoginName
            )
            SELECT
                @EventData.value('(/EVENT_INSTANCE/EventType)[1]',   'NVARCHAR(100)'),  --EventType
                @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'NVARCHAR(MAX)'),  --EventDDL
                DB_NAME(),                                                              --DatabaseName
                @EventData.value('(/EVENT_INSTANCE/SchemaName)[1]',  'NVARCHAR(255)'),  --SchemaName
                @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]',  'NVARCHAR(255)'),  --ObjectName
                PROGRAM_NAME(),                                                         --ProgramName
                SUSER_SNAME();                                                          --LoginName
 
        COMMIT TRAN nombreTransaccion
    END TRY
 
    BEGIN CATCH
        PRINT N'Error a la hora de insertar en la tabla Auditorias_DDL.';
        ROLLBACK TRAN nombreTransaccion
    END CATCH
 
END
 
GO
 
ENABLE TRIGGER [Trigger_Auditorias_DDL] ON DATABASE
GO