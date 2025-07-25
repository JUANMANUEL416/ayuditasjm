use KSANIPERU

USE PINTERNACIONAL

SELECT DISTINCT ESTADO FROM KPAGE

<i class="fa-solid fa-dollar-sign"></i>
<i class=" --"></i>

SELECT TOP 10 * FROM API_LOG WHERE USUARIO='JJIMENEZ' ORDER BY ITEM DESC

SELECT  IDKPAGE,KPAGE.CONSECUTIVO,KPAGE.PROCEDENCIA,DBO.FNK_FECHA_GRINGA(FECHAGEN)FECHAGEN,CONVERT(VARCHAR,FECHAGEN,108)HORA,KPAGE.VALOR,                          CASE KPAGE.ESTADO WHEN 'CREATED' THEN 'Generado' WHEN 'RUNNING' THEN 'En Proceso' WHEN 'SEND' THEN 'Notificado'                          WHEN 'PAID' THEN 'Pagado' WHEN 'EXPIRED' THEN 'Expiro' WHEN 'CANCELED' THEN 'Cancelado' ELSE KPAGE.ESTADO END EST_PAGO,                         KPAGE.ESTADO,KPAGE.USUCOBRA,KPAGE.RESPONSABLEPAGO,AFI.DOCIDAFILIADO,AFI.NOMBREAFI,LINKPAGO,                         paymentOrderId,COALESCE(REF_PAGO,'')N_FACTURA,DBO.FNK_FECHA_GRINGA(FECHARES)FECHARES,CONVERT(VARCHAR,FECHARES,108)HORARES   FROM [dbo].[KPAGE] LEFT JOIN  AFI ON KPAGE.RESPONSABLEPAGO=AFI.IDAFILIADO WHERE (IDKPAGE LIKE '%%%%') AND 1=1 AND CONVERT(DATE,FECHAGEN)>='2024-01-21' AND CONVERT(DATE,FECHAGEN)<='2025-01-21' AND KPAGE.PROCEDENCIA='PHD' AND TABLA='HADM'  ORDER BY IDKPAGE DESC OFFSET (1-1)*10 ROWS  FETCH NEXT 10 ROWS ONLY 

SELECT TOP 10 NOCOBRABLE * FROM AUTD

SELECT HADM.NOADMISION,DBO.FNK_FECHA_GRINGA(HADM.FECHA)FECHA,AFI.TIPO_DOC,AFI.DOCIDAFILIADO,AFI.NOMBREAFI,TER.NIT,TER.RAZONSOCIAL,HADM.IDPLAN,PLN.DESCPLAN,COALESCE(HADM.FACTURADA,0) FACTURADA,PPTCRO.VALOR,(SELECT SUM(VRL_EVENTO) FROM VWK_HADM_CRONICOS VK WHERE VK.NOADMISION=HADM.NOADMISION) VLR_EVENTO   FROM [dbo].[HADM] INNER JOIN  AFI ON HADM.IDAFILIADO=AFI.IDAFILIADO INNER JOIN  TER ON HADM.IDTERCERO=TER.IDTERCERO INNER JOIN  PLN ON HADM.IDPLAN=PLN.IDPLAN LEFT JOIN PPTCRO ON HADM.IDTERCERO=PPTCRO.IDTERCERO AND HADM.IDPLAN=PPTCRO.IDPLAN AND YEAR(HADM.FECHA)=PPTCRO.ANIO AND MONTH(HADM.FECHA)=PPTCRO.MES WHERE (NOADMISION LIKE '%%%%' OR AFI.DOCIDAFILIADO LIKE '%%%%') AND  COALESCE(PLN.CRONICO,0)=1 AND COALESCE(FACTURABLE,0)=1 AND FACTURADA=0          AND EXISTS(SELECT * FROM PPT WHERE  HADM.IDTERCERO=PPT.IDTERCERO AND HADM.IDPLAN=PPT.IDPLAN AND COALESCE(PPT.PAQUETIZADO,0)=1)            AND YEAR(HADM.FECHA)='2024' AND MONTH(HADM.FECHA)='12' AND HADM.IDTERCERO='20523470761' AND HADM.IDPLAN='PAQ020' AND  EXISTS(SELECT * FROM CIT WHERE CIT.NOADMISION=HADM.NOADMISION)   ORDER BY NOADMISION DESC  OFFSET (1-1)*10 ROWS  FETCH NEXT 10 ROWS ONLY 

SELECT ROW_NUMBER() OVER(ORDER  BY NOADMISION  ASC)ITEM, NO_ITEM,IDSERVICIO,DESCSERVICIO,CANTIDAD,VALORTOTAL,VALORCOPAGO,VLR_EXCEDENTE,COALESCE(N_PROVEEDOR,'')N_PROVEEDOR,RESUL,PROTOCOLO, IDAUT,FECHA,FACTURABLE   FROM [dbo].[VWK_HADM_CRONICOS] WHERE (DESCSERVICIO LIKE '%%%%') AND  NOADMISION='010000001174'  ORDER BY FECHA DESC OFFSET (1-1)*10 ROWS  FETCH NEXT 10 ROWS ONLY 