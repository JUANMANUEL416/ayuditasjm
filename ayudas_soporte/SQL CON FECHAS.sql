DECLARE @startRow INT ; SET @startrow = 50
SELECT COUNT(*) AS TotRows
FROM [INFORMATION_SCHEMA].columns

;WITH cols
AS
(
    SELECT table_name, column_name,
        ROW_NUMBER() OVER(ORDER BY table_name, column_name) AS seq
    FROM [INFORMATION_SCHEMA].columns
)
SELECT table_name, column_name
FROM cols
WHERE seq BETWEEN @startRow AND @startRow + 49
ORDER BY seq
------------------------------------
DECLARE @startRow INT ; SET @startrow = 50
CREATE TABLE #pgeResults(
    id INT IDENTITY(1,1) PRIMARY KEY CLUSTERED,
    table_name VARCHAR(255),
    column_name VARCHAR(255)
)
INSERT INTO #pgeResults(Table_name, column_name)
SELECT table_name, column_name
FROM [INFORMATION_SCHEMA].columns
ORDER BY [table_name], [column_name]

SELECT @@ROWCOUNT AS TotRows
SELECT Table_Name, Column_Name
FROM #pgeResults
WHERE id between @startrow and @startrow + 49
ORDER BY id

DROP TABLE #pgeResults
-----------------------------------------------
DECLARE @startRow INT ; SET @startrow = 50

;WITH cols
AS
(
    SELECT table_name, column_name, 
    ROW_NUMBER() OVER(ORDER BY table_name, column_name) AS seq, 
    COUNT(*) OVER() AS totrows
    FROM [INFORMATION_SCHEMA].columns
)
SELECT table_name, column_name, totrows
FROM cols
WHERE seq BETWEEN @startRow AND @startRow + 49
ORDER BY seq
-----------------------------------------------
DECLARE @startRow INT ; SET @startrow = 50
;WITH cols
AS
(
    SELECT table_name, column_name, 
        ROW_NUMBER() OVER(ORDER BY table_name, column_name) AS seq, 
        ROW_NUMBER() OVER(ORDER BY table_name DESC, column_name desc) AS totrows
    FROM [INFORMATION_SCHEMA].columns
)
SELECT table_name, column_name, totrows + seq -1 as TotRows
FROM cols
WHERE seq BETWEEN @startRow AND @startRow + 49
ORDER BY seq
----------------------------------
drop procedure withDates
go
CREATE PROCEDURE withDates
   @d1 as datetime,
   @d2 as datetime
AS
BEGIN
 DECLARE @dateparams TABLE (d1 datetime, d2 datetime)
 insert into @dateparams (d1, d2) values (@d1, @d2)

 --this is more fast than the normal way
 select * from mcp where fechacontable > (select d1 from @dateparams) and fechacontable < (select d2 from @dateparams)

 --normal way, becomes very slow for SQL
 select * from mcp where fechacontable > @d1 and fechacontable < @d2

END

exec withDates '01/01/2008', '01/01/2009'


