
--SELECT  * FROM #A

DECLARE @ID INT
DECLARE @PNOMBRE VARCHAR(100)
DECLARE @SNOMBRE VARCHAR(100)
DECLARE @CORREO  VARCHAR(250)
DECLARE @TELEFONO VARCHAR(50)

SET @ID=1
WHILE @ID<=102
BEGIN

   SELECT @PNOMBRE=NOMBRE,@SNOMBRE=APELLIDO,@CORREO=CORREO,@TELEFONO=TELEFONO  FROM #A WHERE ID=@ID

   PRINT 'BEGIN:VCARD'
   PRINT 'VERSION:3.0'
   PRINT 'N:'+@PNOMBRE+''+@SNOMBRE+';;;'
   PRINT 'FN:'+@SNOMBRE+''
   PRINT 'EMAIL;TYPE=HOME,INTERNET,pref:'+@CORREO+''
   PRINT 'TEL;TYPE=VOICE,HOME;VALUE=text:'+@TELEFONO+''
   PRINT 'END:VCARD'

   SELECT @ID=@ID+1

END