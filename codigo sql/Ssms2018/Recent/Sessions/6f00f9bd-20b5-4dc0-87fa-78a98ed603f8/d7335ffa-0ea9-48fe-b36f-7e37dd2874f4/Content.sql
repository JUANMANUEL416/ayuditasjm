

SELECT  * FROM USUSU WHERE USUARIO='JJIMENEZ'

SELECT DBO.FNK_COLUMNAS_TABLAS('USUSU')

SELECT  * FROM MED
UPDATE USUSU SET TIPO='I',IDMEDICO=NULL WHERE USUARIO='JJIMENEZ'

UPDATE USUSU SET SYS_ComputerName='F825385' WHERE USUARIO='JJIMENEZ'

INSERT INTO USUSU(COMPANIA, USUARIO, NOMBRE, GRUPO, TIPO, IDMEDICO, NIVELFUNCIONARIO, CODCAJERO, SYS_ComputerName, FECHACAMBIO, ESTADO, ESMEDICO, IDSEDE, IDIMAGEN, CARGO, TELEFONO, CELULAR, FECHAVENCE,  CONECTADO, SYS_COMP_CONECTADO, FECHA_CONEC, KEYUSER, IDTERCERO, IDFIRMA, IDEMPLEADO, TIPO_USUARIOADM, IDDEPURAR, EMAIL, GENERO, FECHANACIMIENTO, IDEMPRESA, F_RETIRO, IDBODEGA,  CARNET, CLAVE, CLAVE2, TELEGRAMID, NOMBRES, APELLIDOS, DOCID, TIPOIDENT, DEPARTAMENTO, SOLOWEB, IDPLANT)
SELECT COMPANIA, USUARIO, NOMBRE, GRUPO, TIPO, IDMEDICO, NIVELFUNCIONARIO, CODCAJERO, SYS_ComputerName, FECHACAMBIO, ESTADO, ESMEDICO, IDSEDE, IDIMAGEN, CARGO, TELEFONO, CELULAR, FECHAVENCE,  CONECTADO, SYS_COMP_CONECTADO, FECHA_CONEC, KEYUSER, IDTERCERO, IDFIRMA, IDEMPLEADO, TIPO_USUARIOADM, IDDEPURAR, EMAIL, GENERO, FECHANACIMIENTO, IDEMPRESA, F_RETIRO, IDBODEGA,  CARNET, CLAVE, CLAVE2, TELEGRAMID, NOMBRES, APELLIDOS, DOCID, TIPOIDENT, DEPARTAMENTO, SOLOWEB, IDPLANT FROM KUNIPSSAM.DBO.USUSU WHERE USUARIO='JJIMENEZ'


SELECT  * FROM NCON WHERE TIPO='INGRESO'

UPDATE NCON SET CODRET='36' WHERE CODCONCEPTO IN('01-1','01-6','01-3','01-71','01-7','E02','E03','E04','E05')