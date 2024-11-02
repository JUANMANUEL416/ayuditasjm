CREATE TABLE #FNOTD(CNSFNOT     VARCHAR(20)   COLLATE database_default, 
                             CLASE       VARCHAR(1)    COLLATE database_default, 
                             ITEM        SMALLINT      IDENTITY, 
                             TIPO        VARCHAR(1)    COLLATE database_default, 
                             IDSERVICIO  VARCHAR(20)   COLLATE database_default, 
                             DESCRIPCION VARCHAR(512)  COLLATE database_default, 
                             CANTIDAD    INT, 
                             VR_UNITARIO FLOAT , 
                             VR_TOTAL    FLOAT, 
                             COMPANIA    VARCHAR(2)    COLLATE database_default, 
                             USUARIO     VARCHAR(12)   COLLATE database_default, 
                             OBSERVACION VARCHAR(2048) COLLATE database_default,
                             IDAREA      VARCHAR(10)   COLLATE database_default,
                             CCOSTO      VARCHAR(20)   COLLATE database_default,
                             PREFIJO     VARCHAR(10)   COLLATE database_default,
                             N_CUOTA     SMALLINT, 
                             N_FACTURA   VARCHAR(16)   COLLATE database_default)

INSERT INTO #FNOTD(CNSFNOT, CLASE, TIPO, IDSERVICIO, DESCRIPCION, CANTIDAD,
                               VR_UNITARIO, VR_TOTAL, COMPANIA, USUARIO, OBSERVACION, N_FACTURA)
SELECT Y.CNSFNOT, 'C', FGLOD.TIPO, FGLOD.IDSERVICIO, FGLOD.DESCRIPCION, 1, FGLOD.VLRACEPTADO,
       FGLOD.VLRACEPTADO, '01', FGLO.USUARIO, FGLOD.OBSERVACION, FGLO.N_FACTURA
--SELECT FGLOD.CNSGLO, FGLOD.TIPO, FGLOD.IDSERVICIO, FGLOD.VLRACEPTADO, FGLO.N_FACTURA, Y.CNSFNOT
FROM   FGLOD INNER JOIN FGLO ON FGLOD.CNSGLO = FGLO.CNSGLO
             INNER JOIN  (
                           SELECT FNOT.CNSFNOT, FNOT.CLASE, FNOT.CERRADA, FNOT.PROCEDENCIA, FNOT.CNSGLO
                           FROM   FNOT INNER JOIN (
                                                   SELECT MCP.NROCOMPROBANTE, MCP.REFERENCIA1, MCP.REFERENCIA2 
                                                   FROM   MCP 
                                                   WHERE  COMPROBANTE = '16' 
                                                   AND    ESTADO  = 0 
                                                   AND    ANULADO = 0
                                                   AND    ANO     = 2013
                                                   AND    MES     = 1
                                                   AND    NOT EXISTS ( SELECT * FROM MCH 
                                                                       WHERE  MCH.NROCOMPROBANTE = MCP.NROCOMPROBANTE
                                                                       AND    MCH.TIPO = 'DB')
                                                  ) X ON FNOT.CNSFNOT = X.REFERENCIA1
                                                     AND FNOT.CLASE   = X.REFERENCIA2
                           WHERE  FNOT.CERRADA = 1                           
                           AND    FNOT.PROCEDENCIA = 'AUDITORIA'
                           AND    NOT EXISTS (SELECT * FROM FNOTD
                                              WHERE  FNOTD.CNSFNOT = FNOT.CNSFNOT
                                              AND    FNOTD.CLASE   = FNOT.CLASE)
                         ) Y ON FGLOD.CNSGLO = Y.CNSGLO
WHERE FGLOD.VLRACEPTADO > 0  
AND   FGLOD.TIPO        = 'C'
ORDER BY FGLOD.CNSGLO                       

BEGIN TRAN
INSERT INTO FNOTD(CNSFNOT, CLASE, ITEM, TIPO, IDSERVICIO, DESCRIPCION, CANTIDAD,
                           VR_UNITARIO, VR_TOTAL, COMPANIA, USUARIO, OBSERVACION,IDAREA,
                           CCOSTO, PREFIJO, N_CUOTA, N_FACTURA)
SELECT CNSFNOT, CLASE, ITEM, TIPO, IDSERVICIO, DESCRIPCION, CANTIDAD,
       VR_UNITARIO, VR_TOTAL, COMPANIA, USUARIO, OBSERVACION, IDAREA,
       CCOSTO, PREFIJO, N_CUOTA, N_FACTURA
FROM #FNOTD 
-- SE BORRA TABLA TEMPORAL
COMMIT

SELECT * FROM #FNOTD

DECLARE @NROCOMPROBANTE VARCHAR(20)
DECLARE @REFERENCIA1    VARCHAR(20)
DECLARE @REFERENCIA2    VARCHAR(20)

DECLARE FNOT_CUR CURSOR FOR
SELECT MCP.NROCOMPROBANTE, MCP.REFERENCIA1, MCP.REFERENCIA2 
FROM   MCP 
WHERE  COMPROBANTE = '16' 
AND    ESTADO  = 0 
AND    ANULADO = 0
AND    ANO     = 2013
AND    MES     = 1
AND    NOT EXISTS ( SELECT * FROM MCH 
                    WHERE  MCH.NROCOMPROBANTE = MCP.NROCOMPROBANTE
                    AND    MCH.TIPO = 'DB')
OPEN FNOT_CUR    
FETCH NEXT FROM FNOT_CUR
INTO @NROCOMPROBANTE, @REFERENCIA1, @REFERENCIA2
WHILE @@FETCH_STATUS = 0    
BEGIN                                   
   EXEC SPK_CONTAB_FNOT @REFERENCIA1, @REFERENCIA2, 'CONTAB_IX','CONTAB','01','01', @NROCOMPROBANTE
   FETCH NEXT FROM FNOT_CUR
   INTO @NROCOMPROBANTE, @REFERENCIA1, @REFERENCIA2
END
CLOSE FNOT_CUR    
DEALLOCATE FNOT_CUR      


commit


DROP TABLE #FNOTD
