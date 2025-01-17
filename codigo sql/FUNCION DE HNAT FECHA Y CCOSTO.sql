IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME='FNK_HNAT_FECHAYCCOSTO' AND XTYPE='TF')
BEGIN
   DROP FUNCTION FNK_HNAT_FECHAYCCOSTO
END
GO
CREATE FUNCTION DBO.FNK_HNAT_FECHAYCCOSTO(@NOADMISION VARCHAR(20))  
RETURNS @RESULTADOS
TABLE ( NOADMISION VARCHAR(20),
        NOITEM     SMALLINT,
        HABCAMA    VARCHAR(20),
        CCOSTO     VARCHAR(20),
        FECHAING   DATETIME,
        FECHASAL   DATETIME

      )

AS  
BEGIN
   INSERT INTO @RESULTADOS
   SELECT HNAT.NOADMISION,HNAT.NOITEM,HNAT.HABCAMA,HHAB.CCOSTO,HNAT.FECHA,
   COALESCE((SELECT TOP 1 X.FECHA FROM HNAT X WHERE X.NOADMISION=HNAT.NOADMISION AND X.NOITEM>HNAT.NOITEM),
   CASE HADM.CERRADA WHEN 1 THEN HADM.FECHAALTAENF WHEN 3 THEN HADM.FECHAALTAENF WHEN 2 THEN HADM.FECHAALTAMED 
        ELSE GETDATE() END) FECHASAL 
   FROM HNAT INNER JOIN HHAB ON HNAT.HABCAMA=HHAB.HABCAMA
             INNER JOIN HADM ON HNAT.NOADMISION=HADM.NOADMISION
    WHERE HNAT.NOADMISION=@NOADMISION

    RETURN
 END