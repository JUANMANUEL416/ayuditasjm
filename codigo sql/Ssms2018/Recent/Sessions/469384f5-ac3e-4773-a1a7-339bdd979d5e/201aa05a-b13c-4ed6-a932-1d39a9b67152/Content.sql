select  * from pcj


use KUNIPSSAM

SELECT IDPLAN, * FROM FTR WHERE N_FACTURA='UV19500'

UPDATE FTRD SET IDPLAN='ASMPP'  WHERE N_FACTURA='UV20183'

SELECT * FROM TGEN WHERE CODIGO='ASMPGP'

INSERT INTO TGEN(TABLA,CAMPO,CODIGO,DESCRIPCION)
SELECT 'RIPS','RIPS_CAPAF_DETA','ASMPP','ASMET SALUD'


SELECT * FROM RRIPS_US WHERE ENVIO='000370'

UPDATE  RRIPS_US SET TIPOUSUARIO=2 WHERE ENVIO='000370'

use cem

UPDATE USUSU SET IDDEPURAR=1-IDDEPURAR WHERE USUARIO='JJIMENEZ'


SELECT VALORCOPAGO,TIPOCAJA,CODCAJA,NORECIBOCAJA,  * FROM CIT WHERE CONSECUTIVO='020081411526'

SELECT NROCOMPROBANTE, * FROM FCJ WHERE CODCAJA='C003' AND CNSFACJ='00000775'


SELECT PREFIJO,NCON.DESCRIPCION,IDAREA,CCOSTO,KMCOM.CUENTA
FROM KMCOM INNER JOIN NCON ON KMCOM.PREFIJO=NCON.CODCONCEPTO WHERE CCOSTO='30010103' AND KMCOM.TIPO='DB' AND IDTIPOCONT='NOMINA'

SELECT * FROM  KMCOM WHERE IDTIPOCONT='MOV_INVENTARIO'

SELECT * FROM HPRED WHERE IDPLAN='ASMPP' AND FACTURADA=0