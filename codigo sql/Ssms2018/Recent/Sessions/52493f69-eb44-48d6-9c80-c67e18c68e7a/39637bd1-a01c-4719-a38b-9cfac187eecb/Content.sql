USE KESPERANZA

UPDATE USUSU SET IDDEPURAR=1-IDDEPURAR WHERE USUARIO='JJIMENEZ'


 A.CODNOMINA='05' AND EXISTS (SELECT 1 FROM NIEPED INNER JOIN NIEPE ON NIEPE.CNSNIEPE=NIEPED.CNSNIEPE WHERE NIEPED.NUMDOC=A.NUMDOC AND NIEPE.ANO='2024' AND NIEPE.MES>=7 AND NIEPE.MES<=12  AND NIEPED.CODCONCEPTO =(SELECT CODIGO FROM TGEN WHERE TABLA='NOMINA' AND CAMPO='ProvPrimaD'))


 INSERT INTO TER(IDTERCERO,RAZONSOCIAL,NIT,ESTADO)
 SELECT '04','NOMINA DE INTERESES CESANTIAS','04','Activo'

INSERT INTO TEXCA(IDTERCERO,IDCATEGORIA,ESTADO)
SELECT '04','NOM','Activo'

SELECT  * FROM TER WHERE IDTERCERO='04'

SELECT  * FROM NIEPEG