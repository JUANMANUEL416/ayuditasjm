EXEC SPK_RELIQUIDA_FTR '0100000559', '00113796'

SELECT * FROM FCXCDV WHERE N_FACTURA = '00113796'

-- NEGATIVAS 'G' 'R'
DECLARE @CNSCXC  VARCHAR(20)
DECLARE @N_FACTURA VARCHAR(16)   
DECLARE G_C CURSOR FOR
--SELECT DISTINCT CNSCXC, N_FACTURA FROM FCXCDV WHERE TIPO = 'R' AND SALDONETO IS NULL ORDER BY N_FACTURA
SELECT DISTINCT CNSCXC, N_FACTURA FROM FCXCDV WHERE SALDONETO < 0 ORDER BY N_FACTURA  --3383
OPEN G_C
FETCH NEXT FROM G_C
INTO @CNSCXC, @N_FACTURA
WHILE @@FETCH_STATUS = 0    
BEGIN         
   PRINT 'N_FACTURA = '+@N_FACTURA
   EXEC SPK_RELIQUIDA_FTR @CNSCXC, @N_FACTURA
   FETCH NEXT FROM G_C
   INTO @CNSCXC, @N_FACTURA   
END
CLOSE G_C
DEALLOCATE G_C
GO
-- GLOSAS DUPLICADAS
BEGIN TRAN 
DECLARE @CNSCXC    VARCHAR(20)
DECLARE @N_FACTURA VARCHAR(16)
DECLARE @TIPO      VARCHAR(1)
DECLARE @CNSGLO    VARCHAR(20)
DECLARE @VEZ       INT
DECLARE @ITEM      INT
DECLARE @BORRADAS   INT

SELECT @BORRADAS = 0
DECLARE DOB_C CURSOR FOR
SELECT CNSCXC, N_FACTURA, TIPO, CNSGLO, COUNT(*) 
FROM   FCXCDV 
WHERE  FCXCDV.TIPO = 'G'
GROUP BY CNSCXC, N_FACTURA, TIPO, CNSGLO
HAVING COUNT(*) > 1
ORDER BY N_FACTURA
OPEN DOB_C
FETCH NEXT FROM DOB_C
INTO @CNSCXC, @N_FACTURA, @TIPO, @CNSGLO, @VEZ
WHILE @@FETCH_STATUS = 0    
BEGIN                 
   SELECT @ITEM = MAX(ITEM) FROM FCXCDV WHERE CNSCXC = @CNSCXC AND N_FACTURA = @N_FACTURA AND CNSGLO = @CNSGLO
   DELETE FCXCDV WHERE ITEM = @ITEM
   SELECT @BORRADAS = @BORRADAS + 1
   
   FETCH NEXT FROM DOB_C
   INTO @CNSCXC, @N_FACTURA, @TIPO, @CNSGLO, @VEZ
END
CLOSE DOB_C
DEALLOCATE DOB_C
SELECT 'BORRADAS='+ CAST(@BORRADAS AS VARCHAR(20))

COMMIT
--CONCILIACIONES QUE NO GENERO EN FCXCDV Y SALDOSINICIALES QUE NO CUADRAN
-----------------------
DROP TABLE FCXCDV_C_MAL
GO
CREATE TABLE FCXCDV_C_MAL ( CNSCXC       VARCHAR(20),
                            N_FACTURA    VARCHAR(16),
                            IDFCONCI     VARCHAR(20),
                            ITEM_FCONCID INT, 
                            TIPO         VARCHAR(1), 
                            CNSGLO       VARCHAR(20), 
                            ITEM_FCXCDV  INT,
                            SALDOINICIAL DECIMAL(14,2),
                            VLRRECUPERAR DECIMAL(14,2),
                            MENSAJE      VARCHAR(20),
                            PROCESADO    SMALLINT) 
                            GO
