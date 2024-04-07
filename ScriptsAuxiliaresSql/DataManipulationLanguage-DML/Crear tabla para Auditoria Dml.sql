USE [EjemploScriptsSQL]
GO
/****** Object:  Table [dbo].[Auditorias_DML]    Script Date: 07/04/2024 19:15:21 ******/
DROP TABLE IF EXISTS [dbo].[Auditorias_DML]
GO
/****** Object:  Table [dbo].[Auditorias_DML]    Script Date: 07/04/2024 19:15:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Auditorias_DML](
	[Id] [uniqueidentifier] NOT NULL,
	[TableName] [nvarchar](255) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[KeyValues] [nvarchar](4000) NULL,
	[NewValues] [nvarchar](4000) NULL,
 CONSTRAINT [PK_Auditorias_DML] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- INSERT INTO Auditorias_DML con valores aleatorios
INSERT INTO Auditorias_DML (Id, TableName, DateTime, KeyValues, NewValues)
VALUES 
    (NEWID(), 'Tabla1', GETDATE(), 'Clave1', 'NuevoValor1'),
    (NEWID(), 'Tabla2', GETDATE(), 'Clave2', 'NuevoValor2'),
    (NEWID(), 'Tabla3', GETDATE(), 'Clave3', 'NuevoValor3'),
	(NEWID(), 'Tabla4', GETDATE(), 'Clave4', 'NuevoValor4'),
	(NEWID(), 'Tabla5', GETDATE(), 'Clave5', 'NuevoValor5'),
	(NEWID(), 'Tabla6', GETDATE(), 'Clave6', 'NuevoValor6'),
	(NEWID(), 'Tabla7', GETDATE(), 'Clave7', 'NuevoValor7'),
	(NEWID(), 'Tabla8', GETDATE(), 'Clave8', 'NuevoValor8');