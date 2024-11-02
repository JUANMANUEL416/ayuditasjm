DELETE IMPFTR_JEDM
DROP TABLE IMP_DUP

SELECT NOADMISION, DESC1, COUNT(*) AS VECES
--INTO   IMP_DUP
FROM   IMPFTR
WHERE  DESC1 = 'SERVICIOS CLINICOS'
GROUP BY NOADMISION, DESC1
HAVING COUNT(*) > 1

SELECT * FROM IMP_DUP

INSERT INTO IMPFTR_JEDM ( NOADMISION, GRUPO, TIPO, TIPO2, COD1, DESC1, COD2, DESC2, COD3, DESC3, COD4, DESC4, VALOR, TMP1,
                          TMP2, ITFC, N_FACTURA )
SELECT NOADMISION, GRUPO, TIPO, TIPO2, COD1, DESC1, COD2, DESC2, COD3, DESC3, COD4, DESC4, VALOR, TMP1,
       TMP2, ITFC, N_FACTURA
FROM   IMPFTR       
WHERE  NOADMISION IN (SELECT NOADMISION FROM IMP_DUP )
ORDER BY NOADMISION, GRUPO, TIPO, TIPO2, COD1, COD2


SELECT * FROM IMPFTR_JEDM WHERE NOADMISION = '0100001361' ORDER BY NOADMISION, GRUPO, TIPO, TIPO2, COD1, COD2


DECLARE @NOADMISION VARCHAR(16)
SELECT @NOADMISION = '0100001361'

DELETE IMPFTR_JEDM WHERE NOADMISION = @NOADMISION AND (ITEM/2.00) <> ROUND((ITEM/2.00), 0, 1)
DELETE IMPFTR WHERE NOADMISION = @NOADMISION

INSERT INTO IMPFTR ( NOADMISION, GRUPO, TIPO, TIPO2, COD1, DESC1, COD2, DESC2, COD3, DESC3, COD4, DESC4, VALOR, TMP1,
                          TMP2, ITFC, N_FACTURA )
SELECT NOADMISION, GRUPO, TIPO, TIPO2, COD1, DESC1, COD2, DESC2, COD3, DESC3, COD4, DESC4, VALOR, TMP1,
                          TMP2, ITFC, N_FACTURA 
