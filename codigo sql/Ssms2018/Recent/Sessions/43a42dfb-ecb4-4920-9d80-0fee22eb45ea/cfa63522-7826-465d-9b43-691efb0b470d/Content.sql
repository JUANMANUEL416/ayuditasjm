
SELECT TOP 10 *,IDSEDE FROM FCXC

SELECT FCXC.CNSCXC,FCXC.IDSEDE,CONVERT(VARCHAR,FCXC.FECHACXC,103)FECHACXC,COALESCE(CONVERT(VARCHAR,FCXC.FENVIO,103),'')FENVIO,TER.NIT,TER.RAZONSOCIAL,FCXC.VALORCXC ,
FCXC.VLRPAGOS,FCXC.VLRNOTACR,VLRNOTADB,VLRGLOSAS,FCXC.SALDONETO,FCXC.ESTADO
FROM FCXC INNER JOIN TER ON FCXC.IDTERCERO=TER.IDTERCERO

SELECT * FROM API_LOG ORDER BY ITEM DESC

<i class="fa-solid fa-arrow-down-wide-short"></i>
SELECT  FCXC.CNSCXC,FCXC.IDSEDE,CONVERT(VARCHAR,FCXC.FECHACXC,103)FECHACXC,COALESCE(CONVERT(VARCHAR,FCXC.F_RECIBIDO,103),'')F_RECIBIDO,TER.NIT,TER.RAZONSOCIAL,                               FCXC.VALORCXC,FCXC.VLRPAGOS,FCXC.VLRNOTACR,VLRNOTADB,VLRGLOSAS,FCXC.SALDONETO,FCXC.ESTADO   FROM [dbo].[FCXC] INNER JOIN  TER ON FCXC.IDTERCERO=TER.IDTERCERO  WHERE (RAZONSOCIAL LIKE '%%%%' OR NIT LIKE '%%%%' OR  CNSCXC LIKE '%%%%') AND 1=1 AND CONVERT(DATE,FECHACXC)>='2023-09-04'  AND CONVERT(DATE,FECHACXC)<='2023-09-04'   ORDER BY  CNSCXC DESC,IDSDE ASC OFFSET (1-1)*10 ROWS  FETCH NEXT 10 ROWS ONLY 


SELECT  FCXC.CNSCXC,FCXC.IDSEDE,CONVERT(VARCHAR,FCXC.FECHACXC,103)FECHACXC,COALESCE(CONVERT(VARCHAR,FCXC.F_RECIBIDO,103),'')F_RECIBIDO,TER.NIT,TER.RAZONSOCIAL,                               FCXC.VALORCXC,FCXC.VLRPAGOS,FCXC.VLRNOTACR,VLRNOTADB,VLRGLOSAS,FCXC.SALDONETO,FCXC.ESTADO   FROM [dbo].[FCXC] INNER JOIN  TER ON FCXC.IDTERCERO=TER.IDTERCERO  WHERE (RAZONSOCIAL LIKE '%%%%' OR NIT LIKE '%%%%' OR  CNSCXC LIKE '%%%%') AND 1=1 AND CONVERT(DATE,FECHACXC)>='2023-08-01'  AND CONVERT(DATE,FECHACXC)<='2023-09-05'  AND FCXC.IDTERCERO='900156264'  AND COALESCE(FCXC.CONTABILIZADA,0)=0  AND COALESCE(FCXC.ENPRESUPUESTO,0)=0  AND COALESCE(FCXC.ESTADO,)='Inactiva'   ORDER BY  CNSCXC DESC,IDSEDE ASC OFFSET (1-1)*10 ROWS  FETCH NEXT 10 ROWS ONLY 

SELECT  FCXC.CNSCXC,FCXC.IDSEDE,CONVERT(VARCHAR,FCXC.FECHACXC,103)FECHACXC,COALESCE(CONVERT(VARCHAR,FCXC.F_RECIBIDO,103),'')F_RECIBIDO,
TER.NIT,TER.RAZONSOCIAL,                               FCXC.VALORCXC,FCXC.VLRPAGOS,FCXC.VLRNOTACR,VLRNOTADB,VLRGLOSAS,
FCXC.SALDONETO,FCXC.ESTADO   FROM [dbo].[FCXC] INNER JOIN  TER ON FCXC.IDTERCERO=TER.IDTERCERO  
WHERE (RAZONSOCIAL LIKE '%%%%' OR NIT LIKE '%%%%' OR  CNSCXC LIKE '%%%%') AND 1=1 AND CONVERT(DATE,FECHACXC)>='2020-01-01'  
AND CONVERT(DATE,FECHACXC)<='2023-09-05'  
AND  EXISTS(SELECT * FROM FCXCD WHERE FCXCD.CNSCXC=FCXC.CNSCXC AND FCXCD.N_FACTURA='UV1360')    
ORDER BY  CNSCXC DESC,IDSEDE ASC OFFSET (1-1)*10 ROWS  FETCH NEXT 10 ROWS ONLY 


SELECT * FROM FCXCD