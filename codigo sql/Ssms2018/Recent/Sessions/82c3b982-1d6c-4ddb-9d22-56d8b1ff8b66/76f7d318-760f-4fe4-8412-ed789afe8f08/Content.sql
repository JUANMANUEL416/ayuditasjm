
SELECT  * FROM CIT WHERE CONSECUTIVO='030259678419'

SELECT  * FROM TFCJ WHERE NOADMISION='030259678426' AND PROCEDENCIA='CITAS'

PRESTACION DE SERVICIO PROFESIONALES COMO ANESTESIOLOGO

EXEC SPK_PAGOSCAJA_CIT '030259678426','SOPORTE','01','03','SOPORTE',1

DELETE TFCJDD WHERE CNSFACJ='0300004258'
DELETE TFCJD WHERE CNSFACJ='0300004258'
DELETE TFCJ WHERE CNSFACJ='0300004258'


SELECT CODCUPS, * FROM SER WHERE IDSERVICIO='39204'