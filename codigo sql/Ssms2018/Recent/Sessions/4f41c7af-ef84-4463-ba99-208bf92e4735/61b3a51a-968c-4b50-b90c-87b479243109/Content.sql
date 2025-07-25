USE KSANIPERU

SELECT TOP 10 * FROM API_LOG WHERE USUARIO='JJIMENEZ' ORDER BY ITEM DESC


SELECT ROW_NUMBER() OVER(ORDER  BY AUTD.IDAUT,AUTD.NO_ITEM  ASC)ID, 
AUT.PREFIJO,PRE.NOM_PREFIJO,AUTD.NO_ITEM,AUTD.IDAUT,AUTD.IDSERVICIO,                         
SER.DESCSERVICIO,AUTD.CANTIDAD,AUTD.VALOR,(AUTD.VALOR*AUTD.CANTIDAD)SUBTOTAL,AUTD.VALORCOPAGO,AUTD.VALOREXCEDENTE,AUTD.N_FACTURA,
COALESCE(PROTOCOLO,0) PROTOCOLO,  CASE WHEN COALESCE(AUTD.ENLAB,0)=1 THEN 
CASE WHEN EXISTS(SELECT * FROM  LING INNER JOIN LORD ON LING.NOINGRESO=LORD.NOINGRESO                               
WHERE LING.NOPRESTACION=AUT.NOAUT AND LORD.ESTADO='R') THEN 1 ELSE 2 END ELSE 1 END RESUL   
FROM [dbo].[AUTD] INNER JOIN  AUT ON AUTD.IDAUT=AUT.IDAUT INNER JOIN 
SER ON AUTD.IDSERVICIO=SER.IDSERVICIO  
INNER JOIN PRE ON AUT.PREFIJO=PRE.PREFIJO 
WHERE (AUT.PREFIJO LIKE '%%%%') AND  AUT.CONSECUTIVOCIT='010496936449'
AND COALESCE(AUTD.GENERADO,0)=1  
ORDER BY AUTD.IDAUT,AUTD.NO_ITEM  ASC OFFSET (1-1)*10 ROWS  FETCH NEXT 10 ROWS ONLY 

SELECT * FROM AUT WHERE CONSECUTIVOCIT='010496936449'

SELECT  * FROM TGEN WHERE CODIGO='KERALTY'


SELECT  * FROM TGEN WHERE CAMPO='APOYO'


EXEC SPQ_JSON '{"MODELO":"FTR_RPT_COL","METODO":"GENERAR_RPT","PARAMETROS":{"PROCESO":"Todo","DATOS":{"F_INICIAL":"2024-11-01","F_FINAL":"2025-01-09","IDTERCERO":null,"NIT":null,"RAZONSOCIAL":null,"IDPLAN":null,"DESCPLAN":null,"PARTICULAR":"Todos","IDSEDE":"Todas","PROCEDENCIA":"Todas","USUARIOFACTU":null,"NOMBREUSUARIO":null,"TERCONTABLE":null,"DESCTERCONTA":null,"AREAFUNCIONAL":null,"DESCAFUNCIONAL":null,"PREFIJO":null,"NOM_PREFIJO":null,"IDSERVICIO":null,"DESCSERVICIO":null,"ANULADAS":null,"NOTACR":null}},"USUARIO":"JJIMENEZ"}'

SELECT  * FROM USVGS WHERE DESCRIPCION LIKE '%LABORATORIO%'

<i class="fa-solid fa-calendar-days"></i>
<i class="fa-solid fa-plus"></i>

SELECT HADM.NOADMISION,DBO.FNK_FECHA_GRINGA(HADM.FECHA)FECHA,AFI.DOCIDAFILIADO,AFI.NOMBREAFI,TER.NIT,TER.RAZONSOCIAL,HADM.IDPLAN,PLN.DESCPLAN
FROM HADM INNER JOIN AFI ON HADM.IDAFILIADO=AFI.IDAFILIADO
          INNER JOIN TER ON HADM.IDTERCERO=TER.IDTERCERO
          INNER JOIN PLN ON HADM.IDPLAN=PLN.IDPLAN
WHERE COALESCE(PLN.CRONICO,0)=1


SELECT IDPPTCRO,PPTCRO.IDTERCERO,TER.NIT,TER.RAZONSOCIAL,PPTCRO.IDPLAN,PLN.DESCPLAN,
ANIO,MES,PPTCRO.VALOR,PPTCRO.IDSERVICIO,SER.DESCSERVICIO
FROM PPTCRO INNER JOIN TER ON PPTCRO.IDTERCERO=TER.IDTERCERO
            INNER JOIN PLN ON PPTCRO.IDPLAN=PLN.IDPLAN
            LEFT  JOIN SER ON PPTCRO.IDSERVICIO=SER.IDSERVICIO
