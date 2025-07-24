use KSANIPERU


SELECT TOP 10 * FROM API_LOG WHERE USUARIO='JJIMENEZ' ORDER BY ITEM DESC

EXEC SPQ_JSON '{"MODELO":"ESTERILIZA_COL","METODO":"CRUD_KMDX","PARAMETROS":{"DATOS":{"PROCESO":"Nuevo","IDDX":"J001","DESCRIPCION":"Diagnostico de pruebas","ESTADO":{"value":"activo","label":"Activo"},"RUTA":true,"PYP":true,"RESOLUCION":true,"CONFIDENCIAL":true,"SEXO":"Ambos","EDADINICIAL":"1","EDADFINAL":"99","ALTOCOSTO":{"value":"Si","label":"Sí"},"MREPORTE":"No","DIASINCAP":0,"CLASE":{"value":"HC","label":"HC"},"GRUPOENF":"01","SUBGRUPO":"01","CLASI1":"01","CLASI2":"01","COMENTARIOS":"pruebas de soporte","TEDAD":{"value":"NA","label":"Todas"}}},"USUARIO":"JJIMENEZ"}'

SELECT  * FROM DBO.FNK_CREA_TABLA_DESDEJSON('{"PROCESO":"Nuevo","IDDX":"J001","DESCRIPCION":"Diagnostico de pruebas","ESTADO":{"value":"activo","label":"Activo"},"RUTA":true,"PYP":true,"RESOLUCION":true,"CONFIDENCIAL":true,"SEXO":"Ambos","EDADINICIAL":"1","EDADFINAL":"99","ALTOCOSTO":{"value":"Si","label":"Sí"},"MREPORTE":"No","DIASINCAP":0,"CLASE":{"value":"HC","label":"HC"},"GRUPOENF":"01","SUBGRUPO":"01","CLASI1":"01","CLASI2":"01","COMENTARIOS":"pruebas de soporte","TEDAD":{"value":"NA","label":"Todas"}}')