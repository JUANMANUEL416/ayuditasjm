IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME= 'VWK_BALANCE_BASE_SI' AND TYPE='V')
BEGIN
    DROP VIEW VWK_BALANCE_BASE_SI
END
GO
CREATE VIEW DBO.VWK_BALANCE_BASE_SI
WITH  ENCRYPTION 
AS
SELECT MCH.ANO,MCH.MES,MCH.PERIODO,MCH.CUENTA,MCH.IDTERCERO,MCH.CCOSTO,SUM(MCH.SI)SI,SUM(MCH.DB)DB,SUM(MCH.CR)CR,SUM(CASE WHEN MCH.TIPO='DB' THEN (MCH.SI+MCH.DB)-MCH.CR ELSE (MCH.SI+MCH.CR)-MCH.DB END) SF, 
SUM(CASE WHEN MCH.TIPO='DB' THEN MCH.DB-MCH.CR ELSE MCH.CR-MCH.DB END) SALDOMES,MCH.TIPO,0 AS SI_DB,0 AS SI_CR,0 AS SF_DB,0 AS SF_CR
FROM (
      SELECT * FROM VWK_BALANCE_CUE_DETALLE_MCH
      UNION ALL
      SELECT * FROM VWK_BALANCE_SI_MES
      )MCH
GROUP BY MCH.ANO,MCH.MES,MCH.PERIODO,MCH.CUENTA,MCH.IDTERCERO,MCH.CCOSTO,MCH.TIPO

