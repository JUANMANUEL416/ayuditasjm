DROP PROC SPKH_ARREGLA_COB   
go
CREATE PROC DBO.SPKH_ARREGLA_COB   
@N_FACTURA VARCHAR(16)  
AS  
DECLARE @VFTRD  DECIMAL(18,6)  
DECLARE @VFTR   DECIMAL(18,6)  
DECLARE @VHPRED DECIMAL(18,6)  
DECLARE @CONTABILIZADA  SMALLINT  
DECLARE @NROCOMPROBANTE VARCHAR(20)  
DECLARE @NOADMISION     VARCHAR(16)  
DECLARE @VECES          INT  
BEGIN  
    SELECT @VFTRD = SUM(FTRD.VALOR* FTRD.CANTIDAD)
    FROM   FTRD 
    WHERE  FTRD.N_FACTURA = @N_FACTURA  

    SELECT @VHPRED = SUM(HPRED.VALOR* HPRED.CANTIDAD )
    FROM   HPRED
    WHERE  HPRED.N_FACTURA = @N_FACTURA  
    
    PRINT '@VFTRD='+CAST(@VFTRD AS VARCHAR(20))+ ' ----  @VHPRED='+CAST(@VHPRED AS VARCHAR(20))  

    IF @VFTRD = @VHPRED  
    BEGIN  
       PRINT 'FTRD = HPRED'  
       SELECT @VFTR = ROUND(VR_TOTAL,2) , @CONTABILIZADA = CONTABILIZADA, @NROCOMPROBANTE = NROCOMPROBANTE, @NOADMISION = NOREFERENCIA  
       FROM FTR WHERE N_FACTURA = @N_FACTURA  
       PRINT '@VFTR='+CAST(@VFTR AS VARCHAR(20))  
       IF @VFTR <> @VFTRD  
       BEGIN  
          PRINT 'FTR DIF FTRD'  
          UPDATE FTR SET VR_TOTAL = @VFTRD WHERE N_FACTURA = @N_FACTURA  
          IF @CONTABILIZADA = 1  
          BEGIN  
             PRINT 'CONTABILIZADA EN COMPROBANTE='+@NROCOMPROBANTE  
          END  
          SELECT @VECES = ISNULL(COUNT(*),0) FROM IMPFTR WHERE NOADMISION = @NOADMISION  
          IF @VECES = 0  
          BEGIN  
             EXEC DBO.SPK_FACTURA_ASIS_HOJA @NOADMISION, 'XX', '01', '01', 'IX', 'IX', @N_FACTURA, 1, 0, NULL, 'G'  
             UPDATE HADMF SET ITFC = 1 WHERE NOADMISION = @NOADMISION  
             PRINT 'CREE PREFACTURA'  
          END  
       END  
       ELSE  
       BEGIN  
          PRINT 'FTR ESTABA CORRECTA'  
       END    
    END  
    ELSE
    BEGIN
       SELECT HPRED.NOPRESTACION, HPRED.NOITEM, FTRD.CANTIDAD * FTRD.VALOR AS VR_FTR, HPRED.VALOR * HPRED.CANTIDAD AS VR_HPRED
       FROM   FTRD INNER JOIN HPRED ON FTRD.NOPRESTACION = HPRED.NOPRESTACION
                                   AND FTRD.NOITEM       = HPRED.NOITEM
       WHERE  FTRD.N_FACTURA = @N_FACTURA
       AND    (FTRD.CANTIDAD * FTRD.VALOR) <>  ( HPRED.VALOR * HPRED.CANTIDAD )
    END
END  
go

EXEC SPKH_ARREGLA_COB  'H_09534' 

SELECT 22 * 13
