SELECT TOP 10 * FROM API_LOG WHERE USUARIO='JJIMENEZ' ORDER BY ITEM DESC

EXEC SPQ_JSON '{"MODELO":"NCINGRET_COL","METODO":"IMPRIMIR_LIQRET","PARAMETROS":{"CNSCERTI":"0100000001"},"USUARIO":"JJIMENEZ"}'


<i class="fa-solid fa-receipt"></i>

SELECT TOP 10 * FROM NIEPE

SELECT ROW_NUMBER() OVER(ORDER  BY CNSPAGO  DESC)ID, CNSPAGO,ANO,MES,NIEPE.NUMDOC,TER.NIT,NIEPE.NOMBRE_EMPLEADO,NOMBRE_CCOSTO,
         DETALLE_CARGO,BASICO,VALOR_INGRESOS,VALOR_EGRESOS,VALOR_NETO,VALOR_APORTES,TOTAL_NOMINA
FROM NIEPE LEFT JOIN TER ON NIEPE.NUMDOC=TER.IDTERCERO


SELECT CODCONCEPTO,ITEM,CODCONCEPTO,NOMBRE_CONCEPTO,TIPO, VALOR,VALOR_APORTES,TOTAL_NOMINA  
FROM NIEPED WHERE NIEPED.CNSNIEPE=NIEPE.CNSNIEPE AND NIEPED.NUMDOC=NIEPE.NUMDOC
ORDER BY ITEM


SELECT ROW_NUMBER() OVER(ORDER  BY CNSPAGO  DESC)ID,CNSPAGO,ANO,MES,TER.NIT,NIEPE.NUMDOC,NIEPE.NOMBRE_EMPLEADO,NOMBRE_CCOSTO,DETALLE_CARGO,
BASICO,VALOR_INGRESOS,VALOR_EGRESOS,VALOR_NETO,VALOR_APORTES,TOTAL_NOMINA,
DATOS = (             SELECT CODCONCEPTO,ITEM,NIEPED.CODCONCEPTO CONCEPTO,NOMBRE_CONCEPTO,TIPO, VALOR,VALOR_APORTES,TOTAL_NOMINA               
FROM NIEPED WHERE NIEPED.CNSNIEPE=NIEPE.CNSNIEPE AND NIEPED.NUMDOC=NIEPE.NUMDOC             
ORDER BY ITEM             FOR JSON PATH )  FROM [dbo].[NIEPE] INNER JOIN TER ON NIEPE.NUMDOC=TER.IDTERCERO  
WHERE (TER.NIT LIKE '%%%%' OR NIEPE.NOMBRE_EMPLEADO LIKE '%%%%') ORDER BY NIEPE.CNSPAGO,TER.NIT DESC OFFSET (1-1)*10 ROWS  FETCH NEXT 10 ROWS ONLY 