FROM IMPFTR_JEDM WHERE NOADMISION = @NOADMISION



   --Se recalculan los valores GRUPO 01

 
   UPDATE IMPFTR SET IMPFTR.VALOR = X.VALOR
   FROM   IMPFTR INNER JOIN (SELECT ITFC, SUM(VALOR) AS VALOR
                             FROM   IMPFTR
                             WHERE  IMPFTR.GRUPO            = '01'
                             AND    ISNULL(IMPFTR.COD1,'')  = ''
                             AND    ISNULL(IMPFTR.COD2,'') <> ''
                             AND    IMPFTR.NOADMISION = @NOADMISION
                             GROUP BY ITFC) X  ON IMPFTR.ITFC = X.ITFC
   WHERE  IMPFTR.GRUPO            = '01'
   AND    IMPFTR.NOADMISION       = @NOADMISION
   AND    ISNULL(IMPFTR.COD1,'') <> ''
   
   -- Se recalculan los valores GRUPO 02
   UPDATE IMPFTR SET IMPFTR.VALOR = X.VALOR
   FROM   IMPFTR INNER JOIN (SELECT  ITFC, COD2, SUM(VALOR) AS VALOR
                              FROM   IMPFTR
                              WHERE  IMPFTR.GRUPO            = '02'
                              AND    ISNULL(IMPFTR.COD1,'')  = ''
                              AND    ISNULL(IMPFTR.COD2,'') <> ''
                              AND    ISNULL(IMPFTR.COD3,'') <> ''
                              AND    IMPFTR.NOADMISION = @NOADMISION
                              GROUP BY ITFC, COD2) X  ON IMPFTR.ITFC = X.ITFC AND ISNULL(IMPFTR.COD2,'') = ISNULL(X.COD2,'')
   WHERE  IMPFTR.GRUPO            = '02'
   AND    ISNULL(IMPFTR.COD1,'') = ''
   AND    ISNULL(IMPFTR.COD2,'') <> ''
   AND    ISNULL(IMPFTR.COD3,'') = ''
   AND    IMPFTR.NOADMISION = @NOADMISION
   
   UPDATE IMPFTR SET IMPFTR.VALOR = X.VALOR
   FROM   IMPFTR INNER JOIN (SELECT  ITFC, SUM(VALOR) AS VALOR
                              FROM   IMPFTR
                              WHERE  IMPFTR.GRUPO            = '02'
                              AND    ISNULL(IMPFTR.COD1,'')  = ''
                              AND    ISNULL(IMPFTR.COD2,'') <> ''
                              AND    ISNULL(IMPFTR.COD3,'') = ''
                              AND    IMPFTR.NOADMISION = @NOADMISION
                              GROUP BY ITFC) X  ON IMPFTR.ITFC = X.ITFC 
   WHERE  IMPFTR.GRUPO            = '02'
   AND    ISNULL(IMPFTR.COD1,'') <> ''
   AND    ISNULL(IMPFTR.COD2,'') = ''
   AND    ISNULL(IMPFTR.COD3,'') = ''
   AND    IMPFTR.NOADMISION = @NOADMISION

   --Se recalculan los valores GRUPO 03
   UPDATE IMPFTR SET IMPFTR.VALOR = X.VALOR
   FROM   IMPFTR INNER JOIN (SELECT  ITFC, COD2, TMP1, TMP2, SUM(VALOR) AS VALOR
                              FROM   IMPFTR
                              WHERE  IMPFTR.GRUPO            = '03'
                              AND    ISNULL(IMPFTR.COD1,'')  = ''
                              AND    ISNULL(IMPFTR.COD2,'') <> ''
                              AND    ISNULL(IMPFTR.COD3,'') <> ''  
                              AND    IMPFTR.NOADMISION = @NOADMISION
                              GROUP BY ITFC, COD2, TMP1, TMP2) X  ON IMPFTR.ITFC = X.ITFC AND ISNULL(IMPFTR.COD2,'') = ISNULL(X.COD2,'')
                                                                              AND ISNULL(IMPFTR.TMP1,'') = ISNULL(X.TMP1,'')
                                                                              AND ISNULL(IMPFTR.TMP2,'') = ISNULL(X.TMP2,'')
   WHERE  IMPFTR.GRUPO            = '03'
   AND    ISNULL(IMPFTR.COD1,'') = ''
   AND    ISNULL(IMPFTR.COD2,'') <> ''
   AND    ISNULL(IMPFTR.COD3,'') = ''
   AND    IMPFTR.NOADMISION = @NOADMISION

   UPDATE IMPFTR SET IMPFTR.VALOR = X.VALOR
   FROM   IMPFTR INNER JOIN (SELECT  ITFC, SUM(VALOR) AS VALOR
                              FROM   IMPFTR
                              WHERE  IMPFTR.GRUPO            = '03'
                              AND    ISNULL(IMPFTR.COD1,'')  = ''
                              AND    ISNULL(IMPFTR.COD2,'') <> ''
                              AND    ISNULL(IMPFTR.COD3,'') = ''
                              AND    IMPFTR.NOADMISION = @NOADMISION
                              GROUP BY ITFC) X  ON IMPFTR.ITFC = X.ITFC 
   WHERE  IMPFTR.GRUPO           = '03'
   AND    ISNULL(IMPFTR.COD1,'') <> ''
   AND    ISNULL(IMPFTR.COD2,'') = ''
   AND    ISNULL(IMPFTR.COD3,'') = ''
   AND    IMPFTR.NOADMISION = @NOADMISION
   
   --Se recalculan los valores GRUPO 04
   UPDATE IMPFTR SET IMPFTR.VALOR = X.VALOR
   FROM   IMPFTR INNER JOIN (SELECT  ITFC, COD2, SUM(VALOR) AS VALOR
                              FROM   IMPFTR
                              WHERE  IMPFTR.GRUPO            = '04'
                              AND    ISNULL(IMPFTR.COD1,'')  = ''
                              AND    ISNULL(IMPFTR.COD2,'') <> ''
                              AND    ISNULL(IMPFTR.COD3,'') <> ''
                              AND    IMPFTR.NOADMISION = @NOADMISION
                              GROUP BY ITFC, COD2) X  ON IMPFTR.ITFC = X.ITFC AND ISNULL(IMPFTR.COD2,'') = ISNULL(X.COD2,'')
   WHERE  IMPFTR.GRUPO            = '04'
   AND    ISNULL(IMPFTR.COD1,'') = ''
   AND    ISNULL(IMPFTR.COD2,'') <> ''
   AND    ISNULL(IMPFTR.COD3,'') = ''
   AND    IMPFTR.NOADMISION = @NOADMISION
   
   UPDATE IMPFTR SET IMPFTR.VALOR = X.VALOR
   FROM   IMPFTR INNER JOIN (SELECT  ITFC, SUM(VALOR) AS VALOR
                              FROM   IMPFTR
                              WHERE  IMPFTR.GRUPO            = '04'
                              AND    ISNULL(IMPFTR.COD1,'')  = ''
                              AND    ISNULL(IMPFTR.COD2,'') <> ''
                              AND    ISNULL(IMPFTR.COD3,'') = ''
                              AND    IMPFTR.NOADMISION = @NOADMISION
                              GROUP BY ITFC) X  ON IMPFTR.ITFC = X.ITFC 
   WHERE  IMPFTR.GRUPO            = '04'
   AND    ISNULL(IMPFTR.COD1,'') <> ''
   AND    ISNULL(IMPFTR.COD2,'') = ''
   AND    ISNULL(IMPFTR.COD3,'') = ''
   AND    IMPFTR.NOADMISION = @NOADMISION
