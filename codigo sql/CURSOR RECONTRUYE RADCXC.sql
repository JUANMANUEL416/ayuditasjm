DECLARE 
 @CNSMOV            VARCHAR(20),   
 @USUARIO           VARCHAR(12),  
 @SYS_COMPUTERNAME  VARCHAR(254),  
 @COMPANIA          VARCHAR(2),   
 @SEDE              VARCHAR(5),  
 @NROCOMPROBANTE    VARCHAR(20)

 


   DECLARE MCP_RECONSTRUYE CURSOR FOR
   SELECT REFERENCIA1,'01','01',USUARIO,'SOPORTE',NROCOMPROBANTE  FROM MCP WHERE PROCEDENCIA='RAD CXC' AND ESTADO=0
   OPEN MCP_RECONSTRUYE    
   FETCH NEXT FROM MCP_RECONSTRUYE    
   INTO @CNSMOV,@COMPANIA,@SEDE,@USUARIO,@SYS_COMPUTERNAME,@NROCOMPROBANTE
   WHILE @@FETCH_STATUS = 0    
   BEGIN
       PRINT 'EMPEZANDO....'+@CNSMOV
       EXEC SPK_CONTAB_RADICACXC_1  @CNSMOV,@COMPANIA,@SEDE,@USUARIO,@SYS_COMPUTERNAME,@NROCOMPROBANTE 
       EXEC SPK_REVISAR_COMPROBANTE '01',@NROCOMPROBANTE
       EXEC SPK_SUMA_DBCR @NROCOMPROBANTE    
   FETCH NEXT FROM MCP_RECONSTRUYE    
   INTO @CNSMOV,@COMPANIA,@SEDE,@USUARIO,@SYS_COMPUTERNAME,@NROCOMPROBANTE
   END
   CLOSE MCP_RECONSTRUYE
   DEALLOCATE MCP_RECONSTRUYE
   
   
 