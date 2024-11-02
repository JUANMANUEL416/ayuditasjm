--
-- INSTRUCCION PARA SABER CUALES ESTAN MAL
--
SELECT FCXCD.N_FACTURA, FCXCD.SALDONETO, X.SALDO_FCXCDV
FROM   FCXCD INNER JOIN (
                           SELECT N_FACTURA, SUM(SALDONETO) AS SALDO_FCXCDV
                           FROM   FCXCDV 
                           --WHERE  CNSCXC = '0100001846'
                           GROUP BY N_FACTURA
                         ) X ON FCXCD.N_FACTURA = X.N_FACTURA
WHERE  FCXCD.SALDONETO <> X.SALDO_FCXCDV                     
--AND    FCXCD.CNSCXC = '0100001846'
/***********************************************************************/
/*      SACAR COPIA DE FCXCDV POR SI LAS DUDAS*/
/***********************************************************************/
SELECT * INTO FCXCDV_ORI1 FROM FCXCDV   
/***********************************************************************/
-- CAMBIAR EL ESTADO EN FCXCDV
/***********************************************************************/
BEGIN TRAN
UPDATE FCXCDV SET TIPO = 'F'
FROM   FCXCDV INNER JOIN ( 
                           SELECT * 
                           FROM   FCXCDV 
                           WHERE  TIPO = 'G'
                           AND    N_FACTURA NOT IN  (SELECT N_FACTURA FROM FGLO)                                       
                         ) X ON FCXCDV.CNSCXC    = X.CNSCXC
                            AND FCXCDV.N_FACTURA = X.N_FACTURA
COMMIT
/***********************************************************************/
/*                    RELIQUIDAR TODAS LAS CXC                         */
/***********************************************************************/
   DECLARE @CNSCXC1 VARCHAR(20)
   DECLARE G_C CURSOR FOR    
   SELECT CNSCXC FROM FCXC 
   OPEN G_C    
   FETCH NEXT FROM G_C    
   INTO @CNSCXC1
   WHILE @@FETCH_STATUS = 0    
   BEGIN       
      EXEC SPK_RELIQUIDACXCQX @CNSCXC1              
      FETCH NEXT FROM G_C
      INTO @CNSCXC1
   END
   CLOSE G_C    
   DEALLOCATE G_C
   
   