DELETE FCXCDV_C_MAL
GO
DECLARE @CNSCXC       VARCHAR(20)
DECLARE @N_FACTURA    VARCHAR(16)
DECLARE @TIPO         VARCHAR(1)
DECLARE @CNSGLO       VARCHAR(20)
DECLARE @SALDONETO    DECIMAL(14,2)
DECLARE @VLRACEPTADO  DECIMAL(14,2)
DECLARE @VLRRECUPERAR DECIMAL(14,2)
DECLARE @SALDOINICIAL DECIMAL(14,2)
DECLARE @ITEM_FCXCDV  INT
DECLARE @IDFCONCI     VARCHAR(20)
DECLARE @ITEM_FCONCID INT 
DECLARE CONC_C CURSOR FOR
SELECT FCONCID.IDFCONCI, FCONCID.ITEM_FCONCID, FCONCID.CNSCXC, FCONCID.N_FACTURA, FCONCID.TIPO, FCONCID.CNSGLO, FCONCID.SALDONETO, FCONCID.VLRACEPTADO, FCONCID.VLRRECUPERAR
FROM   FCONCID 
WHERE  FCONCID.TIPO = 'G'
ORDER BY FCONCID.N_FACTURA
OPEN CONC_C
FETCH NEXT FROM CONC_C
INTO @IDFCONCI, @ITEM_FCONCID, @CNSCXC, @N_FACTURA, @TIPO, @CNSGLO, @SALDONETO, @VLRACEPTADO, @VLRRECUPERAR
WHILE @@FETCH_STATUS = 0    
BEGIN               
   SELECT @SALDOINICIAL = 0, @ITEM_FCXCDV = 0

   IF ( SELECT COALESCE(COUNT(*),0)
        FROM   FCXCDV
        WHERE  N_FACTURA = @N_FACTURA 
        AND    CNSCXC = @CNSCXC 
        AND    TIPO = 'C' 
        AND    CNSGLO   = @CNSGLO
        AND    IDFCONCI = @IDFCONCI
      ) > 0 
   BEGIN
      SELECT @SALDOINICIAL = SALDOINICIAL, @ITEM_FCXCDV = ITEM
      FROM   FCXCDV
      WHERE  N_FACTURA = @N_FACTURA 
      AND    CNSCXC = @CNSCXC 
      AND    TIPO = 'C' 
      AND    CNSGLO   = @CNSGLO
      AND    IDFCONCI = @IDFCONCI
      IF @SALDOINICIAL <> @VLRRECUPERAR
      BEGIN
         INSERT INTO FCXCDV_C_MAL(CNSCXC, N_FACTURA, IDFCONCI, ITEM_FCONCID, TIPO, CNSGLO, ITEM_FCXCDV, SALDOINICIAL, VLRRECUPERAR, MENSAJE, PROCESADO)
         SELECT @CNSCXC, @N_FACTURA, @IDFCONCI, @ITEM_FCONCID, @TIPO, @CNSGLO, @ITEM_FCXCDV, @SALDOINICIAL, @VLRRECUPERAR, 'DIFERENCIAS', 0
      END
   END
   ELSE
   BEGIN
      INSERT INTO FCXCDV_C_MAL(CNSCXC, N_FACTURA, IDFCONCI, ITEM_FCONCID, TIPO, CNSGLO, ITEM_FCXCDV, SALDOINICIAL, VLRRECUPERAR, MENSAJE, PROCESADO)
      SELECT @CNSCXC, @N_FACTURA, @IDFCONCI, @ITEM_FCONCID, @TIPO, @CNSGLO, @ITEM_FCXCDV, @SALDOINICIAL, @VLRRECUPERAR, 'NO EXISTE', 0
   END
     
   FETCH NEXT FROM CONC_C
   INTO @IDFCONCI, @ITEM_FCONCID, @CNSCXC, @N_FACTURA, @TIPO, @CNSGLO, @SALDONETO, @VLRACEPTADO, @VLRRECUPERAR
END
CLOSE CONC_C
DEALLOCATE CONC_C
GO

