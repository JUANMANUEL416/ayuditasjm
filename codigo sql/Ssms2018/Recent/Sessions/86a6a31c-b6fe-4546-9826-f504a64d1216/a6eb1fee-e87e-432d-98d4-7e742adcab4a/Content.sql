use PUNIPSSAM


SELECT ROW_NUMBER() OVER(ORDER  BY ANO,MES,FCARTH.IDTERCERO,FCARTH.CNSCXC,N_FACTURA  DESC)ID,
TER.NIT,TER.RAZONSOCIAL,FCARTH.CNSCXC,FCARTH.N_FACTURA,FCARTH.TIPO,FCARTH.SALDONETO,DBO.FNK_FECHA_DDMMAA(COALESCE(FCARTH.F_RECIBIDO,FCARTH.FECHA))F_RECIBIDO,
DBO.FNK_FECHA_DDMMAA(FCARTH.F_VENCE)F_VENCE,
FCARTH.DIASVENCE,CASE COALESCE(FCARTH.PARTICULAR,0) WHEN 0 THEN 'No' ELSE 'Si'END PARTICULAR,FCARTH.RAD,NORADICADA,FCARTH.PORVENCER,
FCARTH.D0_30+DM0_30 AS D0_30 ,FCARTH.D31_60+DM31_60 AS D31_60,D61_90+DM61_90 AS D61_90 ,D91_120+DM61_90 AS D91_120,D121_150+DM121_150 AS D121_150,
D151_180+DM151_180 AS D151_180,D181_360+DM181_360 AS D181_360 ,D361_MAS+DM361_MAS AS D361_MAS INTO DBO.A
FROM FCARTH INNER JOIN TER ON FCARTH.IDTERCERO=TER.IDTERCERO
WHERE ANO='2024'
AND MES=5
AND PROCEDENCIA='CARTERA'
ORDER BY ANO,MES,FCARTH.IDTERCERO,FCARTH.CNSCXC,N_FACTURA

SELECT DBO.FNK_COLUMNAS_TABLAS('A')

SELECT FCARTH.*
FROM FCARTH INNER JOIN TER ON FCARTH.IDTERCERO=TER.IDTERCERO
WHERE ANO='2024'
AND MES=5
AND N_fACTURA='UV15930'
AND PROCEDENCIA='CARTERA'

<i class="fa-solid fa-calendar-days"></i>

UPDATE USUSU SET IDDEPURAR=1-IDDEPURAR WHERE USUARIO='JJIMENEZ'

EXEC SPK_CIERRA_CARTERA '2024','5','JJIMENEZ','FACTURA'

SELECT TOP 10 * FROM API_LOG WHERE USUARIO='JJIMENEZ' ORDER BY ITEM DESC


SELECT ROW_NUMBER() OVER(ORDER  BY ANO,MES,FCARTH.IDTERCERO,FCARTH.CNSCXC,N_FACTURA  DESC)ID,                       TER.NIT,TER.RAZONSOCIAL,FCARTH.CNSCXC,FCARTH.N_FACTURA,FCARTH.TIPO,FCARTH.SALDONETO,DBO.FNK_FECHA_DDMMAA(COALESCE(FCARTH.F_RECIBIDO,FCARTH.FECHA))F_RECIBIDO,                       DBO.FNK_FECHA_DDMMAA(FCARTH.F_VENCE)F_VENCE,                       FCARTH.DIASVENCE,CASE COALESCE(FCARTH.PARTICULAR,0) WHEN 0 THEN 'No' ELSE 'Si'END PARTICULAR,FCARTH.RAD,NORADICADA,FCARTH.PORVENCER,                       FCARTH.D0_30+DM0_30 AS D0_30 ,FCARTH.D31_60+DM31_60 AS D31_60,D61_90+DM61_90 AS D61_90 ,D91_120+DM61_90 AS D91_120,D121_150+DM121_150 AS D121_150,                       D151_180+DM151_180 AS D151_180,D181_360+DM181_360 AS D181_360 ,D361_MAS+DM361_MAS AS D361_MAS   FROM [dbo].[FCARTH] INNER JOIN  TER ON FCARTH.IDTERCERO=TER.IDTERCERO WHERE (TER.RAZONSOCIAL LIKE '%%%%') AND  FCARTH.PROCEDENCIA='CARTERA' AND  1=1   ORDER BY ID ASC OFFSET (1-1)*10 ROWS  FETCH NEXT 10 ROWS ONLY 