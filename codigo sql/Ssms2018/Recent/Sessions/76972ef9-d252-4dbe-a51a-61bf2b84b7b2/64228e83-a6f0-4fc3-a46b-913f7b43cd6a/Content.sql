use ksanitasperu

SELECT FACTURADA,FACTURABLE,N_FACTURA,NFACTURA,CUMPLIDA, * FROM CIT WHERE CONSECUTIVO='010191583382'

SELECT * FROM AUT WHERE CONSECUTIVOCIT='010191583382'


SELECT  * FROM AUT WHERE IDAUT='0100000564'
SELECT  * FROM AUTD WHERE IDAUT='0100000564'

UPDATE AUTD SET IDPLAN='PAQ020' WHERE IDAUT='0100002545'

SELECT  * FROM LING WHERE NOPRESTACION='0100000564'


SELECT  * FROM CIT WHERE CONSECUTIVO='010163377801'

UPDATE CIT SET VALORCOPAGO=30 WHERE CONSECUTIVO='010163377801'

EXEC SPK_RECALCULAR_COPAGOS_AUTD '0100002545'

SELECT  * FROM AUT WHERE IDAUT='0100002545'

SELECT  * FROM PLN WHERE DESCPLAN LIKE '%VIVE%'

SELECT  * FROM CIT WHERE CONSECUTIVO='010496937851'

UPDATE CIT SET IDPLAN='PAQ020' WHERE CONSECUTIVO='010496937851'

SELECT IDKPAGE, * FROM AUT WHERE CONSECUTIVOCIT='010496937851'

UPDATE  AUT SET IDKPAGE=NULL WHERE CONSECUTIVOCIT='010496937851'

SELECT * FROM KPAGE WHERE IDKPAGE=393

UPDATE AUT SET IDPLAN='PAQ020' WHERE CONSECUTIVOCIT='010496937851'

SELECT * FROM AUTD WHERE IDAUT='0100002545'

EXEC SPK_CONFIRMAR_AUT '0100002545'

