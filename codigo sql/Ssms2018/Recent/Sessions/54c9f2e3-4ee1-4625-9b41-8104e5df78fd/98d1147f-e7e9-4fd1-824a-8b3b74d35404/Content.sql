use kunipssam
UPDATE USUSU SET IDDEPURAR=1-COALESCE(IDDEPURAR,0) WHERE USUARIO='JJIMENEZ'

EXEC SPK_NC_CONTAB_FNOT '01C00000119','C','JJIMENEZ','CAJA002','01','02','0152200000042027'

SELECT  * FROM FNOT WHERE CNSFNOT='01C00000119'
SELECT  * FROM FNOTD WHERE CNSFNOT='01C00000119'

SELECT * FROM CPNT WHERE CODIGO='998'

SELECT TIPOTTEC,CUENTACXC,CUENTACXC_RAD, * FROM FTR WHERE N_FACTURA='UV10106'

SELECT  * FROM TTEC WHERE TIPO='EPSC'

SELECT * FROM FCXCDV WHERE N_FACTURA='UV10106'

UPDATE ISAL SET PCOSTO=VR_ANTESIVA WHERE COALESCE(PCOSTO,0)<0 AND COALESCE(VR_ANTESIVA,0)>0


SELECT * FROM ISAL WHERE CNSMOV='0100041884'
SELECT * FROM IMOVH WHERE CNSMOV='0100041884'

DELETE MCPE FROM MCPE INNER JOIN IMOV ON MCPE.NROCOMPROBANTE=IMOV.NROCOMPROBANTE 
WHERE NOT EXISTS(SELECT * FROM IMOVH WHERE IMOV.CNSMOV=IMOVH.CNSMOV)

DELETE MCHE WHERE NROCOMPROBANTE='0220600000114038'
DELETE MCPE WHERE NROCOMPROBANTE='0220600000114038'

SELECT  * FROM MCPE INNER JOIN IMOV ON MCPE.NROCOMPROBANTE=IMOV.NROCOMPROBANTE 
AND COALESCE(IMOV.CCOSTO,'')=''

UPDATE IMOV SET CCOSTO='505',IDAREA='4105' FROM MCPE INNER JOIN IMOV ON MCPE.NROCOMPROBANTE=IMOV.NROCOMPROBANTE 
AND COALESCE(IMOV.CCOSTO,'')=''