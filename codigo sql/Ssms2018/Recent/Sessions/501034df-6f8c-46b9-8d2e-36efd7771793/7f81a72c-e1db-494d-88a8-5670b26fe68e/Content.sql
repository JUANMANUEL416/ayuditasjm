IF EXISTS ( SELECT * FROM SYSOBJECTS WHERE name = 'SPK_OM_AUTM_CAMBIOS_AUDIT' AND type = 'P')
BEGIN
   DROP PROCEDURE SPK_OM_AUTM_CAMBIOS_AUDIT
END
GO
CREATE PROCEDURE DBO.SPK_OM_AUTM_CAMBIOS_AUDIT
@CONSECUTIVO    VARCHAR(13),
@CODOM          VARCHAR(10),
@IDSERVICIO     VARCHAR(20),
@TIPOCAMBIO     VARCHAR(1)
WITH ENCRYPTION
AS
DECLARE @CLASEPLANTILLA VARCHAR( 8 )
DECLARE @CLASEHC        VARCHAR(1)
DECLARE @NOADMISION     VARCHAR(16)
DECLARE @IDAREA         VARCHAR(20)
DECLARE @IDMEDICO       VARCHAR(12)
DECLARE @CONSECUTIVOANT VARCHAR(13) 
DECLARE @ITEMREDANT     INT, @ITEMREDANTCON_OM INT, @TIPOMED INT, @ORDEN INT
DECLARE @TIPOPM         VARCHAR(20)
DECLARE @OBSERVACION    VARCHAR(510)
DECLARE @CLASE          VARCHAR(20)
BEGIN  
   SELECT @TIPOMED = 0
   IF @CODOM = DBO.FNK_VALORVARIABLE('OMCODMEDICAMENTOS')
   BEGIN
      SELECT @TIPOMED = 1
   END
   IF @CODOM = DBO.FNK_VALORVARIABLE('OMCODMEDICAMENTOSCT')
   BEGIN
      SELECT @TIPOMED = 1
   END
   IF @CODOM = DBO.FNK_VALORVARIABLE('OMCODMEDICAMENTOSNP')
   BEGIN
      SELECT @TIPOMED = 1
   END
   PRINT '@TIPOMED= ' + CONVERT(VARCHAR,@TIPOMED)
   /*HACER PLAN DE MANEJO AUTOMATICO*/
   SELECT @TIPOPM = TIPOPM FROM HCA WHERE CONSECUTIVO = @CONSECUTIVO
   IF @TIPOPM = 'Automatico'
   BEGIN
     IF @TIPOCAMBIO = 'B' OR @TIPOCAMBIO  ='S'  OR @TIPOCAMBIO  =''
     BEGIN
         SELECT @ORDEN = COALESCE(ORDEN,0), @CLASE = CLASE FROM HCAPM WHERE CONSECUTIVO = @CONSECUTIVO AND IDSERVICIO = @IDSERVICIO AND HCAPM.CLASE IN ('OM', 'Manual')
         PRINT '@ORDEN == '+STR(COALESCE(@ORDEN,0))
         DELETE FROM HCAPM WHERE CONSECUTIVO = @CONSECUTIVO AND IDSERVICIO = @IDSERVICIO AND HCAPM.CLASE IN ('OM', 'Manual')
         PRINT 'BORRE HCAPM'
     
         print 'voy a insertar en hcapm'      
         INSERT INTO HCAPM(CONSECUTIVO, ORDEN, CLASE, OBSERVACION, IDSERVICIO, CLAMED)
         SELECT @CONSECUTIVO, CASE @TIPOCAMBIO WHEN 'I' THEN (SELECT COALESCE(MAX(ORDEN),0) + 1 FROM HCAPM WHERE CONSECUTIVO = @CONSECUTIVO)
                                               ELSE @ORDEN
                              END,
                @CLASE, 
                LEFT(CASE @TIPOMED WHEN 1 THEN
                                     CASE @TIPOCAMBIO WHEN 'B' THEN 'Cambio:    '
                                                      WHEN 'S' THEN 'Suspender: '
                                                      WHEN 'I' THEN 'Iniciar: '
                                                      WHEN '' THEN 'Iniciar: '
                                     END  
                              ELSE ''
                      END + LTRIM(RTRIM(SER.DESCSERVICIO)) + 
                CASE @TIPOMED WHEN 1 THEN
                                           CASE @TIPOCAMBIO WHEN 'B' THEN ' :: DOSIS :' + CONVERT(VARCHAR,CONVERT(DECIMAL(14,2),HCATD.CANTIDAD)) + ' ' + 
                                                                                        RTRIM(LTRIM(HCATD.IDTIPOCONC))+ ' CADA ' + CONVERT(VARCHAR,HCATD.FRECUENCIA) + ' HORAS'                                                                                                            WHEN 'I' THEN ' :: DOSIS :' + CONVERT(VARCHAR,CONVERT(DECIMAL(14,2),HCATD.CANTIDAD)) + ' ' + 
                                                                                        RTRIM(LTRIM(HCATD.IDTIPOCONC))+ ' CADA ' + CONVERT(VARCHAR,HCATD.FRECUENCIA) + ' HORAS'              
                                                            WHEN '' THEN ' :: DOSIS :' + CONVERT(VARCHAR,CONVERT(DECIMAL(14,2),HCATD.CANTIDAD)) + ' ' + 
                                                                                        RTRIM(LTRIM(HCATD.IDTIPOCONC))+ ' CADA ' + CONVERT(VARCHAR,HCATD.FRECUENCIA) + ' HORAS'              
                                                            WHEN 'S' THEN ''
                                           END
                                     ELSE ''  
                END + 
                 CASE WHEN (SER.MEZCLA > 0  AND COALESCE(HCATD.IDSERVICIOMEZCLA,'') NOT IN ('','ENF')) THEN ' DILUIDO EN ' + CONVERT(VARCHAR(8),COALESCE(HCATD.QMEZCLA,0)) + ' DE ' + LEFT(MEZ.DESCSERVICIO,50)
                      ELSE '' END +
                 CASE WHEN LEN(RTRIM(HCATD.OBSERVACION)) > 0 THEN ' // OBSERVACION:'+RTRIM(HCATD.OBSERVACION) ELSE '' END,512),
                HCATD.IDSERVICIO, @CODOM
         FROM   HCATD INNER JOIN SER ON HCATD.IDSERVICIO = SER.IDSERVICIO
                      LEFT  JOIN SER MEZ ON HCATD.IDSERVICIOMEZCLA = MEZ.IDSERVICIO
                      INNER JOIN HCCOM   ON HCATD.CODOM = HCCOM.CODOM
         WHERE  HCATD.CONSECUTIVO = @CONSECUTIVO
         AND    HCATD.IDSERVICIO  = @IDSERVICIO
         ORDER BY HCCOM.ORDEN
         PRINT 'TERMINE INSERT '
         PRINT 'INICIO EL UPDATE '
         UPDATE HCAPM SET HCAPM.ORDEN = X.ORDEN
         FROM   HCAPM INNER JOIN (
                                    SELECT CONSECUTIVO, IDSERVICIO, ROW_NUMBER() OVER(ORDER BY HCCOM.ORDEN, HCAPM.IDSERVICIO ) ORDEN
                                    FROM   HCAPM LEFT JOIN HCCOM   ON HCAPM.CLAMED = HCCOM.CODOM 
                                    WHERE  HCAPM.CONSECUTIVO = @CONSECUTIVO
                                 ) X ON HCAPM.CONSECUTIVO = X.CONSECUTIVO
                                    AND HCAPM.IDSERVICIO  = X.IDSERVICIO
         WHERE  HCAPM.CLASE IN ('OM', 'Manual')
      END
      IF @TIPOCAMBIO='C'
      BEGIN
         SELECT @ORDEN = ORDEN FROM HCAPM WHERE CONSECUTIVO = @CONSECUTIVO AND IDSERVICIO = @IDSERVICIO AND HCAPM.CLASE = 'OM' 
         SELECT @OBSERVACION='Continuar: '+ LTRIM(RTRIM(SER.DESCSERVICIO)) +' : DOSIS :' + CONVERT(VARCHAR,CONVERT(DECIMAL(14,2),HCATD.CANTIDAD)) + ' ' + 
                                                                                        RTRIM(LTRIM(HCATD.IDTIPOCONC))+ ' CADA ' + CONVERT(VARCHAR,HCATD.FRECUENCIA) + ' HORAS' 
         FROM   HCATD INNER JOIN SER ON HCATD.IDSERVICIO = SER.IDSERVICIO
                      LEFT  JOIN SER MEZ ON HCATD.IDSERVICIOMEZCLA = MEZ.IDSERVICIO
         WHERE  HCATD.CONSECUTIVO = @CONSECUTIVO
         AND    HCATD.IDSERVICIO  = @IDSERVICIO

         UPDATE HCAPM SET OBSERVACION = @OBSERVACION WHERE  CONSECUTIVO=@CONSECUTIVO AND IDSERVICIO=@IDSERVICIO AND ORDEN=@ORDEN  
      END
      IF @TIPOCAMBIO='I'
      BEGIN
         INSERT INTO HCAPM(CONSECUTIVO, ORDEN, CLASE, OBSERVACION, IDSERVICIO, CLAMED)
         SELECT @CONSECUTIVO,(SELECT COALESCE(MAX(ORDEN),0) + 1 FROM HCAPM WHERE CONSECUTIVO = @CONSECUTIVO),
                   @CLASE, 
                  LEFT(CASE @TIPOMED WHEN 1 THEN
                                       CASE @TIPOCAMBIO WHEN 'B' THEN 'Cambio:    '
                                                        WHEN 'S' THEN 'Suspender: '
                                                        WHEN 'I' THEN 'Iniciar: '
                                                        WHEN '' THEN 'Iniciar: '
                                                        WHEN 'C' THEN 'Continuar: '
                                       END  
                              ELSE ''
                        END + LTRIM(RTRIM(SER.DESCSERVICIO)) + 
                  CASE @TIPOMED WHEN 1 THEN
                                             CASE @TIPOCAMBIO WHEN 'B' THEN ' :: DOSIS :' + CONVERT(VARCHAR,CONVERT(DECIMAL(14,2),HCATD.CANTIDAD)) + ' ' + 
                                                                                          RTRIM(LTRIM(HCATD.IDTIPOCONC))+ ' CADA ' + CONVERT(VARCHAR,HCATD.FRECUENCIA) + ' HORAS' 
                                                            WHEN 'C' THEN ' :: DOSIS :' + CONVERT(VARCHAR,CONVERT(DECIMAL(14,2),HCATD.CANTIDAD)) + ' ' + 
                                                                                          RTRIM(LTRIM(HCATD.IDTIPOCONC))+ ' CADA ' + CONVERT(VARCHAR,HCATD.FRECUENCIA) + ' HORAS'                                                                                                                    
                                                            WHEN 'I' THEN ' :: DOSIS :' + CONVERT(VARCHAR,CONVERT(DECIMAL(14,2),HCATD.CANTIDAD)) + ' ' + 
                                                                                          RTRIM(LTRIM(HCATD.IDTIPOCONC))+ ' CADA ' + CONVERT(VARCHAR,HCATD.FRECUENCIA) + ' HORAS'              
                                                            WHEN '' THEN ' :: DOSIS :' + CONVERT(VARCHAR,CONVERT(DECIMAL(14,2),HCATD.CANTIDAD)) + ' ' + 
                                                                                          RTRIM(LTRIM(HCATD.IDTIPOCONC))+ ' CADA ' + CONVERT(VARCHAR,HCATD.FRECUENCIA) + ' HORAS'              
                                                            WHEN 'S' THEN ''
                                             END
                                       ELSE ''  
                  END + 
                  CASE WHEN (SER.MEZCLA > 0  AND COALESCE(HCATD.IDSERVICIOMEZCLA,'') NOT IN ('','ENF')) THEN ' DILUIDO EN ' + CONVERT(VARCHAR(8),COALESCE(HCATD.QMEZCLA,0)) + ' DE ' + LEFT(MEZ.DESCSERVICIO,50)
                        ELSE '' END +
                  CASE WHEN LEN(RTRIM(HCATD.OBSERVACION)) > 0 THEN ' // OBSERVACION:'+RTRIM(HCATD.OBSERVACION) ELSE '' END,512),
                  HCATD.IDSERVICIO, @CODOM
         FROM   HCATD INNER JOIN SER ON HCATD.IDSERVICIO = SER.IDSERVICIO
                      LEFT  JOIN SER MEZ ON HCATD.IDSERVICIOMEZCLA = MEZ.IDSERVICIO
                      INNER JOIN HCCOM   ON HCATD.CODOM = HCCOM.CODOM
         WHERE  HCATD.CONSECUTIVO = @CONSECUTIVO
         AND    HCATD.IDSERVICIO  = @IDSERVICIO
         ORDER BY HCCOM.ORDEN
         PRINT 'TERMINE INSERT '
         PRINT 'INICIO EL UPDATE '
         UPDATE HCAPM SET HCAPM.ORDEN = X.ORDEN
         FROM   HCAPM INNER JOIN (
                                    SELECT CONSECUTIVO, IDSERVICIO, ROW_NUMBER() OVER(ORDER BY HCCOM.ORDEN, HCAPM.IDSERVICIO ) ORDEN
                                    FROM   HCAPM LEFT JOIN HCCOM   ON HCAPM.CLAMED = HCCOM.CODOM 
                                    WHERE  HCAPM.CONSECUTIVO = @CONSECUTIVO
                                 ) X ON HCAPM.CONSECUTIVO = X.CONSECUTIVO
                                    AND HCAPM.IDSERVICIO  = X.IDSERVICIO
         WHERE  HCAPM.CLASE IN ('OM', 'Manual')
      END
   END 
END

