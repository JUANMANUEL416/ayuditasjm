SELECT MCH.CUENTA, SDMTF.CUENTA, MCH.DEBITOS, SDMTF.DB, MCH.CREDITOS, SDMTF.CR
FROM   (
         SELECT MCH.CUENTA, DEBITOS=SUM(CASE WHEN MCH.TIPO='DB' THEN VALOR ELSE 0 END), 
                CREDITOS=SUM(CASE WHEN MCH.TIPO='CR' THEN VALOR ELSE 0 END)
         FROM   KCIELD1011..MCP MCP INNER JOIN KCIELD1011..MCH MCH ON MCP.COMPANIA=MCH.COMPANIA AND MCP.NROCOMPROBANTE=MCH.NROCOMPROBANTE 
         WHERE  MCP.ESTADO   = 2 AND ISNULL(MCP.ANULADO,0)=0 
         AND    MCP.ANO      = '2012' 
         AND    MCP.MES      = 12
         GROUP BY MCH.CUENTA
        ) MCH LEFT JOIN (
                           SELECT CUENTA, SUM(DB) DB, SUM(CR) CR
                           FROM   SALDOMESTERFAC 
                           WHERE  ANO = '2012' 
                           AND    MES = 12
                           GROUP BY CUENTA
                         ) SDMTF ON MCH.CUENTA COLLATE DATABASE_DEFAULT= SDMTF.CUENTA COLLATE DATABASE_DEFAULT
WHERE DEBITOS <> DB
OR    CREDITOS <> CR
ORDER BY MCH.CUENTA
---------------------------------------
SELECT MCH.NROCOMPROBANTE, SUM(CASE TIPO WHEN 'DB' THEN VALOR ELSE 0 END) DB, 
                           SUM(CASE TIPO WHEN 'CR' THEN VALOR ELSE 0 END) CR 
FROM   MCH INNER JOIN MCP ON MCP.COMPANIA=MCH.COMPANIA 
                         AND MCP.NROCOMPROBANTE=MCH.NROCOMPROBANTE 
AND    MCP.ANO = '2012'
AND    MCP.MES = 5
AND    MCP.ESTADO   = 2 
AND    COALESCE(MCP.ANULADO,0)=0
GROUP BY MCH.NROCOMPROBANTE
HAVING SUM(CASE TIPO WHEN 'DB' THEN VALOR ELSE 0 END) <> SUM(CASE TIPO WHEN 'CR' THEN VALOR ELSE 0 END)


---------------------------------------
SELECT * FROM MCP  WHERE NROCOMPROBANTE = '0101204619'
SELECT SUM(CASE TIPO WHEN 'DB' THEN VALOR ELSE 0 END) DB, SUM(CASE TIPO WHEN 'CR' THEN VALOR ELSE 0 END) CR FROM MCH WHERE NROCOMPROBANTE = '0101204619'

SELECT 2043296.00	- 2051514.00 -- -8218.00

SELECT * FROM MCH WHERE NROCOMPROBANTE = '0101204619'  ORDER BY TIPO,  VALOR, IDTERCERO, CUENTA



SELECT * FROM MCH 
WHERE NROCOMPROBANTE = '0100802974' 
AND   EXISTS (SELECT CUENTA, IDTERCERO, COUNT(*) FROM MCH X WHERE NROCOMPROBANTE = '0100802974' AND TIPO = 'CR' AND MCH.NROCOMPROBANTE = X.NROCOMPROBANTE 
              AND MCH.CUENTA = X.CUENTA AND MCH.IDTERCERO = X.IDTERCERO  GROUP BY CUENTA, IDTERCERO HAVING COUNT(*) > 1)

SELECT CUENTA, IDTERCERO, COUNT(*) FROM MCH X WHERE NROCOMPROBANTE = '0100802974' AND TIPO = 'CR'   GROUP BY CUENTA, IDTERCERO HAVING COUNT(*) > 1

SELECT * FROM MCH WHERE NROCOMPROBANTE = '0100802974' AND TIPO = 'CR' AND CUENTA LIKE '1305%'

8796138, 8798524

SELECT --83.00+
283.00+
39735.00+
3717.00+
--627.00+
13450.00

SELECT 131 + 39735.00 + 3717.00 + 13450.00