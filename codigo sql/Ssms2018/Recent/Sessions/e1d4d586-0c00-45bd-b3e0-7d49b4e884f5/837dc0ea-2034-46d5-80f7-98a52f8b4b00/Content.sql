
SELECT * FROM NEMP WHERE PRIMERAPELLIDO='VALDEZ'

SELECT * FROM NPLA WHERE NUMDOC='0600000763'

UPDATE  NEMP SET CODPLANTA=NULL WHERE NUMDOC='0600000005'


SELECT CODPLANTA FROM NEMP WHERE NUMDOC='0600000005'

SELECT  * FROM SYS.check_constraints WHERE name='FK_NPLA_NPLACODEMPLEADO'

ALTER TABLE NPLA DROP CONSTRAINT FK_NPLA_NPLACODEMPLEADO
ALTER TABLE NEMPF DROP CONSTRAINT FK_NEMPF_NEMPFCODEMP
ALTER TABLE NEMPFD DROP CONSTRAINT FK_NEMPFD_NEMPFDNUMDOC


EXEC SPK_ADDDEL_CONCEPTOS_DE_CARGOS_NUMDOC 'ADD', '01202409P30-1','0600000005'




SELECT  * FROM NCERTC--

SELECT IDEMPLEADO,  * FROM USUSU 

SELECT TIPO_DOC,DOCIDEMPLEADO,NEMP.EMAIL,TER.DIRECCION,TER.TELEFONOS
 FROM NEMP INNER JOIN TER ON NEMP.TERCEROID=TER.IDTERCERO 

 --
 CNSSOLICITUD
 FECHA
 IDEMPLEADO
 ESTADO
 TIPOCET
 ?DIRIGIDO A -- A QUIEN LE INTERESE
 ?
 CNSCERT