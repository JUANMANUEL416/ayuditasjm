
SELECT *
FROM MCP INNER JOIN MCH ON MCP.NROCOMPROBANTE=MCH.NROCOMPROBANTE
WHERE ANO='2023'
AND MCH.CUENTA='32150202'


SELECT  * FROM MCHNIIF WHERE NROCOMPROBANTE='0202648658'

SELECT  * FROM MCPNIIF WHERE NROCOMPROBANTE='0202648658'