
SELECT  * FROM USPRO WHERE IDPROCEDIMIENTO LIKE '%MENUQ%NO%'
<i class="fa-solid fa-hospital-user"></i>
<i class="fa-solid fa-person-chalkboard"></i>
SELECT DBO.FNK_COLUMNAS_TABLAS('USPROH')

SELECT * FROM USPROH WHERE IDPROCEDIMIENTO='MENUQ_NOMINA'

DELETE USPROH WHERE IDPROCEDIMIENTO='MENUQ_NOMINA' AND IDCONTROL='Auditoria_Turnos'

IF NOT EXISTS(SELECT * FROM USPROH WHERE IDPROCEDIMIENTO='MENUQ_NOMINA' AND IDCONTROL='Auditoria_Turnos')
BEGIN
   INSERT INTO USPROH(IDPROCEDIMIENTO, IDCONTROL, TIPO, DESCRIPCION, WEB, RUTA, ICONO, CODIGOPADRE, AUTOMATICO, SEPARADOR, ORDEN, SUBLABEL, CODIGO, PAISES)
   SELECT 'MENUQ_NOMINA','Auditoria_Turnos','P','Seguimiento Turnos',1,'nom.AudTur','fa-solid fa-hospital-user',NULL,1,0,925,'Turnos, Novedades',NULL,NULL
END
