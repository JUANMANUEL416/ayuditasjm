use KSANIPERU

SELECT TOP 10 * FROM API_LOG WHERE USUARIO='JJIMENEZ' ORDER BY ITEM DESC

<i class="fa-solid fa-ban"></i>
<i class="fa-solid fa-circle-check"></i>
<i class="fa-solid fa-envelope-circle-check"></i>
<i class="fa-solid fa-link"></i>
SELECT  IDKPAGE,KPAGE.CONSECUTIVO,KPAGE.PROCEDENCIA,DBO.FNK_FECHA_GRINGA(FECHAGEN)FECHAGEN,KPAGE.VALOR,KPAGE.ESTADO,KPAGE.USUCOBRA,KPAGE.RESPONSABLEPAGO,AFI.DOCIDAFILIADO,AFI.NOMBREAFI,LINKPAGO,paymentOrderId,COALESCE(REF_PAGO,'')N_FACTURA   FROM [dbo].[KPAGE] LEFT JOIN  AFI ON KPAGE.RESPONSABLEPAGO=AFI.IDAFILIADO WHERE (CONSECUTIVO LIKE '%%%%' OR AFI.NOMBREAFI LIKE '%%%%' OR AFI.DOCIDAFILIADO LIKE '%%%%') AND 1=1 AND CONVERT(DATE,FECHAGEN)>='2024-10-01' AND CONVERT(DATE,FECHAGEN)<='2024-10-01'  ORDER BY IDKPAGE DESC OFFSET (1-1)*10 ROWS  FETCH NEXT 10 ROWS ONLY 

EXEC SPQ_JSON '{"MODELO":"PASARELA_PAGOS","METODO":"ACTUALIZA_UNO","PARAMETROS":{"IDKPAGE":1160},"USUARIO":"JJIMENEZ"}'

EXEC SPQ_JSON '{"MODELO":"FTR_PERU","METODO":"NOTIFICA_BOLETAS","USUARIO":"JJIMENEZ"}'

EXEC SPQ_JSON '{"MODELO":"PASARELA_PAGOS","METODO":"ACTUALIZA_UNO","PARAMETROS":{"IDKPAGE":1162},"USUARIO":"JJIMENEZ"}'

SELECT  * FROM KPAGE WHERE IDKPAGE=1162

EXEC SPQ_JSON '{"MODELO":"LISTA_AUT","METODO":"APROBAR_ITEM","PARAMETROS":{"IDAUT":"0100000456","NO_ITEM":1},"USUARIO":"JJIMENEZ"}'


SELECT *  FROM AUTD WHERE IDAUT='0100000456'
SELECT  SUM()  FROM AUTD WHERE IDAUT='0100000456'

SELECT  * FROM AUT WHERE IDAUT='0100000456'