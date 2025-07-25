SELECT TOP 10 * FROM API_LOG WHERE USUARIO='JJIMENEZ' ORDER BY ITEM DESC

EXEC SPQ_JSON '{"MODELO":"INFOMRES_INV","METODO":"DETALLE_SALIDA","PARAMETROS":{"DATOS":{"IDBODEGA":"Todas","TIPOMOV":"Todos","F_INICIAL":"2023-01-01","F_FINAL":"2024-07-03","PCOSTO":3450,"IDARTICULO":"LI001-3","DESCRIPCION":"AGUA ESTERIL 500 ML [CORPAUL]"},"IDBODEGA":"02","IDTIPOMOV":"19"},"USUARIO":"JJIMENEZ"}'


SELECT DBO.FNK_FECHA_GRINGA(IMOV.FECHAMOV)FECHAMOV,DBO.FNK_FECHA_GRINGA(IMOV.FECHACONF)FECHACONF,IMOV.NODOCUMENTO,DBO.FNK_FECHA_GRINGA(IMOV.F_FACTURA)F_FACTURA,
       CONVERT(INT,IMOVH.CANTIDAD)CANTIDAD,CONVERT(DECIMAL(14,2),IMOVH.PCOSTO),IMOVH.NOLOTE,IMOVH.NOLOTEPEDIDO,IMOV.CNSFCOM,IMOV.CNSMOV,AFI.DOCIDAFILIADO,AFI.NOMBREAFI
            FROM IMOV INNER JOIN IMOVH ON IMOV.CNSMOV=IMOVH.CNSMOV
                      LEFT  JOIN HADM ON IMOV.NODOCUMENTO=HADM.NOADMISION
                      LEFT JOIN AFI   ON HADM.IDAFILIADO=AFI.IDAFILIADO
            WHERE IMOV.IDBODEGA='02'
            AND IMOV.IDTIPOMOV='02'
            AND IMOV.PROCEDENCIA='CM_SOL'



            IMOV:PROCEDENCIA='SALUD' OR IMOV:PROCEDENCIA='HTX'  OR  IMOV:PROCEDENCIA='FORMEDASIS' OR IMOV:PROCEDENCIA='CM_SOL'  OR IMOV:PROCEDENCIA='HBALI'

            SELECT  * FROM 