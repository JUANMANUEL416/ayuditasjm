--DIFERENCIA 
DECLARE @N_FACTURA VARCHAR(20)
DECLARE @CBTE   VARCHAR(20)
DECLARE @MES    INT
DECLARE @COMPROBANTE VARCHAR(4)
DECLARE @COMPANIA    VARCHAR(2)
DECLARE @ANO         VARCHAR(4)


SET @COMPANIA='01'
SET @COMPROBANTE='06'
SET @ANO='2013'
SET @MES=1

DECLARE @DIFERENCIA DECIMAL(14,2)
DECLARE CXC_CURSOR CURSOR FOR
SELECT NROCOMPROBANTE FROM MCP 
WHERE COMPROBANTE = @COMPROBANTE AND COMPANIA=@COMPANIA
AND MES =@MES AND ANO = @ANO  AND TOTALDEBITO <> TOTALCREDITO 
OPEN CXC_CURSOR
FETCH NEXT FROM CXC_CURSOR
INTO @N_FACTURA
WHILE @@FETCH_STATUS = 0
BEGIN
		 SELECT @DIFERENCIA = TOTALDEBITO - TOTALCREDITO 
		 FROM  MCP 
		 WHERE COMPROBANTE = @COMPROBANTE AND COMPANIA=@COMPANIA
   AND MES =@MES AND ANO = @ANO
   AND NROCOMPROBANTE = @N_FACTURA
		 IF @DIFERENCIA < 0
		 BEGIN
		    SELECT @CBTE = MIN( MCH.NROASIENTO) FROM MCH WHERE TIPO = 'DB'
		    AND COMPANIA =@COMPANIA AND MCH.NROCOMPROBANTE = @N_FACTURA
		 
 	    UPDATE  MCH
		    SET MCH.VALOR = MCH.VALOR + (@DIFERENCIA * -1)
		    WHERE MCH.COMPANIA =@COMPANIA 
      AND MCH.NROASIENTO      IN (@CBTE)
		 END
		 IF @DIFERENCIA > 0
		 BEGIN
		    SELECT @CBTE = MIN(MCH.NROASIENTO) FROM MCH WHERE TIPO = 'CR'
		    AND COMPANIA =@COMPANIA AND MCH.NROCOMPROBANTE = @N_FACTURA
		
		    UPDATE  MCH
		    SET MCH.VALOR = MCH.VALOR + (@DIFERENCIA)
		    WHERE MCH.COMPANIA =@COMPANIA 
      AND MCH.NROASIENTO      IN (@CBTE)
		 END
		 EXEC SPK_SUMA_DBCR @N_FACTURA
		 FETCH NEXT FROM CXC_CURSOR
	  INTO @N_FACTURA
END
CLOSE CXC_CURSOR
DEALLOCATE CXC_CURSOR

