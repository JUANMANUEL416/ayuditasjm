SELECT PRI.ANO, PRI.MES, PRI.CERRADO, PRI.DESALDOSINICIALES 
FROM   PRI 
--WHERE  PRI.ANO >= ( SELECT ANO
--                    FROM   PRI
--                    WHERE  DESALDOSINICIALES = 1 )
ORDER BY PRI.ANO, PRI.MES
--
SELECT MCP.ANO, CASE WHEN MCP.MES < 10 THEN '0'+MES ELSE MES END AS MES, MCH.CUENTA, 
       CASE MCH.TIPO WHEN 'DB' THEN SUM(MCH.VALOR) ELSE 0 END AS DEBITOS,
       CASE MCH.TIPO WHEN 'CR' THEN SUM(MCH.VALOR) ELSE 0 END AS CREDITOS
FROM   MCP INNER JOIN MCH ON MCP.COMPANIA       = MCH.COMPANIA
                         AND MCP.NROCOMPROBANTE = MCH.NROCOMPROBANTE
WHERE  MCH.ESTADO = '2'
GROUP BY MCP.ANO, MCP.MES, MCH.CUENTA, MCH.TIPO
ORDER BY MCP.ANO, MCP.MES, MCH.CUENTA
--
SELECT CUE.CUENTA, X.ANO, X.MES, SUM(X.DEBITOS) AS DEBITOS, SUM(X.CREDITOS) AS CREDITOS, 
       CASE NTZ.TIPO WHEN 'DB' THEN SUM(X.DEBITOS - X.CREDITOS) ELSE SUM(X.CREDITOS - X.DEBITOS) END AS SALDOPERIODO
FROM   CUE LEFT JOIN (
                        SELECT MCP.ANO, CASE WHEN MCP.MES < 10 THEN '0'+MES ELSE MES END AS MES, MCH.CUENTA, 
                               CASE MCH.TIPO WHEN 'DB' THEN SUM(MCH.VALOR) ELSE 0 END AS DEBITOS,
                               CASE MCH.TIPO WHEN 'CR' THEN SUM(MCH.VALOR) ELSE 0 END AS CREDITOS
                        FROM   MCP INNER JOIN MCH ON MCP.COMPANIA       = MCH.COMPANIA
                                                 AND MCP.NROCOMPROBANTE = MCH.NROCOMPROBANTE
                        GROUP BY MCP.ANO, MCP.MES, MCH.CUENTA, MCH.TIPO

                      ) X ON CUE.CUENTA = X.CUENTA
           INNER JOIN NTZ ON LEFT(CUE.CUENTA,1) = NTZ.N_INICIAL
WHERE CUE.TIPO = 'Detalle'
GROUP BY CUE.CUENTA, X.ANO, X.MES, NTZ.TIPO
ORDER BY X.ANO, X.MES, CUE.CUENTA

   DECLARE @ANO VARCHAR(4)
   DECLARE @MES INT
   DECLARE PRI_CURSOR CURSOR FOR  
   SELECT PRI.ANO, PRI.MES 
   FROM   PRI 
   WHERE  PRI.ANO >= ( SELECT ANO
                       FROM   PRI
                       WHERE  DESALDOSINICIALES = 1 )
   OPEN    PRI_CURSOR  
   FETCH NEXT FROM PRI_CURSOR  
   INTO  @ANO, @MES
   WHILE @@FETCH_STATUS = 0  
   BEGIN  
--
                SELECT CUE.CUENTA, SUM(X.DEBITOS), SUM(X.CREDITOS), CASE NTZ.TIPO WHEN 'DB' THEN SUM(X.DEBITOS - X.CREDITOS) ELSE SUM(X.CREDITOS - X.DEBITOS) END AS SALDOPERIODO
                FROM   CUE LEFT JOIN (
                                        SELECT MCP.ANO, CASE WHEN MCP.MES < 10 THEN '0'+MES ELSE MES END AS MES, MCH.CUENTA, 
                                               CASE MCH.TIPO WHEN 'DB' THEN SUM(MCH.VALOR) ELSE 0 END AS DEBITOS,
                                               CASE MCH.TIPO WHEN 'CR' THEN SUM(MCH.VALOR) ELSE 0 END AS CREDITOS
                                        FROM   MCP INNER JOIN MCH ON MCP.COMPANIA       = MCH.COMPANIA
                                                                 AND MCP.NROCOMPROBANTE = MCH.NROCOMPROBANTE
                                        WHERE  MCP.ESTADO = '2'
                                        GROUP BY MCP.ANO, MCP.MES, MCH.CUENTA, MCH.TIPO

                                      ) X ON CUE.CUENTA = X.CUENTA
                           INNER JOIN NTZ ON LEFT(CUE.CUENTA,1) = NTZ.N_INICIAL
                WHERE CUE.TIPO = 'Detalle'
                GROUP BY CUE.CUENTA, NTZ.TIPO 
                ORDER BY CUE.CUENTA
--      
      FETCH NEXT FROM PRI_CURSOR  
      INTO  @ANO, @MES
   END
   CLOSE PRI_CURSOR
   DEALLOCATE PRI_CURSOR

