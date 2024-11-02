DROP VIEW VWKH_HC_DESC_NOEVO
GO
CREATE VIEW DBO.VWKH_HC_DESC_NOEVO
AS
SELECT HCA.FECHA, HCA.CONSECUTIVO, HCA.IDAFILIADO, AFI.PAPELLIDO +' '+AFI.SAPELLIDO+' '+AFI.PNOMBRE+' '+AFI.SNOMBRE AS NOMBRES,
       HCA.NOADMISION, HCA.CLASEPLANTILLA, MPL.DESCPLANTILLA, HCA.IDMEDICO, HCA.IDDX, MPLD.DESCCAMPO, 
       CASE HCAD.TIPOCAMPO WHEN 'Titulo'        THEN HCAD.MEMO
                           WHEN 'Subtitulo'     THEN HCAD.MEMO
                           WHEN 'Alfanaumerico' THEN HCAD.ALFANUMERICO
                           WHEN 'Memo'          THEN HCAD.MEMO 
                           WHEN 'Lista'         THEN HCAD.ALFANUMERICO
                           WHEN 'MultiCheck'    THEN HCADL.VALORLISTA 
                           WHEN 'Fecha'         THEN CAST(HCAD.FECHA AS VARCHAR (25))
                           WHEN 'Calculado'     THEN HCAD.ALFANUMERICO
       END AS VALOR,
       CASE HCAD.TIPOCAMPO WHEN 'Titulo'        THEN ''
                           WHEN 'Subtitulo'     THEN ''
                           WHEN 'Alfanaumerico' THEN ''
                           WHEN 'Memo'          THEN ''
                           WHEN 'Lista'         THEN ''
                           WHEN 'MultiCheck'    THEN CASE HCADL.CHECKM WHEN 1 THEN '- OK -' ELSE '' END
                           WHEN 'Fecha'         THEN ''
                           WHEN 'Calculado'     THEN ''
       END AS MARCAMULTICHECK,
       CASE HCAD.TIPOCAMPO WHEN 'Titulo'        THEN ''
                           WHEN 'Subtitulo'     THEN ''
                           WHEN 'Alfanaumerico' THEN ''
                           WHEN 'Memo'          THEN ''
                           WHEN 'Lista'         THEN ''
                           WHEN 'MultiCheck'    THEN HCADL.DESCRIPCION
                           WHEN 'Fecha'         THEN ''
                           WHEN 'Calculado'     THEN ''
       END AS DESCMULTICHECK
FROM   HCA INNER JOIN AFI   ON HCA.IDAFILIADO      = AFI.IDAFILIADO
           INNER JOIN MPL   ON HCA.CLASEPLANTILLA  = MPL.CLASEPLANTILLA
           INNER JOIN HCAD  ON HCA.CONSECUTIVO     = HCAD.CONSECUTIVO
            LEFT JOIN HCADL ON HCAD.CONSECUTIVO    = HCADL.CONSECUTIVO
                           AND HCAD.SECUENCIA      = HCADL.SECUENCIA
           INNER JOIN MPLD ON HCAD.CLASEPLANTILLA = MPLD.CLASEPLANTILLA
                          AND HCAD.SECUENCIA      = MPLD.SECUENCIA
WHERE  HCA.CLASE = 'HC'
AND    HCA.CLASEPLANTILLA <> dbo.FNK_VALORVARIABLE('HCPLANTILLARED')
GO

DROP VIEW VWKH_HC_DESC_EVOLU
GO
CREATE VIEW DBO.VWKH_HC_DESC_EVOLU
SELECT HRED.FECHA, HRED.CONSECUTIVO, HCA.IDAFILIADO, AFI.PAPELLIDO +' '+AFI.SAPELLIDO+' '+AFI.PNOMBRE+' '+AFI.SNOMBRE AS NOMBRES,
       HCA.NOADMISION, HCA.CLASEPLANTILLA, 'EVOLUCION DIARIA' AS DESCPLANTILLA, HRED.IDMEDICO, HRED.IDDX, HRED.EVOLUCION, HRED.PLANDEMANEJO,
       HRED.EVOLSUB, HRED.ANALISIS
FROM   HRED INNER JOIN HCA ON HRED.CONSECUTIVO = HCA.CONSECUTIVO
            INNER JOIN AFI ON HCA.IDAFILIADO   = AFI.IDAFILIADO
GO
