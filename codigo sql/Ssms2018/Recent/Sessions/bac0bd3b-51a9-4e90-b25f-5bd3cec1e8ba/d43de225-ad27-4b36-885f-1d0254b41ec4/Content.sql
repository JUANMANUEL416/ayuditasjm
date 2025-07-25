SELECT TOP 10 * FROM API_LOG WHERE USUARIO='JJIMENEZ' ORDER BY ITEM DESC

SELECT  * FROM ENTD WHERE CNSENTREGA='0200000429'

UPDATE TER SET RAZONSOCIAL='ENTIDAD PROMOTORA DE SALUD SANITAS S.A.S- EN INTERVENCIÓN  BAJO             LA MEDIDA DE TOMA DE POSESIÓN' WHERE IDTERCERO='800251440'

<i class="fa-regular fa-comment"></i>
EXEC SPQ_JSON '{"MODELO":"ENT_COL","METODO":"MOTIVO_ENTD","PARAMETROS":{"CNSENTREGA":"0200000429","MOTIVO":"pruebas  de soporte"},"USUARIO":"JJIMENEZ"}'

SELECT  ENT.CNSENTREGA,ENT.PROCESO,ENT.ENT_ENTREGA+' '+FDEP.NOMBRE DEPENDENCIA,ENT.USUARIOENTREGA+' '+USUSU.NOMBRE AS USENTREGA,CONVERT(VARCHAR,ENT.FECHAENTREGA,103) F_ENTREGA,                               ENT.ENT_RECIBE+' '+FDEP1.NOMBRE  AS USRECIBE,ENT.IDSEDE, COALESCE(ENT.MSEDE,0) REQSEDE, ENT.ENT_RECIBE,CASE COALESCE(ENT.ESTADO,0) WHEN 1 THEN 'Recibido' ELSE 'Pendiente' END ESTADO,                               CASE COALESCE(ENT.CERRADO,0) WHEN 1 THEN 'Cerrado' ELSE 'Abierto' END CERRADO,ENT.USUARIOENTREGA AS USUARIO    FROM [dbo].[ENT] INNER JOIN  FDEP ON ENT.ENT_ENTREGA=FDEP.IDDEP  LEFT JOIN  FDEP FDEP1 ON ENT.ENT_RECIBE=FDEP1.IDDEP  LEFT  JOIN USUSU ON ENT.USUARIOENTREGA=USUSU.USUARIO  WHERE ( CNSENTREGA LIKE '%%%%') AND  PROCESO='DEVFACT'  AND CONVERT(DATE,FECHAENTREGA)>='2024-05-28'  AND CONVERT(DATE,FECHAENTREGA)<='2024-05-28'   ORDER BY  FECHAENTREGA DESC OFFSET (1-1)*10 ROWS  FETCH NEXT 10 ROWS ONLY 


SELECT 
CNSFCT, FTR.N_FACTURA, PREFIJODIANFE, CNSDIANFE,DBO.FNK_FECHA_GRINGA(F_FACTURA)F_FACTURA, FTR.IDTERCERO, TER.NIT, RAZONSOCIAL,FTR.IDPLAN, FTR.FACTE,
CASE COALESCE(FTR.FACTE,0) WHEN 0 THEN 'Pendiente' WHEN 1 THEN 'EnCola' WHEN 2 THEN 'Notificada' WHEN 3 THEN 'Errores' WHEN 4 THEN 'Revision' ELSE 'NoDefinido' END ESTDIAN,
FTR.PROCEDENCIA,MARCA,EQUIMARCA,COALESCE(FDIAN.FTRELECTRONICA,0)FE,FTR.VR_TOTAL,
IDSEDE,IDPLAN,VR_TOTAL,FTRE.NOTIFICADO,FTRE.FECHA_NOTIFICADO 
FROM FTR INNER JOIN TER ON FTR.IDTERCERO=TER.IDTERCERO
         LEFT  JOIN FDIAN ON FTR.CNSRESOL=FDIAN.CNSRESOL
         LEFT  JOIN FTRE ON FTR.N_FACTURA=FTRE.FTRN_FACTURA AND FTR.PREFIJODIANFE=FTRE.PREFIJO AND FTR.CNSDIANFE=FTRE.N_FACTURA



