
UPDATE KRYESTRIOS.dbo.HDUXS SET FFINESTAB=(SELECT CAST(YEAR(GETDATE())AS VARCHAR(4))+
CASE  WHEN MONTH(GETDATE())<=9 THEN '0'+CAST(MONTH(GETDATE())AS VARCHAR(2))
ELSE CAST(MONTH(GETDATE())AS VARCHAR(2)) END+
CASE WHEN DAY(GETDATE())<=9 THEN '0'+CAST(DAY(GETDATE())AS VARCHAR(2))
ELSE CAST(DAY(GETDATE())AS VARCHAR(2)) END +' '+'06:00:00')
WHERE dbo.FNK_FECHA(FFINESTAB)=dbo.FNK_FECHA(GETDATE())


SELECT * FROM HDUXS WHERE dbo.FNK_FECHA(FFINESTAB)=dbo.FNK_FECHA(GETDATE())