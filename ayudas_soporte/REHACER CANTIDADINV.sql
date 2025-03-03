SELECT MARCAINV, SOLICITADO, LISTOENTREGA, ENTREGADO, APLICADO, ENCARGOS, MARCADEV, INDDEV, MDOSIF, CANTIDADINV, IDSERVICIO, CANTIDAD, * FROM HTX WHERE CNSHTX = '0104343567'

SELECT BOLO, * FROM HCA WHERE CONSECUTIVO = '0102246433'

SELECT CANTIDADINV, * FROM HCATD WHERE CONSECUTIVO = '0102246586' AND CODOM = '01' AND ITEMRED = 	1 AND IDSERVICIO = 'B05BB01_5'

exec SPK_CALCULA_ESTABI_ORDEN '0102246586', 1, '01', 'B05BB01_5', 'CIA', 'PSISTEMAS2'

BEGIN TRAN
DECLARE @CONSECUTIVOHCA VARCHAR(13)
DECLARE @ITEMRED        INT
DECLARE @CODOM          VARCHAR(10)
DECLARE @IDSERVICIO     VARCHAR(20)
DECLARE HTX_C CURSOR FOR
SELECT CONSECUTIVOHCA, ITEMRED, CODOM, IDSERVICIO --, MDOSIF, CANTIDADINV 
FROM   HTX
WHERE  MDOSIF = 1
AND    CANTIDADINV IS NULL
AND    FECHAREQ >= '19/06/2013'
--AND    CONSECUTIVOHCA = '0102246586'
OPEN HTX_C
FETCH NEXT FROM HTX_C
INTO @CONSECUTIVOHCA, @ITEMRED,@CODOM, @IDSERVICIO
WHILE @@FETCH_STATUS = 0  
BEGIN  
   EXEC SPK_CALCULA_ESTABI_ORDEN @CONSECUTIVOHCA, @ITEMRED,@CODOM, @IDSERVICIO, 'CIA', 'PSISTEMAS2'

   UPDATE HTX SET HTX.CANTIDADINV = HCATD.CANTIDADINV
   FROM   HTX INNER JOIN HCATD ON HTX.CONSECUTIVOHCA = HCATD.CONSECUTIVO
                              AND HTX.ITEMRED        = HCATD.ITEMRED
                              AND HTX.CODOM          = HCATD.CODOM
                              AND HTX.IDSERVICIO     = HCATD.IDSERVICIO
   WHERE  HTX.CONSECUTIVOHCA = @CONSECUTIVOHCA
   AND    HTX.ITEMRED        = @ITEMRED
   AND    HTX.CODOM          = @CODOM
   AND    HTX.IDSERVICIO     = @IDSERVICIO

   FETCH NEXT FROM HTX_C
   INTO @CONSECUTIVOHCA, @ITEMRED,@CODOM, @IDSERVICIO
END
CLOSE HTX_C
DEALLOCATE HTX_C

COMMIT