SELECT CNSFCT, FTR.N_FACTURA, PREFIJODIANFE, CNSDIANFE,DBO.FNK_FECHA_GRINGA(F_FACTURA)F_FACTURA, FTR.IDTERCERO, TER.NIT, 
RAZONSOCIAL,FTR.IDPLAN, FTR.FACTE,                      
CASE COALESCE(FTR.FACTE,0) WHEN 0 THEN 'Pendiente' WHEN 1 THEN 'EnCola' WHEN 2 THEN 'Notificada' WHEN 3 THEN 'Errores' WHEN 4 THEN 'Revision' ELSE 'NoDefinido' END ESTDIAN, 
FTR.PROCEDENCIA,MARCA,EQUIMARCA,COALESCE(FDIAN.FTRELECTRONICA,0)FE,FTR.VR_TOTAL,
IDSEDE,IDPLAN,VR_TOTAL,FTRE.NOTIFICADO,FTRE.FECHA_NOTIFICADO    FROM [dbo].[FTR]
INNER JOIN  TER ON FTR.IDTERCERO=TER.IDTERCERO  
LEFT JOIN  FDIAN ON FTR.CNSRESOL=FDIAN.CNSRESOL  
LEFT  JOIN FTRE ON FTR.N_FACTURA=FTRE.FTRN_FACTURA 
AND FTR.PREFIJODIANFE=FTRE.PREFIJO AND FTR.CNSDIANFE=FTRE.N_FACTURA 
WHERE (TER.RAZONSOCIAL LIKE '%%%%' OR TER.NIT LIKE '%%%%' OR TER.IDPLAN LIKE '%%%%' OR  FTR.N_FACTURA LIKE '%%%%') AND  1=1  AND CONVERT(DATE, F_fACTURA) >=  '2024-05-28' AND CONVERT(DATE, F_fACTURA) <=  '2024-05-28'  ORDER BY FTR.CNSFCT  OFFSET (1-1)*10 ROWS  FETCH NEXT 10 ROWS ONLY 



SELECT CNSFCT, FTR.N_FACTURA, PREFIJODIANFE, CNSDIANFE,DBO.FNK_FECHA_GRINGA(F_FACTURA)F_FACTURA, FTR.IDTERCERO, TER.NIT, RAZONSOCIAL,FTR.IDPLAN, FTR.FACTE,                       CASE COALESCE(FTR.FACTE,0) WHEN 0 THEN 'Pendiente' WHEN 1 THEN 'EnCola' WHEN 2 THEN 'Notificada' WHEN 3 THEN 'Errores' WHEN 4 THEN 'Revision' ELSE 'NoDefinido' END ESTDIAN,                       FTR.PROCEDENCIA,MARCA,EQUIMARCA,COALESCE(FDIAN.FTRELECTRONICA,0)FE,FTR.VR_TOTAL,                       IDSEDE,FTRE.NOTIFICADO,DBO.FNK_FECHA_GRINGA(FTRE.FECHA_NOTIFICADO)FECHA_NOTIFICADO    FROM [dbo].[FTR] INNER JOIN  TER ON FTR.IDTERCERO=TER.IDTERCERO  LEFT JOIN  FDIAN ON FTR.CNSRESOL=FDIAN.CNSRESOL  LEFT  JOIN FTRE ON FTR.N_FACTURA=FTRE.FTRN_FACTURA AND FTR.PREFIJODIANFE=FTRE.PREFIJO AND FTR.CNSDIANFE=FTRE.N_FACTURA WHERE (TER.RAZONSOCIAL LIKE '%%%%' OR TER.NIT LIKE '%%%%' OR FTR.IDPLAN LIKE '%%%%' OR  FTR.N_FACTURA LIKE '%%%%') AND  FTR.FACTE=CASE WHEN COALESCE(FDIAN.FTRELECTRONICA,0)=0 THEN FTR.FACTE ELSE 2 END   AND CONVERT(DATE, F_fACTURA) >=  '2024-04-01' AND CONVERT(DATE, F_fACTURA) <=  '2024-05-28' AND COALESCE(FDIAN.FTRELECTRONICA,0) =0   ORDER BY FTR.CNSFCT  OFFSET (1-1)*10 ROWS  FETCH NEXT 10 ROWS ONLY 


