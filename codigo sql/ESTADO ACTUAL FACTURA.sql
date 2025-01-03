	
  -- ALTER TABLE #A ADD OBSERVACION VARCHAR(101)
  UPDATE #A SET OBSERVACION=''
   DECLARE @N_fACTURA VARCHAR(20)
   DECLARE @RESPUESTA VARCHAR (100)
   DECLARE JM_CURSOR CURSOR FOR     
   SELECT N_FACTURA FROM #A 
	OPEN JM_CURSOR    
	FETCH NEXT FROM JM_CURSOR    
	INTO @N_FACTURA
	WHILE @@FETCH_STATUS = 0    
	BEGIN
      SELECT @RESPUESTA='' 
      IF NOT EXISTS(SELECT * FROM FTR WHERE N_fACTURA=@N_FACTURA)
      BEGIN 
         SELECT @RESPUESTA='FACTURA NO EXISTE'
         UPDATE #A SET  OBSERVACION=@RESPUESTA WHERE N_FACTURA=@N_fACTURA
	      FETCH NEXT FROM JM_CURSOR    
	      INTO @N_FACTURA    
         CONTINUE     
      END
      IF NOT EXISTS ( SELECT *  FROM FCXC INNER JOIN FCXCD ON FCXC.CNSCXC=FCXCD.CNSCXC  WHERE N_FACTURA=@N_fACTURA AND COALESCE(FCXC.INDRECIBIDO,0)=1)
      BEGIN
         SELECT @RESPUESTA='FACTURA NO ESTA RADICADA'
         UPDATE #A SET  OBSERVACION=@RESPUESTA WHERE N_FACTURA=@N_fACTURA
	      FETCH NEXT FROM JM_CURSOR    
	      INTO @N_FACTURA    
         CONTINUE
      END
      IF EXISTS(SELECT N_FACTURA,FCONCI.IDFCONCI,FCONCID.ESTADO FROM FCONCI INNER JOIN FCONCID ON FCONCI.IDFCONCI=FCONCID.IDFCONCI
                               WHERE N_FACTURA=@N_fACTURA AND FCONCID.ESTADO='Ingresada')
      BEGIN 
         SELECT @RESPUESTA='FACTURA EN CONCILIACION '+FCONCI.IDFCONCI+'SIN CERRAR' FROM FCONCI INNER JOIN FCONCID ON FCONCI.IDFCONCI=FCONCID.IDFCONCI
                               WHERE N_FACTURA=@N_fACTURA AND FCONCID.ESTADO='Ingresada'
         UPDATE #A SET  OBSERVACION=@RESPUESTA WHERE N_FACTURA=@N_fACTURA
	      FETCH NEXT FROM JM_CURSOR    
	      INTO @N_FACTURA    
         CONTINUE
      END
      IF EXISTS(SELECT N_FACTURA,FPAG.CNSFPAG,FPAG.CERRADO FROM FPAG INNER JOIN FPAGD ON FPAG.CNSFPAG=FPAGD.CNSFPAG
                               WHERE N_FACTURA=@N_fACTURA AND FPAG.CERRADO=0)
      BEGIN
         SELECT @RESPUESTA=' FACTURA EN PAGOS SIN APLICAR CNS= '+FPAG.CNSFPAG FROM FPAG INNER JOIN FPAGD ON FPAG.CNSFPAG=FPAGD.CNSFPAG
                               WHERE N_FACTURA=@N_fACTURA AND FPAG.CERRADO=0
         UPDATE #A SET  OBSERVACION=@RESPUESTA WHERE N_FACTURA=@N_fACTURA
	      FETCH NEXT FROM JM_CURSOR    
	      INTO @N_FACTURA    
         CONTINUE
     END
     IF NOT EXISTS(SELECT * FROM FCXCD WHERE N_FACTURA=@N_fACTURA AND SALDONETO>0)
     BEGIN
         SELECT @RESPUESTA='FACTURA SIN SALDO'
         UPDATE #A SET  OBSERVACION=@RESPUESTA WHERE N_FACTURA=@N_fACTURA
	      FETCH NEXT FROM JM_CURSOR    
	      INTO @N_FACTURA    
         CONTINUE
     END 
     IF LEN(@RESPUESTA)=0
     BEGIN
         SELECT @RESPUESTA='FACTURA OK'
         UPDATE #A SET  OBSERVACION=@RESPUESTA WHERE N_FACTURA=@N_fACTURA        
     END    
	FETCH NEXT FROM JM_CURSOR    
	INTO @N_FACTURA
	END
	CLOSE JM_CURSOR
	DEALLOCATE JM_CURSOR


   SELECT * FROM #A