BEGIN TRAN
DECLARE @CNSCXC       VARCHAR(20)
DECLARE @N_FACTURA    VARCHAR(16)
DECLARE @IDFCONCI     VARCHAR(20)
DECLARE @ITEM_FCONCID INT 
DECLARE @TIPO         VARCHAR(1)
DECLARE @CNSGLO       VARCHAR(20)
DECLARE @ITEM_FCXCDV  INT
DECLARE @SALDOINICIAL DECIMAL(14,2)
DECLARE @VLRRECUPERAR DECIMAL(14,2)
DECLARE @MENSAJE      VARCHAR(20)
DECLARE @FECHA        DATETIME
DECLARE C_C CURSOR FOR
SELECT CNSCXC, N_FACTURA, IDFCONCI, ITEM_FCONCID, TIPO, CNSGLO, ITEM_FCXCDV, SALDOINICIAL, VLRRECUPERAR, MENSAJE FROM FCXCDV_C_MAL
WHERE  COALESCE(PROCESADO,0) = 0
OPEN C_C
FETCH NEXT FROM C_C
INTO @CNSCXC, @N_FACTURA, @IDFCONCI, @ITEM_FCONCID, @TIPO, @CNSGLO, @ITEM_FCXCDV, @SALDOINICIAL, @VLRRECUPERAR, @MENSAJE
WHILE @@FETCH_STATUS = 0    
BEGIN         
   IF @MENSAJE = 'NO EXISTE'
   BEGIN
      SELECT @FECHA = FECHACONC FROM FCONCI WHERE IDFCONCI = @IDFCONCI
      INSERT INTO FCXCDV(CNSCXC, N_FACTURA, CNSGLO, TIPO, SALDOINICIAL, SALDONETO, FECHA, F_RECIBIDO, F_VENCE, MARCAPAGO, IDFCONCI)
      SELECT @CNSCXC, @N_FACTURA, @CNSGLO, 'C', @VLRRECUPERAR, @VLRRECUPERAR, @FECHA, @FECHA, @FECHA, 0, @IDFCONCI     
   END
   ELSE
   BEGIN
      UPDATE FCXCDV SET SALDOINICIAL = @VLRRECUPERAR
      WHERE  ITEM= @ITEM_FCXCDV
      UPDATE FCONCID SET ITEM_FCXCDV = @ITEM_FCXCDV
      WHERE  IDFCONCI     = @IDFCONCI
      AND    ITEM_FCONCID = @ITEM_FCONCID
   END
   UPDATE FCXCDV_C_MAL SET PROCESADO = 1 
   WHERE CNSCXC          = @CNSCXC
   AND   N_FACTURA       = @N_FACTURA
   AND   IDFCONCI        = @IDFCONCI
   AND   ITEM_FCONCID    = @ITEM_FCONCID
   AND   TIPO            = @TIPO
   AND   CNSGLO          = @CNSGLO
   AND   ITEM_FCXCDV     = @ITEM_FCXCDV
   AND   SALDOINICIAL    = @SALDOINICIAL
   AND   VLRRECUPERAR    = @VLRRECUPERAR
   AND   MENSAJE         = @MENSAJE   
   FETCH NEXT FROM C_C
   INTO @CNSCXC, @N_FACTURA, @IDFCONCI, @ITEM_FCONCID, @TIPO, @CNSGLO, @ITEM_FCXCDV, @SALDOINICIAL, @VLRRECUPERAR, @MENSAJE   
END
CLOSE C_C
DEALLOCATE C_C

COMMIT

SELECT * FROM FCXCDV_C_MAL
GO
---- RELIQUIDAMOS LAS QUE ACABAMOS DE CAMBIAR
DECLARE @CNSCXC  VARCHAR(20)
DECLARE @N_FACTURA VARCHAR(16)   
DECLARE G_C CURSOR FOR
--SELECT DISTINCT CNSCXC, N_FACTURA FROM FCXCDV WHERE TIPO = 'R' AND SALDONETO IS NULL ORDER BY N_FACTURA
SELECT DISTINCT CNSCXC, N_FACTURA FROM FCXCDV_C_MAL WHERE PROCESADO = 1 ORDER BY N_FACTURA
OPEN G_C
FETCH NEXT FROM G_C
INTO @CNSCXC, @N_FACTURA
WHILE @@FETCH_STATUS = 0    
BEGIN         
   PRINT 'N_FACTURA = '+@N_FACTURA
   EXEC SPK_RELIQUIDA_FTR @CNSCXC, @N_FACTURA
   FETCH NEXT FROM G_C
   INTO @CNSCXC, @N_FACTURA   
END
CLOSE G_C
DEALLOCATE G_C
GO

SELECT COUNT(*) FROM FCXCD -- 122949
--FCXCDV 120706
-- REVISION DE FCXCDV SIN FCXCD  no deberian existir
SELECT * 
FROM   FCXCDV
WHERE  NOT EXISTS ( SELECT * FROM FCXCD
                    WHERE  FCXCD.CNSCXC    = FCXCDV.CNSCXC
                    AND    FCXCD.N_FACTURA = FCXCDV.N_FACTURA )
-- REVISION DE FCXCD SIN FCXCDV   --AUNQUE ES POSIBLE REVISAR LAS ANTIGUAS
SELECT 2243 - 2227
SELECT * 
FROM   FCXCD
WHERE  NOT EXISTS ( SELECT * FROM FCXCDV
                    WHERE  FCXCD.CNSCXC    = FCXCDV.CNSCXC
                    AND    FCXCD.N_FACTURA = FCXCDV.N_FACTURA )
AND    NOT EXISTS ( SELECT *
                    FROM   FTR
                    WHERE  FTR.N_FACTURA = FCXCD.N_FACTURA
                    AND    (FTR.ESTADO = 'A' OR COALESCE(FTR.TIPOANULACION,'') = 'NC')
                  )

