

--SELECT  * FROM IHISD  INNER  JOIN IEXI ON IHISD.IDARTICULO=IEXI.IDARTICULO AND IHISD.IDBODEGA=IEXI.IDBODEGA AND IEXI.NOLOTE=IHISD.NOLOTE 
--WHERE IHISD.NOLOTE='01L00037746' AND CNSIHIS='20241011'

--SELECT * FROM IHIS WHERE CNSIHIS='20241011'
SELECT * FROM IHISD WHERE CNSIHIS='20241011'
AND IHISD.IDBODEGA='11'
AND IHISD.IDARTICULO='MDP000362-1'

<i class="fa-solid fa-chart-bar"></i>
<i class="fa-solid fa-file-excel"></i>

<i class="fa-solid fa-diagram-next"></i>

SELECT TOP 10 * FROM API_LOG WHERE USUARIO='JJIMENEZ' ORDER BY ITEM DESC

EXEC SPQ_JSON '{"MODELO":"INFOMRES_INV","METODO":"KARDEX_DESCARGA","PARAMETROS":{"ANO":"2024","MES":"10","BODEGA":"11"},"USUARIO":"JJIMENEZ"}'

SELECT *
FROM IMOV INNER JOIN IMOVH ON IMOV.CNSMOV=IMOVH.CNSMOV
WHERE IMOV.FECHACONF>='01/10/2024' AND IMOV.FECHACONF<'03/10/2024'
AND IMOVH.IDARTICULO='MDP000004-1'
AND IMOV.IDBODEGA='11'

SELECT DBO.FNK_FECHA_DDMMAA(FECHACONF)FECHA,SUM(ISAL.CANTIDAD)
FROM IMOV INNER JOIN ISAL ON IMOV.CNSMOV=ISAL.CNSMOV
WHERE IMOV.FECHACONF>='01/10/2024' AND IMOV.FECHACONF<'03/10/2024'
AND ISAL.IDARTICULO='MDP000004-1'
AND IMOV.IDBODEGA='11'
GROUP BY  DBO.FNK_FECHA_DDMMAA(FECHACONF)




SELECT *
FROM  IHISD INNER  JOIN IEXI ON IHISD.IDARTICULO=IEXI.IDARTICULO AND IHISD.IDBODEGA=IEXI.IDBODEGA AND IEXI.NOLOTE=IHISD.NOLOTE
          --INNER JOIN IART ON IHISD.IDARTICULO=IART.IDARTICULO
          --LEFT  JOIN IPAC ON IART.IDPRINACTIVO=IPAC.IDPRINACTIVO
          --LEFT  JOIN IFFA ON IART.IDFORFARM=IFFA.IDFORFARM
          --LEFT JOIN TGEN TR ON IART.CLASERIESGO=TR.CODIGO AND TR.TABLA='IART' AND TR.CAMPO='CLASERIESGO'
          --LEFT JOIN TGEN TP ON IART.PRECOMERCIAL=TP.CODIGO AND TP.TABLA='IART' AND TP.CAMPO='PRECOMERCIAL' 
          --LEFT JOIN TER ON     IART.IDFABRICANTE=TER.IDTERCERO
WHERE  EXISTS(SELECT * FROM IHIS WHERE IHIS.CNSIHIS=IHISD.CNSIHIS  AND IHIS.ANO='2024' AND IHIS.MES=10)
AND IHISD.IDBODEGA='11'
AND IHISD.IDARTICULO='MDP000362-1'
AND IHISD.CNSIHIS='20241011'