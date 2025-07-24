select  * INTO #A from usproh where ruta='admin.recaudos' AND IDCONTROL='RECAUDOSCXC'

SELECT  * FROM #A
UPDATE #A SET IDCONTROL='CERTINGRET',DESCRIPCION='Certificado Ingresos y Retenciones',RUTA='admin.certiNom',ORDEN='105',SUBLABEL='Retencion'

INSERT INTO USPROH
SELECT  * FROM #A