SELECT FCXCD.N_FACTURA, FTR.F_FACTURA, FCXCD.CNSCXC, FCXC.FECHACXC, FCXCD.USUARIO, FCXCD.VALORFACTURA, FCXCD.SALDONETO, TER.IDTERCERO, TER.RAZONSOCIAL
FROM   FCXCD LEFT JOIN  FTR ON FCXCD.N_FACTURA = FTR.N_FACTURA
             LEFT JOIN FCXC ON FCXCD.CNSCXC    = FCXC.CNSCXC
             LEFT JOIN TER  ON FTR.IDTERCERO   = TER.IDTERCERO
WHERE  NOT EXISTS ( SELECT * 
                    FROM   FCXCDV
                    WHERE  FCXCD.CNSCXC    = FCXCDV.CNSCXC
                    AND    FCXCD.N_FACTURA = FCXCDV.N_FACTURA )
AND    NOT EXISTS ( SELECT *
                    FROM   FTR
                    WHERE  FTR.N_FACTURA = FCXCD.N_FACTURA
                    AND    (FTR.ESTADO = 'A' OR COALESCE(FTR.TIPOANULACION,'') = 'NC')
                  )
AND    NOT EXISTS ( SELECT * 
                    FROM   FPAGD
                    WHERE  FPAGD.CNSCXC    = FCXCD.CNSCXC
                    AND    FPAGD.N_FACTURA = FCXCD.N_FACTURA)
AND    NOT EXISTS ( SELECT *
                     FROM   FNOT
                     WHERE  FNOT.N_FACTURA = FCXCD.N_FACTURA )


SELECT PROCEDENCIA, NOREFERENCIA, TIPOFAC, * FROM FTR WHERE N_FACTURA = '00216793' -- 200245
SELECT LIBERAHADM, * FROM FNOT WHERE N_FACTURA = '00216793'
SELECT * FROM HEVEN WHERE NOADMISION = '0100079530'


SELECT FCXCD.CNSCXC, FCXCD.N_FACTURA, FCXCD.SALDONETO, X.SALDODET
FROM   FCXCD INNER JOIN (
                         SELECT CNSCXC, N_FACTURA, SUM(SALDONETO) SALDODET
                         FROM   FCXCDV
                         GROUP BY CNSCXC, N_FACTURA
                        ) X ON FCXCD.CNSCXC    = X.CNSCXC
                           AND FCXCD.N_FACTURA = X.N_FACTURA




UPDATE HTX SET IDSERVICIO = ''
WHERE  HTX.NOPRESTACION = ''
NOPRESTACION NOITEM
GO
SELECT * FROM HPRE WHERE PROCEDENCIA = 'HTX' AND YEAR (FECHA) = 2013
GO

CREATE PROC DBO.SPK_AUD_CAMBIA_SERVICIO
@NOADMISION    VARCHAR(16),
@IDSERVICIOANT VARCHAR(20),
@IDSERVICIONUE VARCHAR(20),
@IDUSUARIO     VARCHAR(12)
AS
DECLARE @NOPRESTACION VARCHAR(16)
DECLARE @NOITEM       SMALLINT
DECLARE @PROCEDENCIA  VARCHAR(20)
BEGIN
   DECLARE HP_C CURSOR FOR
   SELECT HPRED.NOPRESTACION, HPRED.NOITEM, HPRE.PROCEDENCIA 
   FROM   HPRED INNER JOIN HPRE ON HPRED.NOPRESTACION = HPRE.NOPRESTACION
   WHERE  HPRED.IDSERVICIO = @IDSERVICIOANT
   AND    HPRE.NOADMISION  = @NOADMISION
   OPEN HP_C
   FETCH NEXT FROM HP_C
   INTO @NOPRESTACION, @NOITEM, @PROCEDENCIA
   WHILE @@FETCH_STATUS = 0    
   BEGIN
      UPDATE HPRED SET IDSERVICIO = @IDSERVICIONUE
      WHERE  HPRED.NOPRESTACION   = @NOPRESTACION 
      AND    HPRED.NOITEM         = @NOITEM

      IF @PROCEDENCIA = 'HTX'
      BEGIN
         UPDATE HTX SET IDSERVICIO = @IDSERVICIONUE
         WHERE  HTX.NOPRESTACION   = @NOPRESTACION 
         AND    HTX.NOITEM         = @NOITEM
      END

      FETCH NEXT FROM HP_C
      INTO @NOPRESTACION, @NOITEM, @PROCEDENCIA
   END
   CLOSE HP_C
   DEALLOCATE HP_C
END
GO


SELECT * FROM HPRE WHERE NOPRESTACION = '0102389755'

SELECT * FROM HTX WHERE NOPRESTACION = '0102389755'


SELECT * FROM HTX


SELECT * FROM FCXCDV WHERE N_FACTURA = '00192821'

SELECT * FROM FCONCID WHERE N_FACTURA = '00192821'