--001   RPDX
SELECT COUNT(*) FROM RPDX 
SELECT MAX(CNS) FROM RPDX WHERE CNS LIKE '01%'--0115599839
DELETE RPDX WHERE CNS > '0100000000' AND CNS < '0115500000'
                                               '0113020000'

SELECT MAX(CNS) FROM RPDX WHERE CNS LIKE '03%'--0115599839
DELETE RPDX WHERE CNS > '0100000000' AND CNS < '0300080000'

--002   RPDX2    
SELECT COUNT(*) FROM RPDX2 
SELECT MIN(CNS) FROM RPDX2 WHERE CNS LIKE '01%'--0115051290
DELETE RPDX2 WHERE CNS > '0100000000' AND CNS < '0115100000'
--003   HCADL

SELECT TOP 1000000 * FROM HCAT 
--DELETE HCAT
WHERE  NOT EXISTS ( SELECT * FROM HCATD WHERE HCATD.CONSECUTIVO = HCAT.CONSECUTIVO
                   AND    HCATD.ITEMRED = HCAT.ITEMRED
                   AND    HCATD.CODOM   = HCAT.CODOM )
AND    HCAT.CONSECUTIVO >= 'ON00000000'
AND    HCAT.CONSECUTIVO <  'ON00275000'



SELECT * FROM HCATD WHERE CONSECUTIVO = '0100009999' AND ITEMRED = 1 AND CODOM = '05'

SELECT DISTINCT LEFT(HCAT.CONSECUTIVO,2) FROM HCAT 

SELECT MAX(CONSECUTIVO) FROM HCA WHERE LEFT(HCA.CONSECUTIVO,2) = '01'



SELECT MPLD.* 
FROM   MPL INNER JOIN MPLD ON MPL.CLASEPLANTILLA = MPLD.CLASEPLANTILLA
WHERE  MPL.CLASE = 'NE'

SELECT * FROM HCCOM