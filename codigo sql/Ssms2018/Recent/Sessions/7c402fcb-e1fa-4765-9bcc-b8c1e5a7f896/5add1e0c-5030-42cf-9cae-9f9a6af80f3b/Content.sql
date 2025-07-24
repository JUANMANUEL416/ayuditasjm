USE PUNIPSSAM

UPDATE USUSU SET IDDEPURAR=1-IDDEPURAR WHERE USUARIO='JJIMENEZ'

SELECT TOP 10 * FROM API_LOG WHERE USUARIO='JJIMENEZ' ORDER BY ITEM DESC

EXEC SPQ_JSON '{"MODELO":"FPAG_COL","METODO":"INSERTAR","PARAMETROS":{"IDSEDE":"02","INGRESO":"BANCOS","BANCO":"01","SUCURSAL":"01","CTA_BCO":"52462204728","ITEM":644,"RENGLON":1,"NOCONTABILIZA":0,"FECHA":"28-01-2025","IDTERCERO":"900156264","FECHAPAGO":"12-02-2023","NUMERODOCUMENTO":null,"VALORPAGO":"107748500","VLRGLOSAS":"0","VLRIMPUESTOS":"0","VLRAJUSTEPESO":"0","DTOFNCIERO":"0","VLRDTOFINAN":"0","OBSERVACION":"Pruebas de desarrollo"},"USUARIO":"JJIMENEZ"}'

SELECT CONCAT(BMOVD.BANCO,BMOVD.SUCURSAL,BMOVD.CTA_BCO, BMOVD.ITEM) AS ITEMTB
,      BMOVD.BANCO                                                 
,      BCO.DESCRIPCION                                              AS BANCODESC
,      BMOVD.SUCURSAL                                              
,      BSU.DESCRIPCION                                              AS SUCURSALDESC
,      BMOVD.CUENTA                                                
,      BMOVD.CTA_BCO                                               
,      BMOVD.ITEM                                                  
,      BMOVD.RENGLON                                               
,      BMOVD.FORMAPAGO                                             
,      FPA.DESCRIPCION                                              AS FORMAPAGODESC
,      BMOVD.NODOCUMENTO                                           
,      BMOVD.VLRITEM                                               
,      CONVERT(VARCHAR(19), BMOVD.VLRITEM)                          AS VLRITEM2
,      BMOVD.VLRLEGALIZADO                                         
,      (ISNULL(BMOVD.VLRITEM,0) - ISNULL(BMOVD.VLRLEGALIZADO,0))    AS PORLEGALIZAR
,      FORMAT(BMOV.FECHAOPERACION, 'yyyy-MM-dd')                    AS FECHAOPERACION
,      CONVERT(varchar, BMOV.FECHAOPERACION, 103)                   AS FECHAOPERA
FROM       [dbo].[BMOVD]
INNER JOIN BMOV          ON BMOVD.ITEM = BMOV.ITEM AND BMOVD.BANCO = BMOV.BANCO
INNER JOIN BCO           ON BMOVD.BANCO = BCO.BANCO
INNER JOIN BSU           ON BMOVD.SUCURSAL = BSU.SUCURSAL AND BMOVD.BANCO = BSU.BANCO
INNER JOIN FPA           ON BMOVD.FORMAPAGO = FPA.FORMAPAGO
WHERE (BMOVD.CTA_BCO LIKE '%%%%') AND BMOVD.IDTERCERO = '900156264' AND BMOVD.RECAUDO = 1 AND ISNULL(BMOVD.ENPAGOS,0) = 0 AND BMOV.ESTADO = 'O' AND (ISNULL(BMOVD.VLRITEM,0) - ISNULL(BMOVD.VLRLEGALIZADO,0)) > 0
ORDER BY BMOV.FECHAOPERACION ASC OFFSET (1-1)*10 ROWS FETCH NEXT 10 ROWS ONLY
