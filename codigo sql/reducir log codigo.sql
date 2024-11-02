USE KPROYECTAR;
GO
-- cambiamos el recovery a nodo simple
ALTER DATABASE KPROYECTAR
SET RECOVERY SIMPLE;
GO
-- reducirmos el archivo log a 1 MB.
DBCC SHRINKFILE (KrystalosBASE_Log, 1);
GO
-- devolvemos el nivel de recovery a full
ALTER DATABASE KPROYECTAR
SET RECOVERY FULL;
GO

SELECT * FROM sys.database_files