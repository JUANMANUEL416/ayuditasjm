
SELECT  * FROM FTRE WHERE FTRN_FACTURA IN(SELECT * FROM #A)

UPDATE FTRE SET NOTIFICADO=0,FECHA_NOTIFICADO=NULL WHERE FTRN_FACTURA IN(SELECT * FROM #A)

SELECT TOP 10 * FROM API_LOG WHERE USUARIO='JJIMENEZ' ORDER BY ITEM DESC

SELECT MARCA,EQUIMARCA,FECHA_PP, * FROM FTR WHERE N_FACTURA IN(SELECT * FROM #A)
FRONTEND

EXEC SPQ_JSON '{"MODELO":"FTR_PERU","METODO":"NOTIFICA_BOLETAS","USUARIO":"JJIMENEZ"}'


SELECT  * FROM FTR WHERE N_FACTURA='B004-00000056'

UPDATE FTRD SET CANTIDAD=1 WHERE N_FACTURA='B004-00000056'

EXEC SPQ_JSON '{"MODELO":"FTR_COL","METODO":"ENVIA_CONTAB","PARAMETROS":{"N_FACTURA":"B004-00000056"},"USUARIO":"JJIMENEZ"}'