DECLARE @FECHA1 DATETIME ='5/09/1984'
DECLARE @FECHA2 DATETIME ='12/09/2004'




SELECT CASE WHEN  CONCAT(CAST(MONTH(@FECHA1)AS VARCHAR(2)),CAST(DAY(@FECHA1)AS VARCHAR(2))) <> CONCAT(CAST(MONTH(@FECHA2)AS VARCHAR(2)),CAST(DAY(@FECHA2)AS VARCHAR(2))) 
THEN 1 ELSE 0 END
IF DAY(@FECHA1)<>DAY(@FECHA2)
BEGIN
   SELECT @FECHA2=DATEADD(DAY,DAY(@FECHA1)-DAY(@FECHA2),@FECHA2)
END
PRINT @FECHA1
PRINT @FECHA2


DECLARE @FECHA1 DATETIME = '20200410'
DECLARE @FECHA2 DATETIME = '20240524'


SELECT CONVERT(VARCHAR,YEAR(@FECHA2))+RIGHT('0'+CONVERT(VARCHAR,MONTH(@FECHA1)),2)+(RIGHT('0'+CONVERT(VARCHAR,DAY(@FECHA1)),2))

202457
11 9
1 19 






