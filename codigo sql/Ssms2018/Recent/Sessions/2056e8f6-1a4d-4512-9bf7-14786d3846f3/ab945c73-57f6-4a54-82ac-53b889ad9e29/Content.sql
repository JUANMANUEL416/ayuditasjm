
SELECT FACTE, * FROM FTR WHERE N_FACTURA='UV14922'

UPDATE FTR SET FACTE=1 WHERE N_FACTURA='UV14922'

SELECT * FROM  FDIANR WHERE CNSDOCUMENTO='0200007885'

SELECT  N_FACTURA INTO #A FROM FTR WHERE F_FACTURA>='27/01/2024' AND F_FACTURA<'04/02/2024' AND IDTERCERO='800130907'

UPDATE FTR SET PDF=0 WHERE N_FACTURA IN(SELECT  * FROM #A)

SELECT GENEROCAJA,TIPOCAJA,CODCAJA,NORECIBOCAJA, * FROM CIT WHERE CONSECUTIVO='020000100191'

UPDATE CIT SET TIPOCAJA='TFCJ' WHERE VALORCOPAGO>0 AND TIPOCAJA IS NULL AND IDAFILIADO IS NOT NULL


SELECT  * FROM CIT WHERE VALORCOPAGO>0 AND TIPOCAJA IS NULL AND IDAFILIADO IS NOT NULL


SELECT * FROM FCXP WHERE CNSFCXP='02NM002044'


UPDATE MCP SET ESTADO=1,ANULADO=1 WHERE NROCOMPROBANTE='0237800000045234'
