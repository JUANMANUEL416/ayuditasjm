DECLARE 
 @CNSMOV            VARCHAR(20),   
 @USUARIO           VARCHAR(12),  
 @SYS_COMPUTERNAME  VARCHAR(254),  
 @COMPANIA          VARCHAR(2),   
 @SEDE              VARCHAR(5),  
 @NROCOMPROBANTE    VARCHAR(20),
 @ANO               VARCHAR(4),
 @MES               INT
 


   DECLARE MCP_RECONSTRUYE CURSOR FOR
   --SELECT REFERENCIA1,USUARIO,HOST_NAME(),COMPANIA,IDSEDE,NROCOMPROBANTE FROM MCP
   --WHERE PROCEDENCIA='INV'  AND ESTADO=0 AND COALESCE(ANULADO,0)<>1  AND ANO='201' AND MES<=7
   --GROUP BY REFERENCIA1,USUARIO,COMPANIA,NROCOMPROBANTE,IDSEDE
	SELECT CNSMOV,USUARIOCONF,SYS_ComputerName,'01',LEFT(CNSMOV,2),NROCOMPROBANTE FROM IMOV
	WHERE COALESCE(CONTABILIZADA,0)=0 AND  COALESCE(NROCOMPROBANTE,'')='' AND FECHAMOV>='01/08/2015' AND FECHAMOV<'01/09/2015'
   AND SECONTABILIZA=1
   AND ESTADO=1
	GROUP BY  CNSMOV,USUARIOCONF,SYS_ComputerName,LEFT(CNSMOV,2),NROCOMPROBANTE
   OPEN MCP_RECONSTRUYE    
   FETCH NEXT FROM MCP_RECONSTRUYE    
   INTO @CNSMOV,@USUARIO,@SYS_COMPUTERNAME,@COMPANIA,@SEDE,@NROCOMPROBANTE
   WHILE @@FETCH_STATUS = 0    
   BEGIN
       PRINT 'EMPEZANDO....'+@CNSMOV
       EXEC SPK_NC_CONTAB_INV  @CNSMOV,@USUARIO,@SYS_COMPUTERNAME,@COMPANIA,@SEDE,@NROCOMPROBANTE  
   FETCH NEXT FROM MCP_RECONSTRUYE    
   INTO @CNSMOV,@USUARIO,@SYS_COMPUTERNAME,@COMPANIA,@SEDE,@NROCOMPROBANTE
   END
   CLOSE MCP_RECONSTRUYE
   DEALLOCATE MCP_RECONSTRUYE
   
   
 
