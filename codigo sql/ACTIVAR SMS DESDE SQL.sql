/* --Asignar permisos a un grupo del dominio para consumir un servicio desde SQL Server
	Opcion 1:
	sp_configure 'show advanced options', 1;  
	GO  
	RECONFIGURE;  
	GO  
	sp_configure 'Ole Automation Procedures', 1;  
	GO  
	RECONFIGURE;  
	GO  

	--Opcion 2 (Si no funciona la anterior)
	use [master]
	GO
	GRANT EXECUTE ON [sys].[sp_OACreate] TO [CLD\KRYSTALOS]
	GO
	GRANT EXECUTE ON [sys].[sp_OADestroy] TO [CLD\KRYSTALOS]
	GO
	GRANT EXECUTE ON [sys].[sp_OAGetErrorInfo] TO [CLD\KRYSTALOS]
	GO
	GRANT EXECUTE ON [sys].[sp_OAGetProperty] TO [CLD\KRYSTALOS]
	GO
	GRANT EXECUTE ON [sys].[sp_OAMethod] TO [CLD\KRYSTALOS]
	GO
	GRANT EXECUTE ON [sys].[sp_OAStop] TO [CLD\KRYSTALOS]
	GO
	GRANT EXECUTE ON [sys].[sp_OASetProperty] TO [CLD\KRYSTALOS]
	*/