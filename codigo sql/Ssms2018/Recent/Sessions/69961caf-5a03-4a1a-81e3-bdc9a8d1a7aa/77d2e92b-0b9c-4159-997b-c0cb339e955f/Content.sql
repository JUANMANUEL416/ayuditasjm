USE KSANITASPERU

SELECT  * FROM MES WHERE IDEMEDICA='028'
UPDATE MES SET CRONICO=1 WHERE IDEMEDICA='028'

USE KESPERANZA

SELECT * FROM NIEPED WHERE CODCONCEPTO='E029' 

UPDATE  NIEPED SET RECOBRO=1 WHERE CODCONCEPTO='E029' 