
use KUNIPSSAM

SELECT  * FROM FTR WHERE N_FACTURA='UV23174'

SELECT  * FROM FTRD WHERE N_FACTURA='UV23174'

SELECT  * FROM CIT WHERE N_FACTURA='UV23174'
SELECT  * FROM SER WHERE IDSERVICIO='890385'

USE KUNIPSSAM

SELECT  * FROM CIT WHERE CONSECUTIVO='0110307112'

UPDATE CIT SET VALORCOPAGO=0 WHERE CONSECUTIVO='0110307112'

SELECT  * FROM HCATD WHERE IDSERVICIO='MP196'

SELECT FACTURADA,N_FACTURA,NOADMISION, * FROM CIT WHERE CONSECUTIVO='010191583474'


SELECT TOP 10 * FROM API_LOG WHERE USUARIO='FRODRIGUEZ' ORDER BY ITEM DESC


SELECT CIT.CONSECUTIVO                                                                                               
,      DBO.FNK_FECHA_GRINGA(CIT.FECHA)                                                                                   FECHA
,      AFI.TIPO_DOC                                                                                                  
,      AFI.DOCIDAFILIADO                                                                                             
,      AFI.NOMBREAFI                                                                                                 
,      CIT.IDMEDICO                                                                                                  
,      MED.NOMBRE                                                                                                    
,      MES.DESCRIPCION                                                                                               
,      CIT.IDSERVICIO                                                                                                
,      SER.DESCSERVICIO                                                                                              
,      COALESCE(CIT.VALORTOTAL,0)                                                                                        VALORTOTAL
,      COALESCE(CIT.VALORCOPAGO,0)                                                                                       VALORCOPAGO
,      (COALESCE(CIT.VALORTOTAL,0)-COALESCE(CIT.VALORCOPAGO,0))                                                          VLR_EXCEDENTE
,      COALESCE(CIT.FACTURADA,0)                                                                                         FACTURADA
,      CIT.N_FACTURA                                                                                                 
,      CIT.NFACTURA                                                                                                   AS NBOLETA
,      TER.NIT                                                                                                       
,      TER.RAZONSOCIAL                                                                                               
,      CIT.IDPLAN                                                                                                    
,      PLN.DESCPLAN                                                                                                  
,      COALESCE(PPT.PAQUETIZADO,0)                                                                                       PAQUETIZADO
,      CIT.IDTERCEROCA                                                                                               
,      (COALESCE(CIT.VALORTOTAL,0)-COALESCE(CIT.VALORCOPAGO,0))+COALESCE(VK.VLR_AGUDO,0)+COALESCE(VK.VLR_PROTOCOLO,0) AS VLR_FACTURAR
,      COALESCE(VK.DX_PEND,0)                                                                                            DX_PEND
FROM       [dbo].[CIT]       
INNER JOIN AFI                ON CIT.IDAFILIADO=AFI.IDAFILIADO
INNER JOIN MED                ON CIT.IDMEDICO=MED.IDMEDICO
INNER JOIN SER                ON CIT.IDSERVICIO=SER.IDSERVICIO
INNER JOIN TER                ON CIT.IDTERCEROCA=TER.IDTERCERO
INNER JOIN PLN                ON CIT.IDPLAN=PLN.IDPLAN
INNER JOIN PPT                ON CIT.IDTERCEROCA=PPT.IDTERCERO AND CIT.IDPLAN=PPT.IDPLAN
LEFT JOIN  MES                ON CIT.IDEMEDICA=MES.IDEMEDICA
LEFT JOIN  VWK_RESUCIT_AUT VK ON CIT.CONSECUTIVO=VK.CONSECUTIVOCIT
WHERE (MED.NOMBRE LIKE '%%%%' OR CONSECUTIVO LIKE '%%%%' OR AFI.NOMBREAFI LIKE '%%%%') AND COALESCE(CIT.CUMPLIDA,0)=1 AND CIT.IDAFILIADO IS NOT NULL AND EXISTS(SELECT *
	FROM PLN
	WHERE PLN.IDPLAN=CIT.IDPLAN AND COALESCE(PPT.PAQUETIZADO,0)=0) AND (CIT.CONSECUTIVO LIKE '%salvatierra%' OR AFI.NOMBREAFI LIKE '%salvatierra%' ) AND COALESCE(CIT.FACTURADA,0)=1 AND CONVERT(DATE,CIT.FECHA)>='2024-12-01' AND CONVERT(DATE,CIT.FECHA)<='2025-03-08'
ORDER BY CONSECUTIVO DESC OFFSET (1-1)*10 ROWS FETCH NEXT 10 ROWS ONLY

SELECT FACTURADA,N_FACTURA,NOADMISION, * FROM CIT WHERE CONSECUTIVO='010191583874'


SELECT CIT.FECHA,CIT.IDSERVICIO,SER.DESCSERVICIO, AFI.DOCIDAFILIADO,NOMBREAFI,CIT.IDPLAN,PLN.DESCPLAN 
FROM CIT INNER JOIN AFI ON CIT.IDAFILIADO=AFI.IDAFILIADO
         INNER JOIN PLN ON CIT.IDPLAN=PLN.IDPLAN
         INNER JOIN SER ON CIT.IDSERVICIO=SER.IDSERVICIO
WHERE FACTURADA=1 AND N_FACTURA LIKE 'B%'

UPDATE CIT SET FACTURADA=0,N_FACTURA=NULL WHERE FACTURADA=1 AND N_FACTURA LIKE 'B%'