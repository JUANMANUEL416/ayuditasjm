
SELECT MCP.NROCOMPROBANTE  INTO #A  FROM MCP INNER JOIN MCH ON MCP.NROCOMPROBANTE=MCH.NROCOMPROBANTE
WHERE MCP.COMPROBANTE='08'
AND MCH.CUENTA LIKE '13%'

UPDATE MCP SET ESTADO=1 WHERE NROCOMPROBANTE IN(SELECT * FROM #A)


SELECT  * FROM MCPE WHERE PROCEDENCIA='CAJA' AND EXISTS(SELECT * FROM MCHE WHERE MCPE.NROCOMPROBANTE=MCHE.NROCOMPROBANTE)

DELETE  MCPE WHERE PROCEDENCIA='CAJA' AND NOT EXISTS(SELECT * FROM MCHE WHERE MCPE.NROCOMPROBANTE=MCHE.NROCOMPROBANTE)


SELECT  * FROM FCJ WHERE CNSACJ='01A00000733'