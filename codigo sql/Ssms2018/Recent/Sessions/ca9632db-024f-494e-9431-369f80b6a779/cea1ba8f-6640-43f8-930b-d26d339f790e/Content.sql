SELECT  * FROM AUTD WHERE IDAUT='0100006701'
SELECT  * FROM AUT WHERE IDAUT='0100006701'


SELECT  * FROM AUT inner JOIN AUTD ON AUT.IDAUT=AUTD.IDAUT
WHERE COALESCE(AUTD.APOYODG_AMBITO,'')<>'' AND AUTD.ESDELAB=0

UPDATE AUTD SET  ESDELAB=1 FROM AUT inner JOIN AUTD ON AUT.IDAUT=AUTD.IDAUT
WHERE COALESCE(AUTD.APOYODG_AMBITO,'')<>'' AND AUTD.ESDELAB=0

SELECT * FROM AUT WHERE NOAUT='0100008768' 

SELECT  * FROM AUTD WHERE IDAUT='0100008785'

SELECT * FROM LING WHERE NOPRESTACION='0100008785'

SELECT  * FROM 



SELECT IDTERCERO,RAZONSOCIAL
FROM VWK_TEXCA WHERE IDCATEGORIA=DBO.FNK_VALORVARIABLE('TERCATCONTRATANTE')

SELECT IDPLAN,DESCPLAN
FROM PLN 
WHERE ESTADO='Activo'