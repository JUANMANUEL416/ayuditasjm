EXEC sp_configure 'show advanced options', 1
RECONFIGURE
go
EXEC sp_configure 'xp_cmdshell', 1
RECONFIGURE
go


-- Para ver la configuración (1=On)
EXEC sp_configure 'Ole Automation Procedures';  

-- Si nos devuelve un error es por que no está habilitado el acceso a las
-- configuraciones avanzadas. Para habilitarlo:
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

-- Para configurar los Ole Automation Procedures
EXEC sp_configure 'Ole Automation Procedures', 1;  

EXEC sp_configure filestream_access_level, 2  
RECONFIGURE  