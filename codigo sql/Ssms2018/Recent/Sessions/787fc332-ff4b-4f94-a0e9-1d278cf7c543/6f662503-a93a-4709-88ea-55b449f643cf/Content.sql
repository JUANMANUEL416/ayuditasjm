IF EXISTS (SELECT * FROM SYSOBJECTS WHERE name = 'SPK_GENERA_ANEXO02' AND type = 'P')
BEGIN
   DROP PROCEDURE SPK_GENERA_ANEXO02
END
GO
CREATE PROCEDURE DBO.SPK_GENERA_ANEXO02 
   @CONSECUTIVO VARCHAR(20)
WITH ENCRYPTION
AS

DECLARE  
@CNSHAUT        VARCHAR(20),
@AREA           VARCHAR(20),
@SEDE           VARCHAR(5),
@CLASEPLANTILLA VARCHAR(8),
@OBSERVACION    VARCHAR(2048)
BEGIN
   IF EXISTS (SELECT 1 FROM HAUT WHERE ISNULL(CONSECUTIVOHCA,'')<>'' AND CONSECUTIVOHCA=@CONSECUTIVO)
      RETURN

   SELECT @SEDE=IDSEDE,@CLASEPLANTILLA=CLASEPLANTILLA FROM HCA
   INNER JOIN HADM ON HADM.NOADMISION=HCA.NOADMISION
   WHERE CONSECUTIVO=@CONSECUTIVO

         SELECT @OBSERVACION=STUFF((SELECT Z.DATO+' '  
           FROM (SELECT CASE TIPOCAMPO WHEN 'Memo' THEN CONVERT(VARCHAR(2048),MEMO)
                        ELSE ALFANUMERICO   END AS DATO
                   FROM HCAD 
                  WHERE CAMPO IN (SELECT CAMPO 
                                    FROM HCAO 
                                   WHERE PROCESO='ANEXO02' 
                                     AND CLASEPLANTILLA=@CLASEPLANTILLA)
                                     AND CONSECUTIVO=@CONSECUTIVO) AS Z
           FOR XML PATH('')),1,0,'')


      EXEC SPK_GENCONSECUTIVO '01',@SEDE,'@HAUT',@CNSHAUT OUTPUT
      SELECT @CNSHAUT = @SEDE + RIGHT('00000000'+CONVERT(VARCHAR(8),@CNSHAUT),8)
      PRINT @CNSHAUT

      SELECT @AREA= DBO.FNK_VALORVARIABLE('TMIDAREAURX')

    INSERT INTO HAUT(CNSHAUT, NOADMISION, TIPO, CLASE, FECHA, DESTINO, ORIGEN, ESTADO, 
                     USUARIO, SYS_ComputerName, OBSERVACION, IDMEDICOREPOR, PROCEDENCIA, CONSECUTIVOHCA )
    SELECT @CNSHAUT, 
           HCA.NOADMISION, 
           HAUTTPO.TIPO, 
           HAUTTPO.CLASE, 
           GETDATE(), 
           @AREA, 
           @AREA, 
           'PENDIENTE', 
           HTRIAGE.USUARIO, 
           HTRIAGE.SYS_COMPUTERNAME, 
           @OBSERVACION, 
           USUSU.IDMEDICO, 
           'HADM',
           @CONSECUTIVO
      FROM HCA 
INNER JOIN MPL        ON MPL.CLASEPLANTILLA=HCA.CLASEPLANTILLA
INNER JOIN HADM      ON HADM.NOADMISION=HCA.NOADMISION
INNER JOIN HTRIAGE   ON HTRIAGE.CNSTRIAGE=HADM.CNSTRIAGE
 LEFT JOIN USUSU     ON USUSU.USUARIO=HTRIAGE.USUARIO
CROSS JOIN HAUTTPO 
     WHERE CONSECUTIVO=@CONSECUTIVO AND 
           HAUTTPO.CLASE='ANEXO 02'

INSERT INTO HAUTD (CNSHAUT, ITEM,EVENTO, FECHA, 
                   USUARIO, SYS_ComputerName, MEDIO, OBSERVACIONES)
     SELECT CNSHAUT, 
            1, 
            'PENDIENTE',
            GETDATE(), 
            USUARIO, 
            SYS_ComputerName, 
            'KRYSTALOS',
            'ATENCION INICIAL' 
       FROM HAUT 
      WHERE CNSHAUT=@CNSHAUT

END


