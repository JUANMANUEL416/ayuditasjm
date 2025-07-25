

SELECT * INTO #A FROM DBO.RPT_ATENCIONES ( '20240101', '20240110', '0100000003', '' )
SELECT * INTO #A FROM DBO.RPT_ATENCIONES_1 ( '20240101', '20240110', '0100000003', '' )

DROP TABLE #A
exec sp_helptext'RIESGO_HCA'

SELECT  * FROM #A

SELECT NOADMISION,COUNT(*) FROM #A
GROUP BY NOADMISION
HAVING COUNT(*)>1

SELECT  * FROM #A WHERE NOADMISION='020091682633'

SELECT * FROM HCA WHERE CONSECUTIVOCIT='020091682633'
SELECT * FROM CIT WHERE CONSECUTIVO='020091682633'

SELECT * FROM CIT
      INNER JOIN ( SELECT CONSECUTIVO,FECHA,IDMEDICO,NOADMISION, CONSECUTIVOCIT,HCA.PROCEDENCIA, HCA.IDDX, MDX.DESCRIPCION, IDAFILIADO , MDX.CLASIF2 AS GRUPO_AUTOINMUNE  
         FROM HCA INNER JOIN MDX ON HCA.IDDX = MDX.IDDX  
          ) DX ON (COALESCE(DX.CONSECUTIVOCIT,DX.NOADMISION) = CIT.CONSECUTIVO  AND CAST(DX.FECHA AS DATE)= CAST(CIT.FECHA AS DATE) )  
         AND CIT.IDAFILIADO=DX.IDAFILIADO and DX.IDMEDICO=CIT.IDMEDICO AND DX.PROCEDENCIA NOT IN ('QX','AUDIT')  
WHERE CIT.CONSECUTIVO='030259686876'


SELECT *
FROM CIT   INNER JOIN TER   ON CIT.IDTERCEROCA  = TER.IDTERCERO  
     INNER JOIN AFI   ON CIT.IDAFILIADO = AFI.IDAFILIADO  
      LEFT JOIN PLN   ON CIT.IDPLAN     = PLN.IDPLAN  
      LEFT JOIN MED   ON MED.IDMEDICO   = CIT.IDMEDICO  
      LEFT JOIN MES ON MED.IDEMEDICA  = MES.IDEMEDICA  
      LEFT JOIN SER   ON CIT.IDSERVICIO = SER.IDSERVICIO  
            LEFT JOIN OCU   ON OCU.OCUPACION  = AFI.IDOCUPACION  
            LEFT JOIN CIU   ON AFI.CIUDAD     = CIU.CIUDAD  
      LEFT JOIN ( SELECT CONSECUTIVO,FECHA,IDMEDICO,NOADMISION, CONSECUTIVOCIT,HCA.PROCEDENCIA, HCA.IDDX, MDX.DESCRIPCION, IDAFILIADO , MDX.CLASIF2 AS GRUPO_AUTOINMUNE  
         FROM HCA INNER JOIN MDX ON HCA.IDDX = MDX.IDDX  
          ) DX ON (COALESCE(DX.CONSECUTIVOCIT,DX.NOADMISION) = CIT.CONSECUTIVO  OR CAST(DX.FECHA AS DATE)= CAST(CIT.FECHA AS DATE) )  
         AND CIT.IDAFILIADO=DX.IDAFILIADO and DX.IDMEDICO=CIT.IDMEDICO AND DX.PROCEDENCIA NOT IN ('QX','AUDIT')  
             LEFT JOIN DBO.VW_INTS_FN  ON  VW_INTS_FN.CONSECUTIVO=DX.CONSECUTIVO  
           LEFT  JOIN SED ON CASE WHEN COALESCE(CIT.IDSEDE,'')='' THEN '03' ELSE CIT.IDSEDE END = SED.IDSEDE  
            LEFT JOIN dbo.[DEFRUTA] X ON X.IDAFILIADO = CIT.IDAFILIADO --AND X.IDPESPECIAL = CASE WHEN CIT.CLASEORDEN = 'MODELO' THEN CIT.IDPESPECIAL ELSE X.IDPESPECIAL END  
          LEFT JOIN DBO.ULTIMA_HC_PSIQUIATRIA ULT ON ULT.IDAFILIADO = CIT.IDAFILIADO  
          LEFT JOIN DBO.[RUTA_SUICIDIO] MT ON MT.IDAFILIADO = CIT.IDAFILIADO  
          LEFT JOIN TGEN ON TGEN.TABLA = 'General' AND TGEN.CAMPO = 'GRUPOPOB' AND TGEN.CODIGO = AFI.GRUPOPOB  
          LEFT JOIN DBO.DXR  ON DXR.IDAFILIADO = CIT.IDAFILIADO  
          LEFT JOIN (SELECT CLASIF2 GRUPODX, MDX.  * FROM MDX) MDX1 ON DXR.[1] = MDX1.IDDX  
          LEFT JOIN (SELECT CLASIF2 GRUPODX, MDX.  * FROM MDX) MDX2 ON DXR.[2] = MDX2.IDDX  
          LEFT JOIN (SELECT CLASIF2 GRUPODX, MDX.  * FROM MDX) MDX3 ON DXR.[3] = MDX3.IDDX  
          LEFT JOIN AFI_X_PROGR ON AFI_X_PROGR.IDAFILIADO = CIT.IDAFILIADO  
          LEFT JOIN DBO.RIESGO_HCA_1 ('10/01/2024') RIESGO ON CIT.IDAFILIADO = RIESGO.IDAFILIADO  
          --LEFT JOIN DBO.REDAPOYO ('01/01/2023', '10/01/2023') RED_APOYO ON CIT.IDAFILIADO=RED_APOYO.IDAFILIADO  
WHERE CIT.CONSECUTIVO='030259686876'


SELECT  * FROM DBO.RIESGO_HCA ('10/01/2024','0200000621')  