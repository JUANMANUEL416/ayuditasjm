
	DECLARE @IDARTICULO VARCHAR(20)
	DECLARE @CNSHISNUEVO VARCHAR(20)
	DECLARE @CNSHISANTE VARCHAR(20)

		DECLARE @MINITEM INT=1
		DECLARE @MAXITEM INT=0

		DECLARE @NOITEM INT
		DECLARE @PCOSTON DECIMAL(14,2)
		DECLARE @PCOSTOPM DECIMAL(14,2)
		DECLARE @CUMULADO INT=0
		DECLARE @CANTI INT
		DECLARE @TIPOMOV VARCHAR(10)
		DECLARE @ID INT
		DECLARE @NRO INT=0
	  
	  SELECT @CNSHISANTE=NULL
	  SELECT @CNSHISNUEVO='0100000002'

	DECLARE PG_CUR_INHIS CURSOR FOR   
	 SELECT IDARTICULO FROM INVIHISD WHERE CNSCIERRE= @CNSHISNUEVO
	 --AND IDARTICULO='FAR00581-2'
	 GROUP BY IDARTICULO
	 ORDER BY IDARTICULO 	
	OPEN PG_CUR_INHIS    
	FETCH NEXT FROM PG_CUR_INHIS    
	INTO @IDARTICULO
	WHILE @@FETCH_STATUS = 0    
	BEGIN  
		SELECT @NRO=@NRO+1
		PRINT 'COMIENZO ARTICULO='+@IDARTICULO+' @NRO = '+LTRIM(RTRIM(STR(@NRO)))

		UPDATE INVIHISD SET EXISTENCIA=0,EXISTANTES=0,PCOSTOFIN=0
		WHERE CNSCIERRE=@CNSHISNUEVO
		AND IDARTICULO=@IDARTICULO

		SELECT @MINITEM=1
		SELECT @PCOSTOPM=0,@CUMULADO=0
		DECLARE PG_CUR_INVHISDETA CURSOR FOR    
		SELECT NOITEM,PCOSTO,CASE WHEN ENTRADAS>0 THEN 'ENT' ELSE 'SALI' END, CASE WHEN ENTRADAS>0 THEN ENTRADAS ELSE SALIDAS END
		FROM INVIHISD
		WHERE CNSCIERRE=@CNSHISNUEVO
		AND IDARTICULO=@IDARTICULO
		ORDER BY  NOITEM	
	OPEN PG_CUR_INVHISDETA    
	FETCH NEXT FROM PG_CUR_INVHISDETA    
	INTO @NOITEM,@PCOSTON,@TIPOMOV,@CANTI
	WHILE @@FETCH_STATUS = 0    
	BEGIN 
		PRINT @MINITEM
		IF @MINITEM=1
		BEGIN 
			SELECT @PCOSTOPM=PCOSTOFIN,@CUMULADO=EXISTENCIA FROM INVIHISA WHERE CNSCIERRE=@CNSHISANTE
		END

		IF (SELECT CASE WHEN @TIPOMOV='ENT' THEN @CUMULADO+ENTRADAS ELSE @CUMULADO-SALIDAS END FROM INVIHISD WHERE NOITEM=@NOITEM)>=0
		BEGIN
			UPDATE INVIHISD SET EXISTANTES=@CUMULADO,EXISTENCIA=CASE WHEN @TIPOMOV='ENT' THEN @CUMULADO+ENTRADAS ELSE @CUMULADO-SALIDAS END,
			PCOSTOFIN=CASE WHEN @TIPOMOV='ENT' THEN (((@CUMULADO*@PCOSTOPM)+(ENTRADAS*PCOSTO))/ CASE WHEN @CUMULADO+ENTRADAS>0 THEN @CUMULADO+ENTRADAS ELSE 1 END) ELSE @PCOSTOPM END
			WHERE NOITEM=@NOITEM

			SELECT @PCOSTOPM=PCOSTOFIN,@CUMULADO=EXISTENCIA FROM INVIHISD WHERE  NOITEM=@NOITEM
		END
		ELSE
		BEGIN
			DELETE INVIHISD WHERE NOITEM=@NOITEM
		END

		SELECT @MINITEM=@MINITEM+1
	FETCH NEXT FROM PG_CUR_INVHISDETA    
	INTO  @NOITEM,@PCOSTON,@TIPOMOV,@CANTI
	END
	CLOSE PG_CUR_INVHISDETA
	DEALLOCATE PG_CUR_INVHISDETA



	

	FETCH NEXT FROM PG_CUR_INHIS    
	INTO @IDARTICULO
	END
	CLOSE PG_CUR_INHIS
	DEALLOCATE PG_CUR_INHIS

	--TOTALIZAR TODO
	DELETE INVIHISA WHERE CNSCIERRE= @CNSHISNUEVO

	--SELECT * FROM INVIHISA

	INSERT INTO INVIHISA(CNSCIERRE,IDARTICULO,DESCARTICULO,PCOSTO,EXISTANTES,ENTRADAS,SALIDAS,EXISTENCIA,PCOSTOFIN)
	SELECT  @CNSHISNUEVO,IDARTICULO,DESCARTICULO,0,0,0,0,0,0
	FROM INVIHISD
	WHERE CNSCIERRE= @CNSHISNUEVO
	GROUP BY IDARTICULO,DESCARTICULO

	UPDATE INVIHISA SET PCOSTO=B.PCOSTO,EXISTANTES=B.EXISTANTES
	FROM INVIHISA C INNER JOIN (
											SELECT A.CNSCIERRE, A.IDARTICULO,PCOSTO,EXISTANTES
											FROM INVIHISD A INNER JOIN (
																					SELECT IDARTICULO,MIN(NOITEM)NOITEM
																					FROM INVIHISD
																					WHERE CNSCIERRE= @CNSHISNUEVO
																					GROUP BY IDARTICULO) SIX ON A.IDARTICULO=SIX.IDARTICULO AND A.NOITEM=SIX.NOITEM
										  WHERE A.CNSCIERRE= @CNSHISNUEVO
										) B ON C.IDARTICULO=B.IDARTICULO AND C.CNSCIERRE=B.CNSCIERRE
	WHERE C.CNSCIERRE= @CNSHISNUEVO
	AND B.CNSCIERRE= @CNSHISNUEVO

	UPDATE  INVIHISA SET ENTRADAS=STAL.ENTRADAS,SALIDAS= STAL.SALIDAS
	FROM INVIHISA C INNER JOIN (
											SELECT A.CNSCIERRE, A.IDARTICULO,SUM(A.ENTRADAS)ENTRADAS,SUM(A.SALIDAS)SALIDAS
											FROM INVIHISD A
											WHERE A.CNSCIERRE= @CNSHISNUEVO
											GROUP BY  A.CNSCIERRE, A.IDARTICULO) STAL ON C.CNSCIERRE=STAL.CNSCIERRE AND STAL.IDARTICULO=C.IDARTICULO
	WHERE C.CNSCIERRE= @CNSHISNUEVO
	AND STAL.CNSCIERRE= @CNSHISNUEVO

	UPDATE INVIHISA SET PCOSTOFIN=B.PCOSTOFIN
	FROM INVIHISA C INNER JOIN (
											SELECT A.CNSCIERRE, A.IDARTICULO,PCOSTOFIN
											FROM INVIHISD A INNER JOIN (
																					SELECT IDARTICULO,MAX(NOITEM)NOITEM
																					FROM INVIHISD
																					WHERE CNSCIERRE= @CNSHISNUEVO
																					GROUP BY IDARTICULO) SIX ON A.IDARTICULO=SIX.IDARTICULO AND A.NOITEM=SIX.NOITEM
										  WHERE A.CNSCIERRE= @CNSHISNUEVO
										) B ON C.IDARTICULO=B.IDARTICULO AND C.CNSCIERRE=B.CNSCIERRE
	WHERE C.CNSCIERRE= @CNSHISNUEVO
	AND B.CNSCIERRE= @CNSHISNUEVO

	UPDATE INVIHISA SET EXISTENCIA=(EXISTANTES+ENTRADAS)-SALIDAS
	WHERE CNSCIERRE= @CNSHISNUEVO