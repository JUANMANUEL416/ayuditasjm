   DECLARE @DOCIDAFILIADO VARCHAR(20)   DECLARE @NOMBRECOMPLETO VARCHAR(256)   DECLARE @CANLETRAS INT   DECLARE @BANDERA   INT   DECLARE @I         INT   DECLARE @PARTE     VARCHAR(40)   DECLARE @LETRA     VARCHAR(1)	DECLARE PG_CURSOR CURSOR FOR     
   SELECT  DOCIDAFILIADO,LTRIM(RTRIM(NOMBRE))  FROM #P 
	OPEN PG_CURSOR    
	FETCH NEXT FROM PG_CURSOR    
	INTO @DOCIDAFILIADO,@NOMBRECOMPLETO
	WHILE @@FETCH_STATUS = 0    
	BEGIN 
      SELECT @CANLETRAS=LEN(@NOMBRECOMPLETO)+1
      SELECT @I=1
      SELECT @BANDERA=0
      SELECT @PARTE=''
      WHILE @I<=@CANLETRAS
      BEGIN
         PRINT 'EMPIEZO BANDERA ='+STR(@BANDERA)+' @CANLETRAS '+STR(@CANLETRAS)
         SELECT @LETRA=SUBSTRING(@NOMBRECOMPLETO,@I,1)
         IF @LETRA=''
         BEGIN 
            IF @PARTE NOT IN('DE','DEL','DELA')
            BEGIN
               IF @BANDERA=0
               BEGIN
                  PRINT '@BANDERA ='+STR(@BANDERA)
                  PRINT'PNOMBRE'
                  UPDATE #P SET PNOMBRE=@PARTE WHERE DOCIDAFILIADO=@DOCIDAFILIADO
                  SELECT @PARTE=''
                  SELECT @BANDERA=@BANDERA+1               
               END
               ELSE
               BEGIN
                  IF @BANDERA=1
                  BEGIN
                     PRINT '@BANDERA ='+STR(@BANDERA)
                     PRINT'SNOMBRE'+@PARTE
                     UPDATE #P SET SNOMBRE=@PARTE WHERE DOCIDAFILIADO=@DOCIDAFILIADO
                     SELECT @PARTE=''
                     SELECT @BANDERA=@BANDERA+1
                  END
                  ELSE
                  BEGIN
                     IF @BANDERA=2
                     BEGIN
                        PRINT '@BANDERA ='+STR(@BANDERA)
                        PRINT'PAPELLIDO'
                        UPDATE #P SET PAPELLIDO=@PARTE WHERE DOCIDAFILIADO=@DOCIDAFILIADO
                        SELECT @PARTE=''
                        SELECT @BANDERA=@BANDERA+1
                     END
                     ELSE
                     BEGIN
                        IF @BANDERA=3
                        BEGIN
                           PRINT '@BANDERA ='+STR(@BANDERA)
                           PRINT'SAPELLIDO'
                           UPDATE #P SET SAPELLIDO=@PARTE WHERE DOCIDAFILIADO=@DOCIDAFILIADO
                           SELECT @PARTE=''
                           SELECT @BANDERA=0
                        END
                     END
                 END
              END
           END
        END
        ELSE
        BEGIN 
           SELECT @PARTE=@PARTE+@LETRA
        END
        SELECT @I=@I+1
      END
	FETCH NEXT FROM PG_CURSOR    
	INTO @DOCIDAFILIADO,@NOMBRECOMPLETO
	END
	CLOSE PG_CURSOR
	DEALLOCATE PG_CURSOR

