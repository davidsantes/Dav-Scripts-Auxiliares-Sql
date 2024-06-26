USE EjemploScriptsSQL
GO

SELECT DISTINCT	
	so.name As Item
	, 'Procedimiento almacenado' As TipoItem
	, 'Elementos con SELECT*' As TipoProblema		
FROM   SYSCOMMENTS sc
	   Inner Join SYSOBJECTS so
	     On  sc.id = so.id
		 And so.xtype = 'P'
	   Inner join SYSUSERS su
		 On so.uid = su.uid
WHERE  Replace(sc.text, ' ', '') COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI Like '%SELECT*%'
       And ObjectProperty(sc.Id, N'IsMSSHIPPED') = 0
ORDER BY Item