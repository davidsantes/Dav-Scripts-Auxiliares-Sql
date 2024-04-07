/**
 * Este script SQL se utiliza para identificar y cambiar manualmente el propietario de un diagrama en la base de datos "EjemploScriptsSQL".
 * 
 * Asegúrate de reemplazar "EjemploScriptsSQL" con el nombre de tu base de datos y "1" con el nuevo principal_id que deseas asignar al diagrama.
 */
USE EjemploScriptsSQL;
GO

-- Para identificar el ID del diagrama, su nombre y propietario.
SELECT * FROM dbo.sysdiagrams;

-- Para cambiar manualmente el propietario de un diagrama.
UPDATE dbo.sysdiagrams SET principal_id = 1 WHERE diagram_id = 1;