{"MODELO":"FTR_COL","METODO":"LISTAR_FTRE","PARAMETROS":{"DATOS":{"F_INICIAL":"2022-01-27","F_FINAL":"2022-01-27","IDTERCERO":"","NIT":"","RAZONSOCIAL":"","N_FACTURA":"","ESTDIAN":"5-No FACTE","PROCEDENCIA":"Todas","TIPODOC":"Todas","IDSEDE":"Todas","IDPLAN":"","DESCPLAN":"","SINENVIO":false}},"USUARIO":"JJIMENEZ"}


EXEC SPQ_JSON '{"MODELO":"FTR_COL","METODO":"LISTA_EXPORFTR","PARAMETROS":{"DATOS":{"F_INICIAL":"2022-01-27","F_FINAL":"2022-01-27","IDTERCERO":"","NIT":"","RAZONSOCIAL":"","N_FACTURA":"","ESTDIAN":"Todas","PROCEDENCIA":"Todas","TIPODOC":"Todas","IDSEDE":"Todas","IDPLAN":"","DESCPLAN":"","SINENVIO":false}},"USUARIO":"JJIMENEZ"}'


SELECT CNSFCT, FTR.N_FACTURA, PREFIJODIANFE, CNSDIANFE,DBO.FNK_FECHA_GRINGA(F_FACTURA)F_FACTURA, FTR.IDTERCERO, TER.NIT, RAZONSOCIAL,FTR.IDPLAN, FTR.FACTE,                       CASE COALESCE(FTR.FACTE,0) WHEN 0 THEN 'Pendiente' WHEN 1 THEN 'EnCola' WHEN 2 THEN 'Notificada' WHEN 3 THEN 'Errores' WHEN 4 THEN 'Revision' ELSE 'NoDefinido' END ESTDIAN,                       FTR.PROCEDENCIA,MARCA,EQUIMARCA,COALESCE(FDIAN.FTRELECTRONICA,0)FE,FTR.VR_TOTAL,                       IDSEDE,FTRE.NOTIFICADO,DBO.FNK_FECHA_GRINGA(FTRE.FECHA_NOTIFICADO)FECHA_NOTIFICADO    FROM [dbo].[FTR] INNER JOIN  TER ON FTR.IDTERCERO=TER.IDTERCERO  LEFT JOIN  FDIAN ON FTR.CNSRESOL=FDIAN.CNSRESOL  LEFT  JOIN FTRE ON FTR.N_FACTURA=FTRE.FTRN_FACTURA AND FTR.PREFIJODIANFE=FTRE.PREFIJO AND FTR.CNSDIANFE=FTRE.N_FACTURA WHERE (TER.RAZONSOCIAL LIKE '%%%%' OR TER.NIT LIKE '%%%%' OR FTR.IDPLAN LIKE '%%%%' OR  FTR.N_FACTURA LIKE '%%%%') AND  FTR.FACTE=CASE WHEN COALESCE(FDIAN.FTRELECTRONICA,0)=0 THEN FTR.FACTE ELSE 2 END   AND CONVERT(DATE, F_fACTURA) >=  '2022-01-27' AND CONVERT(DATE, F_fACTURA) <=  '2022-01-27' AND NOTICLIENTE='SinEnviar'   ORDER BY FTR.CNSFCT  OFFSET (1-1)*10 ROWS  FETCH NEXT 10 ROWS ONLY 


<i class="fa-solid fa-truck-arrow-right"></i>