DECLARE @TableBodegas AS TABLE([IDBODEGA] VARCHAR(2) NOT NULL)
DECLARE @Bodega Varchar(2), @BodegasPVT NVARCHAR(MAX) 
INSERT INTO @TableBodegas  SELECT DISTINCT idbodega AS [Bodega] FROM  iexi
SET @Bodega = (SELECT MIN([IDBODEGA]) FROM @TableBodegas)
--select * from @TableBodegas
SET @BodegasPVT=N''
WHILE @Bodega IS NOT NULL
BEGIN
   SET @BodegasPVT = @BodegasPVT + N',['+ CONVERT(NVARCHAR(10),@Bodega) + N']'
   SET @Bodega = (SELECT MIN([IDBODEGA]) FROM @TableBodegas WHERE [IDBODEGA]>@Bodega)
END
SET @BodegasPVT = SUBSTRING(@BodegasPVT,2,LEN(@BodegasPVT))
--PRINT @BodegasPVT

DECLARE @SQL NVARCHAR(MAX)
 SET @SQL = N'SELECT *
            FROM ( 
                SELECT IDARTICULO,IDBODEGA [Bodega], exislote FROM iexi
                ) pvt
            PIVOT (SUM(exislote) FOR [Bodega] IN (' + @BodegasPVT + ')) AS Child
            ORDER BY IDARTICULO'
 
EXECUTE sp_executesql @SQL

----------------------------------------------

DECLARE @TableBodegas AS TABLE([IDBODEGA] VARCHAR(2) NOT NULL)
DECLARE @Bodega Varchar(2), @BodegasPVT NVARCHAR(MAX) 
INSERT INTO @TableBodegas  SELECT DISTINCT idbodega AS [Bodega] FROM  iexi
SET @Bodega = (SELECT MIN([IDBODEGA]) FROM @TableBodegas)
--select * from @TableBodegas
SET @BodegasPVT=N''
WHILE @Bodega IS NOT NULL
BEGIN
   SET @BodegasPVT = @BodegasPVT + N',['+ CONVERT(NVARCHAR(10),@Bodega) + N']'
   SET @Bodega = (SELECT MIN([IDBODEGA]) FROM @TableBodegas WHERE [IDBODEGA]>@Bodega)
END
SET @BodegasPVT = SUBSTRING(@BodegasPVT,2,LEN(@BodegasPVT))
--PRINT @BodegasPVT

DECLARE @SQL NVARCHAR(MAX)
 SET @SQL = N'
            SELECT X.IDARTICULO, IART.DESCRIPCION, '+@BodegasPVT+'
            FROM   (
                     SELECT IDARTICULO, '+@BodegasPVT+'
                     FROM ( 
                         SELECT IDARTICULO,IDBODEGA [Bodega], coalesce(exislote,0) exislote FROM iexi
                         ) pvt
                     PIVOT (SUM(exislote) FOR [Bodega] IN (' + @BodegasPVT + ')) AS Child
                     --ORDER BY IDARTICULO
                   ) X INNER JOIN IART ON X.IDARTICULO = IART.IDARTICULO
            ORDER BY X.IDARTICULO'
--SELECT @SQL
EXECUTE sp_executesql @SQL
