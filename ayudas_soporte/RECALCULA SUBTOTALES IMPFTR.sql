   --Se recalculan los valores GRUPO 01
   
   UPDATE IMPFTR SET IMPFTR.VALOR = X.VALOR
   FROM   IMPFTR INNER JOIN (SELECT ITFC, SUM(VALOR) AS VALOR
                             FROM   IMPFTR
                             WHERE  IMPFTR.GRUPO            = '01'
                             AND    ISNULL(IMPFTR.COD1,'')  = ''
                             AND    ISNULL(IMPFTR.COD2,'') <> ''
                             AND    IMPFTR.NOADMISION = '0100000552' AND COALESCE(N_FACTURA,'') = ''
                             GROUP BY ITFC) X  ON IMPFTR.ITFC = X.ITFC
   WHERE  IMPFTR.GRUPO            = '01'
   AND    IMPFTR.NOADMISION       = '0100000552' AND COALESCE(N_FACTURA,'') = ''
   AND    ISNULL(IMPFTR.COD1,'') <> ''
   
   -- Se recalculan los valores GRUPO 02
   UPDATE IMPFTR SET IMPFTR.VALOR = X.VALOR
   FROM   IMPFTR INNER JOIN (SELECT  ITFC, COD2, SUM(VALOR) AS VALOR
                              FROM   IMPFTR
                              WHERE  IMPFTR.GRUPO            = '02'
                              AND    ISNULL(IMPFTR.COD1,'')  = ''
                              AND    ISNULL(IMPFTR.COD2,'') <> ''
                              AND    ISNULL(IMPFTR.COD3,'') <> ''
                              AND    IMPFTR.NOADMISION = '0100000552' AND COALESCE(N_FACTURA,'') = ''
                              GROUP BY ITFC, COD2) X  ON IMPFTR.ITFC = X.ITFC AND ISNULL(IMPFTR.COD2,'') = ISNULL(X.COD2,'')
   WHERE  IMPFTR.GRUPO            = '02'
   AND    ISNULL(IMPFTR.COD1,'') = ''
   AND    ISNULL(IMPFTR.COD2,'') <> ''
   AND    ISNULL(IMPFTR.COD3,'') = ''
   AND    IMPFTR.NOADMISION = '0100000552' AND COALESCE(N_FACTURA,'') = ''
   
   UPDATE IMPFTR SET IMPFTR.VALOR = X.VALOR
   FROM   IMPFTR INNER JOIN (SELECT  ITFC, SUM(VALOR) AS VALOR
                              FROM   IMPFTR
                              WHERE  IMPFTR.GRUPO            = '02'
                              AND    ISNULL(IMPFTR.COD1,'')  = ''
                              AND    ISNULL(IMPFTR.COD2,'') <> ''
                              AND    ISNULL(IMPFTR.COD3,'') = ''
                              AND    IMPFTR.NOADMISION = '0100000552' AND COALESCE(N_FACTURA,'') = ''
                              GROUP BY ITFC) X  ON IMPFTR.ITFC = X.ITFC 
   WHERE  IMPFTR.GRUPO            = '02'
   AND    ISNULL(IMPFTR.COD1,'') <> ''
   AND    ISNULL(IMPFTR.COD2,'') = ''
   AND    ISNULL(IMPFTR.COD3,'') = ''
   AND    IMPFTR.NOADMISION = '0100000552' AND COALESCE(N_FACTURA,'') = ''

   --Se recalculan los valores GRUPO 03
   UPDATE IMPFTR SET IMPFTR.VALOR = X.VALOR
   FROM   IMPFTR INNER JOIN (SELECT  ITFC, COD2, TMP1, TMP2, SUM(VALOR) AS VALOR
                              FROM   IMPFTR
                              WHERE  IMPFTR.GRUPO            = '03'
                              AND    ISNULL(IMPFTR.COD1,'')  = ''
                              AND    ISNULL(IMPFTR.COD2,'') <> ''
                              AND    ISNULL(IMPFTR.COD3,'') <> ''  
                              AND    IMPFTR.NOADMISION = '0100000552' AND COALESCE(N_FACTURA,'') = ''
                              GROUP BY ITFC, COD2, TMP1, TMP2) X  ON IMPFTR.ITFC = X.ITFC AND ISNULL(IMPFTR.COD2,'') = ISNULL(X.COD2,'')
                                                                              AND ISNULL(IMPFTR.TMP1,'') = ISNULL(X.TMP1,'')
                                                                              AND ISNULL(IMPFTR.TMP2,'') = ISNULL(X.TMP2,'')
   WHERE  IMPFTR.GRUPO            = '03'
   AND    ISNULL(IMPFTR.COD1,'') = ''
   AND    ISNULL(IMPFTR.COD2,'') <> ''
   AND    ISNULL(IMPFTR.COD3,'') = ''
   AND    IMPFTR.NOADMISION = '0100000552' AND COALESCE(N_FACTURA,'') = ''

   UPDATE IMPFTR SET IMPFTR.VALOR = X.VALOR
   FROM   IMPFTR INNER JOIN (SELECT  ITFC, SUM(VALOR) AS VALOR
                              FROM   IMPFTR
                              WHERE  IMPFTR.GRUPO            = '03'
                              AND    ISNULL(IMPFTR.COD1,'')  = ''
                              AND    ISNULL(IMPFTR.COD2,'') <> ''
                              AND    ISNULL(IMPFTR.COD3,'') = ''
                              AND    IMPFTR.NOADMISION = '0100000552' AND COALESCE(N_FACTURA,'') = ''
                              GROUP BY ITFC) X  ON IMPFTR.ITFC = X.ITFC 
   WHERE  IMPFTR.GRUPO           = '03'
   AND    ISNULL(IMPFTR.COD1,'') <> ''
   AND    ISNULL(IMPFTR.COD2,'') = ''
   AND    ISNULL(IMPFTR.COD3,'') = ''
   AND    IMPFTR.NOADMISION = '0100000552' AND COALESCE(N_FACTURA,'') = ''
   
   --Se recalculan los valores GRUPO 04
   UPDATE IMPFTR SET IMPFTR.VALOR = X.VALOR
   FROM   IMPFTR INNER JOIN (SELECT  ITFC, COD2, SUM(VALOR) AS VALOR
                              FROM   IMPFTR
                              WHERE  IMPFTR.GRUPO            = '04'
                              AND    ISNULL(IMPFTR.COD1,'')  = ''
                              AND    ISNULL(IMPFTR.COD2,'') <> ''
                              AND    ISNULL(IMPFTR.COD3,'') <> ''
                              AND    IMPFTR.NOADMISION = '0100000552' AND COALESCE(N_FACTURA,'') = ''
                              GROUP BY ITFC, COD2) X  ON IMPFTR.ITFC = X.ITFC AND ISNULL(IMPFTR.COD2,'') = ISNULL(X.COD2,'')
   WHERE  IMPFTR.GRUPO            = '04'
   AND    ISNULL(IMPFTR.COD1,'') = ''
   AND    ISNULL(IMPFTR.COD2,'') <> ''
   AND    ISNULL(IMPFTR.COD3,'') = ''
   AND    IMPFTR.NOADMISION = '0100000552' AND COALESCE(N_FACTURA,'') = ''
   
   UPDATE IMPFTR SET IMPFTR.VALOR = X.VALOR
   FROM   IMPFTR INNER JOIN (SELECT  ITFC, SUM(VALOR) AS VALOR
                              FROM   IMPFTR
                              WHERE  IMPFTR.GRUPO            = '04'
                              AND    ISNULL(IMPFTR.COD1,'')  = ''
                              AND    ISNULL(IMPFTR.COD2,'') <> ''
                              AND    ISNULL(IMPFTR.COD3,'') = ''
                              AND    IMPFTR.NOADMISION = '0100000552' AND COALESCE(N_FACTURA,'') = ''
                              GROUP BY ITFC) X  ON IMPFTR.ITFC = X.ITFC 
   WHERE  IMPFTR.GRUPO            = '04'
   AND    ISNULL(IMPFTR.COD1,'') <> ''
   AND    ISNULL(IMPFTR.COD2,'') = ''
   AND    ISNULL(IMPFTR.COD3,'') = ''
   AND    IMPFTR.NOADMISION = '0100000552' AND COALESCE(N_FACTURA,'') = ''
