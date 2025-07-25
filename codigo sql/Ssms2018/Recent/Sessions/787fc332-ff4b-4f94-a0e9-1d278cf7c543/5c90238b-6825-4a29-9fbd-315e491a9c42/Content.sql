USE KPCEM

SELECT TOP 10 * FROM API_LOG WHERE USUARIO='JJIMENEZ' ORDER BY ITEM DESC

SELECT  ID = ROW_NUMBER() OVER (ORDER BY PROCEDENCIA, NOADMISION, NOPRESTACION, NOITEM),                               PROCEDENCIA,NOADMISION,CONVERT(VARCHAR,FECHA,103)FECHA ,PACIENTE,IDAFILIADO,IDSERVICIO,DESCSERVICIO,CONVERT(INT,CANTIDAD)CANTIDAD,                               CONVERT(DECIMAL(14,2),VALORTOTAL)VALORTOTAL,CONVERT(DECIMAL(14,2),VALORCOPAGO)VALORCOPAGO,                               CONVERT(DECIMAL(14,2),VALOREXCEDENTE)VALOREXCEDENTE,IDSEDE,NOITEM, MARCAFAC,USUMARCA  FROM [dbo].[VWK_CARGOS_HADMAUTCIT] WHERE (PROCEDENCIA LIKE '%%%%' OR PACIENTE LIKE '%%%%' OR  NOADMISION LIKE '%%%%') AND  1=1  AND IDTERCERO = '0100000007' AND IDPLAN='SAT01C' AND COALESCE(FACTURADA,0)=0   AND CONVERT(DATE,FECHA)>='2024-03-01T00:00:00.000Z' AND CONVERT(DATE,FECHA)<='2024-03-31T00:00:00.000Z'  AND PROCEDENCIA='AUT' AND IDSEDE='[object Object]'  ORDER BY PROCEDENCIA, NOADMISION, NOPRESTACION, NOITEM OFFSET (1-1)*8 ROWS  FETCH NEXT 8 ROWS ONLY 

BEGIN TRAN 
EXEC SPQ_JSON'{"MODELO":"FTR_COL","METODO":"ADDFTRDC","PARAMETROS":{"DATOS":{"CNSFTR":"0600017085","N_CUOTA":1,"IDTERCERO":"0100000007","IDPLAN":"SAT01C","FECHAINI":"2024-03-01T00:00:00.000Z","FECHAFIN":"2024-03-31T00:00:00.000Z","PROCEDENCIA":"TODA","CLASEORDEN":"","IDPESPECIAL":"","RIESGO":"","NOADMISION":"","PROCESO":"ADD","IDSEDE":null}},"USUARIO":"JJIMENEZ"}'

ROLLBACK

SELECT  * FROM FTRDC WHERE CNSFTR=''

SELECT  * FROM FTRDC WHERE CNSFTR='0600017085'

SELECT  ID = ROW_NUMBER() OVER (ORDER BY PROCEDENCIA, NOADMISION, NOPRESTACION, NOITEM),                               PROCEDENCIA,NOADMISION,CONVERT(VARCHAR,FECHA,103)FECHA ,PACIENTE,IDAFILIADO,IDSERVICIO,DESCSERVICIO,CONVERT(INT,CANTIDAD)CANTIDAD,                               CONVERT(DECIMAL(14,2),VALORTOTAL)VALORTOTAL,CONVERT(DECIMAL(14,2),VALORCOPAGO)VALORCOPAGO,                               CONVERT(DECIMAL(14,2),VALOREXCEDENTE)VALOREXCEDENTE,IDSEDE,NOITEM, MARCAFAC,USUMARCA  
FROM [dbo].[VWK_CARGOS_HADMAUTCIT] 
WHERE (PROCEDENCIA LIKE '%%%%' OR PACIENTE LIKE '%%%%' OR  NOADMISION LIKE '%%%%') 
AND  1=1  AND IDTERCERO = '0100000007' 
AND IDPLAN='SAT01C' 
AND COALESCE(FACTURADA,0)=0   
AND CONVERT(DATE,FECHA)>='2024-03-01T00:00:00.000Z' 
AND CONVERT(DATE,FECHA)<='2024-03-31T00:00:00.000Z'  

ORDER BY PROCEDENCIA, NOADMISION, NOPRESTACION, NOITEM OFFSET (1-1)*8 ROWS  FETCH NEXT 8 ROWS ONLY 