


SELECT  * FROM USPROH WHERE IDCONTROL='AsignarConCitCer'


SELECT  * FROM TER WHERE RAZONSOCIAL LIKE '%LINA%BOADA%'
SELECT ESTADO,NIT, *
FROM TER WHERE (IDTERCERO='74185000' OR NIT='74185000')
UNION ALL 
SELECT ESTADO,NIT,*
FROM TER WHERE (IDTERCERO='74185000' OR NIT='74185000')

--UPDATE TER SET ESTADO='Inactivo' where idtercero='0100010741'

SELECT * FROM FCXP WHERE IDTERCERO='0100010741'
SELECT * FROM FCXP WHERE IDTERCERO='9395628'

SELECT  * FROM FCJ WHERE IDTERCERO='0100003883'
SELECT  * FROM FCJ WHERE IDTERCERO='74184000'
ALTER TABLE MCH DISABLE TRIGGER ALL
UPDATE TER SET IDTERCERO='9395628' WHERE IDTERCERO='0100010741'
UPDATE FCJ SET IDTERCERO='35251347' WHERE IDTERCERO='46382571'
UPDATE MCHE SET IDTERCERO='35251347' WHERE IDTERCERO='46382571'
UPDATE MCH SET IDTERCERO='35251347' WHERE IDTERCERO='46382571'
UPDATE SALDOMESTERFAC SET IDTERCERO='35251347' WHERE IDTERCERO='46382571'