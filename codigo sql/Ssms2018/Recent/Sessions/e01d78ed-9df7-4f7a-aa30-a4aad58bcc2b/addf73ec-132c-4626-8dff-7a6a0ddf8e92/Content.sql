
SELECT FACTURADA,N_FACTURA, * FROM AUTD WHERE N_FACTURA='F002-00002471'
SELECT FACTURADA,N_FACTURA, * FROM AUT WHERE N_FACTURA='F002-00002471'

SELECT  * FROM FTR WHERE N_FACTURA='F002-00002471'
SELECT  * FROM FTRD WHERE N_FACTURA='F002-00002471'

UPDATE  AUTD SET FACTURADA=0,N_FACTURA=NULL WHERE N_FACTURA='F002-00002473'
UPDATE  AUT SET FACTURADA=0,N_FACTURA=NULL WHERE N_FACTURA='F002-00002473'

EXEC SPK_ANULA_FACT

SELECT TOP 10 * FROM API_LOG WHERE USUARIO='JJIMENEZ' ORDER BY ITEM DESC



EXEC SPQ_JSON '{"MODELO":"FTR_PERU","METODO":"FACTURAR_CITAUT","PARAMETROS":{"CONSECUTIVO":"010656085507"},"USUARIO":"FRODRIGUEZ"}'

SELECT * FROM CIT WHERE CONSECUTIVO='010656085507'

SELECT AUTD.ESDELAB,AUTD.ENLAB, COALESCE(APOYODG_AMBITO,''),
CASE WHEN COALESCE(AUTD.ESDELAB,0)=1 THEN CASE WHEN COALESCE(AUTD.ENLAB,0)=2 THEN 1 ELSE 0 END 
                              ELSE CASE WHEN COALESCE(APOYODG_AMBITO,'')<> '' AND COALESCE(AUTD.ENLAB,0) = 2  THEN 1
                                    WHEN COALESCE(APOYODG_AMBITO,'')<> '' AND COALESCE(AUTD.ENLAB,0)<> 2  THEN 0 ELSE 1 END END 
					FROM   AUT INNER JOIN AUTD ON AUTD.IDAUT     = AUT.IDAUT 
								INNER JOIN SER  ON SER.IDSERVICIO = AUTD.IDSERVICIO 
								LEFT JOIN TER  ON TER.IDTERCERO  = AUTD.IDTERCEROCA
					WHERE  AUT.CONSECUTIVOCIT = '010656085507'             
						AND AUTD.IDPLAN='PAQ025'
                  AND COALESCE(AUTD.NOCOBRABLE,0)=0
                  AND COALESCE(AUTD.GENERADO,0)=1
                 -- AND COALESCE(AUTD.FACTURADA,0)=0
                  AND COALESCE(AUTD.VALOR,0)>0
                  AND COALESCE(AUTD.VALOREXCEDENTE,0)>0
                  AND COALESCE(AUT.LISTOFACT,'PEND')IN('OK','PEND')
                  --AND 1=CASE WHEN COALESCE(AUTD.ESDELAB,0)=1 THEN CASE WHEN COALESCE(AUTD.ENLAB,0)=2 THEN 1 ELSE 0 END 
                  --            ELSE CASE WHEN COALESCE(APOYODG_AMBITO,'')<> '' AND COALESCE(AUTD.ENLAB,0) = 2  THEN 1
                  --                  WHEN COALESCE(APOYODG_AMBITO,'')<> '' AND COALESCE(AUTD.ENLAB,0)<> 2  THEN 0 ELSE 1 END END 


BEGIN TRAN 
EXEC SPQ_JSON '{"MODELO":"KPPTCRO_PE","METODO":"FACTURAR_CRONICO","PARAMETROS":{"CONSECUTIVO":"010000004665"},"USUARIO":"FRODRIGUEZ"}'
ROLLback

BEGIN TRAN 
 EXEC SPK_FACTURACE_PERU_HADM_PAQ '010000004665','20610123571','01','01', 'FRODRIGUEZ','10/03/2025' 
 ROLLBACK
 SELECT N_FACTURA, * FROM HADM WHERE NOADMISION='010000004665'


EXEC SPQ_JSON '{"MODELO":"PASARELA_PAGOS","METODO":"ACTUALIZA_UNO","PARAMETROS":{"IDKPAGE":975},"USUARIO":"JJIMENEZ"}'

SELECT F_EXPIRA * FROM KPAGE WHERE IDKPAGE='977'

BEGIN TRAN
EXEC SPQ_JSON '{"MODELO":"PASARELA_PAGOS","METODO":"ANULAR_UNO","PARAMETROS":{"IDKPAGE":977},"USUARIO":"JJIMENEZ"}'

ROLLBACK

SELECT  IDKPAGE,KPAGE.CONSECUTIVO,KPAGE.PROCEDENCIA,DBO.FNK_FECHA_GRINGA(FECHAGEN)FECHAGEN,CONVERT(VARCHAR,FECHAGEN,108)HORA,KPAGE.VALOR,                          CASE KPAGE.ESTADO WHEN 'CREATED' THEN 'Generado' WHEN 'RUNNING' THEN 'En Proceso' WHEN 'SEND' THEN 'Notificado'                          WHEN 'PAID' THEN 'Pagado' WHEN 'EXPIRED' THEN 'Notificado' WHEN 'CANCELED' THEN 'Cancelado' WHEN 'REFUSED' THEN 'Rechazado' ELSE KPAGE.ESTADO END EST_PAGO,                         KPAGE.ESTADO,KPAGE.USUCOBRA,KPAGE.RESPONSABLEPAGO,AFI.DOCIDAFILIADO,AFI.NOMBREAFI,LINKPAGO,                         paymentOrderId,COALESCE(REF_PAGO,'')N_FACTURA,CONCAT(DBO.FNK_FECHA_GRINGA(FECHARES),' ',LEFT(CONVERT(VARCHAR,FECHARES,108),5))FECHARES,                         CONCAT(DBO.FNK_FECHA_GRINGA(FECHARES),' ',LEFT(CONVERT(VARCHAR,FECHARES,108),5))F_EXPIRA  FROM [dbo].[KPAGE] LEFT JOIN  AFI ON KPAGE.RESPONSABLEPAGO=AFI.IDAFILIADO WHERE (IDKPAGE LIKE '%%%%') AND 1=1 AND CONVERT(DATE,FECHAGEN)>='2025-03-10' AND CONVERT(DATE,FECHAGEN)<='2025-03-10'  ORDER BY IDKPAGE DESC OFFSET (1-1)*10 ROWS  FETCH NEXT 10 ROWS ONLY 