IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME='FNK_DATO_BARCODE' AND XTYPE='FN')
BEGIN
   DROP FUNCTION DBO.FNK_DATO_BARCODE
END
GO
/***************************************************************************************/
CREATE FUNCTION DBO.FNK_DATO_BARCODE (@CADENA VARCHAR(8))
RETURNS VARCHAR(20)
WITH ENCRYPTION
AS
BEGIN    
   DECLARE @charPos INT, @minCharPos INT, @charCount INT,
           @currentChar INT , @checksum INT,
           @isTableB INT , @isValid INT,
           @returnValue VARCHAR(20), @LEN INT 
   SELECT @isTableB = 1, @isValid = 1, @returnValue = ''
   SELECT @LEN = LEN(@CADENA)
   IF @LEN > 0
   BEGIN
      SELECT @charCount = 0
      WHILE @charCount < @LEN
      BEGIN
         SELECT @currentChar =  ASCII(SUBSTRING(@CADENA, @charCount+1,1)) 
         if (NOT(@currentChar >= 32 AND @currentChar <= 126))
         BEGIN           
            SELECT @isValid = 0
            break
         END   
         SELECT @charCount = @charCount + 1
      END
      --PRINT 'PASE VALIDACION'
      IF @isValid = 1
      BEGIN
         --PRINT ' ES VALIDO'
         SELECT @charPos = 0
         WHILE (@charPos < @LEN)
         BEGIN
            --PRINT 'EN EL WHILE @charPos= '+CONVERT(VARCHAR,@charPos)
            if (@isTableB = 1)
            BEGIN
               --PRINT '@isTableB = 1'
               if (@charPos = 0 OR @charPos + 4 = @LEN)
                  SELECT @minCharPos = 4
               else
                  SELECT @minCharPos = 6
               
               --PRINT 'ANTES DEL LLAMADO A FUNCION FNK_BarcodeConverter128_IsNumber'
               --PRINT '@charPos= '+CONVERT(VARCHAR,@charPos)+ ' , @minCharPos= '+CONVERT(VARCHAR,@minCharPos)
               SELECT @minCharPos = DBO.FNK_BarcodeConverter128_IsNumber(@CADENA, @charPos, @minCharPos);
               --PRINT 'DESPUES DEL LLAMADO A FUNCION FNK_BarcodeConverter128_IsNumber DEVOLVIO @minCharPos= '+CONVERT(VARCHAR,@minCharPos)
               IF (@minCharPos < 0)
               BEGIN
                  --PRINT'--Choice table C'
                  IF (@charPos = 0)
                  BEGIN
                     --PRINT '--Starting with table C'
                     SELECT @returnValue = char(214)  --205 es el original
                     --PRINT '@returnValue 1= '''+@returnValue+''''
                  END
                  ELSE
                  BEGIN
                     --PRINT '--// Switch to table C'
                     SELECT @returnValue = @returnValue + char(199)
                  END
                  SELECT @isTableB = 0
               END
               ELSE
               BEGIN
                  IF (@charPos = 0)
                  BEGIN
                     --PRINT '--// Starting with table B'
                     SELECT @returnValue = char(204)
                  END
               END
            END
            IF (@isTableB = 0)
            BEGIN
               --PRINT '@isTableB = 0'
               --PRINT '--// We are on table C, try to process 2 digits'
               SELECT @minCharPos = 2;
               --PRINT 'ANTES DEL LLAMADO A FUNCION FNK_BarcodeConverter128_IsNumber ABAJO'
               --PRINT '@charPos= '+CONVERT(VARCHAR,@charPos)+ ' , @minCharPos= '+CONVERT(VARCHAR,@minCharPos)
               SELECT @minCharPos = DBO.FNK_BarcodeConverter128_IsNumber(@CADENA, @charPos, @minCharPos);
               --PRINT 'DESPUES DEL LLAMADO A FUNCION FNK_BarcodeConverter128_IsNumber ABAJO DEVOLVIO @minCharPos= '+CONVERT(VARCHAR,@minCharPos)
               if (@minCharPos < 0) 
               BEGIN
                  --PRINT '--// OK for 2 digits, process it'
                  SELECT @currentChar = CONVERT(INT,SUBSTRING(@CADENA, @charPos + 1, 2) )
                  --PRINT '@currentChar='+CONVERT(VARCHAR,@currentChar)
                  IF @currentChar < 95
                     SELECT @currentChar =  @currentChar + 32 
                  ELSE
                     SELECT @currentChar =  @currentChar + 100
                  --PRINT '@currentChar DESPUES DE PREGUNTAR SI ES MENOR DE 95='+CONVERT(VARCHAR,@currentChar)
                  SELECT @returnValue = @returnValue + char(@currentChar)
                  SELECT @charPos += 2;
               END
               ELSE
               BEGIN
                  --// We haven't 2 digits, switch to table B
                  SELECT @returnValue = @returnValue + char(200)
                  SELECT @isTableB = 1
               END
            END
            IF (@isTableB = 1)
            BEGIN
               --// Process 1 digit with table B
               SELECT @returnValue = @returnValue + Substring(@CADENA, @charPos+1, 1)
               SELECT @charPos += 1
            END
            --PRINT '@returnValue = '''+@returnValue +''''
         END
         --------------------
         --// Calculation of the checksum
         SELECT @checksum = 0
         DECLARE @LOOP INT = 0
         SELECT @LEN = LEN(@returnValue)
         WHILE (@loop < @LEN)
         BEGIN
            --PRINT 'VOLVI A ENTRAR'
            SELECT @currentChar = ASCII(Substring(@returnValue, @loop+1, 1))
            --PRINT '@currentChar EN EL CHECKSUM='+CONVERT(VARCHAR,@currentChar)
            if @currentChar < 127
               select @currentChar = @currentChar - 32 
            else
               select @currentChar = @currentChar - 100
            --PRINT '@CHECKSUM = '+CONVERT(VARCHAR,@checksum) + ', @loop= '+ CONVERT(VARCHAR,@loop) +', @currentChar= '+CONVERT(VARCHAR,@currentChar)
            if (@LOOP = 0)
               select @checksum = @currentChar;
            else
               select @checksum = (@checksum + (@loop * @currentChar)) % 103;

            --PRINT '@CHECKSUM DESPUES = '+CONVERT(VARCHAR,@checksum)
            SELECT @LOOP = @LOOP + 1
         END

         --PRINT '--// Calculation of the checksum ASCII code'
         --PRINT '@checksum ANTES IF 95= '+CONVERT(VARCHAR, @checksum)
         if @checksum < 95 
            select @checksum = @checksum+ 32 
         else 
            select @checksum = @checksum + 100
         --// Add the checksum and the STOP
         --PRINT '@checksum DESPUES IF 95= '+CONVERT(VARCHAR, @checksum)
         select @returnValue = @returnValue +  char(@checksum) + char(215)  --215  206 es el original
         --PRINT '@returnValue final =''' +@returnValue+''''
         --------------------
      END   
   END
   RETURN(@returnValue)
END
GO
/***************************************************************************************/
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME='FNK_BarcodeConverter128_IsNumber' AND XTYPE='FN')
BEGIN
   DROP FUNCTION DBO.FNK_BarcodeConverter128_IsNumber
END
GO
/***************************************************************************************/
CREATE FUNCTION DBO.FNK_BarcodeConverter128_IsNumber (@InputValue varchar(8) , @CharPos int , @MinCharPos int )
RETURNS INT
WITH ENCRYPTION
AS
BEGIN    
   declare @LEN INT
   SELECT @LEN = LEN(@InputValue)
   --// if the MinCharPos characters from CharPos are numeric, then MinCharPos = -1
   select @MinCharPos = @MinCharPos -1
   IF (@CharPos + @MinCharPos < @LEN)
   BEGIN
      WHILE (@MinCharPos >= 0)
      BEGIN
         if (ASCII(Substring(@InputValue, @CharPos + 1 + @MinCharPos, 1)) < 48
             or
             ASCII(Substring(@InputValue, @CharPos +1 + @MinCharPos, 1)) > 57)
         BEGIN
             BREAK
         END
         SELECT @MinCharPos = @MinCharPos -1
      END
   END
   return @MinCharPos
END
GO
