USE CEM

               PRINT 'Busco la el ultimo pago de Vacaciones-----'
               SELECT NRODIAS=SUM(COALESCE(DIASG,0))-SUM(COALESCE(DIASP,0))
               FROM NEMPV WHERE NUMDOC='43109255' AND ESTADO IN('PROCESO','CUMPLIDAS')

         SELECT BASICO=(CONVERT(decimal(14,2),(BASICO/DIASXCARGO))) *15 FROM FNK_INFO_NEMPHIS_NEMP('14/09/2023','43109255')
         SELECT 38667*15
         EXEC SPK_CALCULAR_RETIROS '02202309P30-1','43109255'

         SELECT  F_INICAL, DIASG= CASE WHEN F_FINAL<'14/09/2023' THEN 15 ELSE ((( 15.00*1)*DATEDIFF(DAY,F_INICAL,CASE WHEN F_INICAL<=COALESCE('14/09/2023','30/09/2023') THEN F_INICAL ELSE COALESCE('14/09/2023','30/09/2023')END  ))/360) END
         FROM NEMPV 
          WHERE NUMDOC='43109255' AND ESTADO='Proceso'

SELECT 
MAX(FECHAFIN)
FROM NPER INNER JOIN NIEPE ON NPER.CNSPAGO=NIEPE.CNSPAGO
WHERE NIEPE.NUMDOC='43109255'
AND NPER.CERRADO=1

UPDATE USUSU SET IDDEPURAR=0 WHERE USUARIO='JJIMENEZ'


 EXEC SPK_PROCESO_VACACIONES '', 'ACTUALIZA','43109255'

         UPDATE NEMPV SET DIASP=0 WHERE NUMDOC='43109255'

SELECT   IDTERCERO value, RAZONSOCIAL label, VWK_TEXCA.IDCATEGORIA
						FROM VWK_TEXCA
						WHERE VWK_TEXCA.IDCATEGORIA = 'CPAL'


UPDATE TER SET ESTADO='Activo' WHERE RAZONSOCIAL LIKE 'caja%'


select  * from bct