DECLARE objects_cursor CURSOR LOCAL FAST_FORWARD READ_ONLY for 

      SELECT s.name + '.' + o.name 
      from   sys.schemas s INNER JOIN sys.objects o ON o.schema_id = s.schema_id 
      WHERE  /*o.type = 'S' or --Tablas de sistema */
            o.type = 'U' --or --Tablas de usuario 
            /*o.type = 'V' or --Vistas (solo las indexadas devuelven tamaño) */
            /*o.type = 'SQ' or --Cola de servicio */
            /*o.type = 'IT' -- Tablas internas usadas p.e. por el Service Broker o los indices XML*/

CREATE TABLE #results 
      (name SYSNAME, rows CHAR(11), 
      reserved VARCHAR(18), data VARCHAR(18), 
      index_size VARCHAR(18),Unused VARCHAR(18)) 
--Recorremos el cursor obteniendo la información de espacio ocupado 

DECLARE @object_name AS SYSNAME 
OPEN objects_cursor 
FETCH NEXT FROM objects_cursor 
INTO @object_name; 
WHILE @@FETCH_STATUS = 0 
BEGIN 
      INSERT INTO #results 
            EXEC sp_spaceused @object_name 
      FETCH NEXT FROM objects_cursor 
            INTO @object_name;     
END; 
CLOSE objects_cursor; 
DEALLOCATE objects_cursor; 

-- Quitamos "KB" para poder ordenar 

UPDATE 
  #results 
SET 
  reserved = LEFT(reserved,LEN(reserved)-3),
  data = LEFT(data,LEN(data)-3),
  index_size = LEFT(index_size,LEN(index_size)-3),
  Unused = LEFT(Unused,LEN(Unused)-3) 
--Ordenamos la información por el tamaño ocupado 
SELECT 
  Name,
  reserved AS [Tamaño en Disco (KB)],
  data AS [Datos (KB)],
  index_size AS [Indices (KB)],
  Unused AS [No usado (KB)],
  Rows AS Filas FROM #results 
ORDER BY 
  CONVERT(bigint, reserved) DESC 

--Eliminar la tabla temporal 
DROP TABLE #results 

/*
SELECT MAX(CNS) FROM RPDX2 WHERE LEFT(CNS,2) = '01'
DELETE RPDX2 WHERE CNS >= '0100000000' AND CNS < '0101050000'
0101060002 -- 0101059290

--AUT
--AUTD

HCASV	4302912
*/
