use BDIX

select  * FROM CIAVER WHERE COMPANIA='ZB'

UPDATE  CIAVER SET ESTADO='Corrida' WHERE COMPANIA='ZB'

UPDATE USUSU SET FECHACAMBIO=DBO.FNK_GETDATE(),FECHAVENCE=DBO.FNK_GETDATE()+180 WHERE USUARIO='JIMENEZJ'