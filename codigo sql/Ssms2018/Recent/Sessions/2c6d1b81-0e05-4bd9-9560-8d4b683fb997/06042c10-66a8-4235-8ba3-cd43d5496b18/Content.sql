use kpcem


select * from fcj where clase_fac='pago'

select * from acj where CODCAJA='C007'

select  * from ususu where USUARIO='1007933070'

SELECT TOP 10 * FROM API_LOG WHERE USUARIO='JJIMENEZ' ORDER BY ITEM DESC


EXEC SPQ_JSON '{"MODELO":"CONF_CAJA","METODO":"IMPRIME_CONTA_EGRESO","PARAMETROS":{"CODCAJA":"C007","CNSFACJ":"E00000120","CNSACJ":"01A00000039"},"USUARIO":"JJIMENEZ"}'

SELECT CONTABILIZADA,NROCOMPROBANTE, * FROM FCJ WHERE CNSFACJ='E00000120' AND CODCAJA='C007'

SELECT LEN('30.0000 PAGADOS A HUMBERTO SERNA POR DOMICILIO DE PAPEL HIGIENICO,.MUESTRAS Y UN TALONARIO')

use KSANLUIS

SELECT  FTR.N_FACTURA,CASE WHEN COALESCE(FTR.MARCA,0)=1 THEN 'X-'+FTR.EQUIMARCA ELSE '' END MARCA,TER.NIT AS IDTERCERO, TER.RAZONSOCIAL,CONVERT(VARCHAR,FTR.F_FACTURA,103)F_FACTURA,FTR.PROCEDENCIA,FTR.IDPLAN,PLN.DESCPLAN   FROM [dbo].[FTR] INNER JOIN  TER ON FTR.IDTERCERO=TER.IDTERCERO INNER JOIN PLN ON FTR.IDPLAN=PLN.IDPLAN WHERE ( FTR.N_FACTURA LIKE '%%%%') AND  FTR.ESTADO='P' AND COALESCE(CLASEANULACION,'')<>'NC' AND COALESCE(VR_TOTAL,0)>0 AND COALESCE(CONTABILIZADA,0)<>0                   AND NOT EXISTS(SELECT * FROM FCXCD WHERE FCXCD.N_FACTURA=FTR.N_FACTURA)                   AND COALESCE(INDCARTERA,0)=1 AND IDDEP=DBO.FNK_VALORVARIABLE('IDFDEPCARTERA')                    AND NOT EXISTS(SELECT * FROM ENT INNER JOIN ENTD ON ENT.CNSENTREGA=ENTD.CNSENTREGA WHERE ENT.PROCESO='DEVFACT'                    AND ENT.ESTADO=0 AND ENTD.NODOCUMENTO=FTR.N_FACTURA) AND CONVERT(DATE, F_fACTURA) <=  '2024-03-31' AND FTR.IDTERCERO  =  '0100000003'  ORDER BY  FTR.CNSFCT  OFFSET (1-1)*7 ROWS  FETCH NEXT 7 ROWS ONLY 

SELECT * FROM ENTD WHERE NODOCUMENTO='FV13527'
SELECT TOP 10 * FROM HBALID
SELECT DISTINCT tipo FROM HBALID

SELECT *  FROM NESIGVIT

SELECT IDS,ID,NOADMISION,CONSECUTIVO,CLASEPLANTILLA,CLASE,DESCLASE,DBO.FNK_FECHA_GRINGA(FECHA)FECHA,
IDMEDICO,NOMBRE,DESCRIPCION  FROM [dbo].[VWK_SOPORTES_HADM] WHERE (CLASEPLANTILLA LIKE '%%%%') AND 
NOADMISION='0100349094'   ORDER BY ID ASC,CLASE  OFFSET (1-1)*10 ROWS  FETCH NEXT 10 ROWS ONLY 


SELECT  * FROM DOCXTPO


SELECT  * FROM HBALI WHERE NOADMISION='0100348960'


SELECT  * FROM VWK_SOPORTES_HADM  WHERE NOADMISION='0100348960'


SELECT  FTR.N_FACTURA,CASE WHEN COALESCE(FTR.MARCA,0)=1 THEN 'X-'+FTR.EQUIMARCA ELSE '' END MARCA,TER.NIT AS IDTERCERO, 
TER.RAZONSOCIAL,CONVERT(VARCHAR,FTR.F_FACTURA,103)F_FACTURA,FTR.PROCEDENCIA,FTR.IDPLAN,PLN.DESCPLAN   
FROM [dbo].[FTR] INNER JOIN  TER ON FTR.IDTERCERO=TER.IDTERCERO 
INNER JOIN PLN ON FTR.IDPLAN=PLN.IDPLAN 
WHERE ( FTR.N_FACTURA LIKE '%FV13527%') 
AND  FTR.ESTADO='P' AND COALESCE(CLASEANULACION,'')<>'NC' 
AND COALESCE(VR_TOTAL,0)>0 AND COALESCE(CONTABILIZADA,0)<>0                   
AND NOT EXISTS(SELECT * FROM FCXCD WHERE FCXCD.N_FACTURA=FTR.N_FACTURA)                   
AND COALESCE(INDCARTERA,0)=1 AND IDDEP=DBO.FNK_VALORVARIABLE('IDFDEPCARTERA')                    
AND NOT EXISTS(SELECT * FROM ENT INNER JOIN ENTD ON ENT.CNSENTREGA=ENTD.CNSENTREGA WHERE ENT.PROCESO='DEVFACT' 
AND ENT.ESTADO=0 AND ENTD.NODOCUMENTO=FTR.N_FACTURA) 
AND CONVERT(DATE, F_fACTURA) <=  '2024-03-31' 
AND FTR.IDTERCERO  =  '0100000003' 
AND EXISTS(SELECT * FROM ENTD WHERE ENTD.NODOCUMENTO=FTR.N_FACTURA AND PROCESO='FACTURAS' AND CNSENTREGA LIKE '%%')   
ORDER BY  FTR.CNSFCT  OFFSET (1-1)*7 ROWS  FETCH NEXT 7 ROWS ONLY 