IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME='SPK_IZSOL_OME24_REVISAHABLI' AND XTYPE='P')
BEGIN
   DROP PROCEDURE SPK_IZSOL_OME24_REVISAHABLI
END
GO
CREATE PROC DBO.SPK_IZSOL_OME24_REVISAHABLI
@CNSIZSOLM    VARCHAR(20),
@IDSEDE       VARCHAR(5),
@USUARIO      VARCHAR(12),
@TIPO         INT=0,         -- 0=Todos, 1=Piso, 2=Sector, 3=Habitación, 4=Cama
@FILTRO       VARCHAR(20)=NULL
WITH ENCRYPTION
AS 
SET NOCOUNT ON
DECLARE @NOADMISION     VARCHAR(16),     @VECES           INT,           @HABCAMA          VARCHAR(10),    @SECTOR           VARCHAR(10),
        @CODOM          VARCHAR(10),     @INFUSION        SMALLINT,      @FRECUENCIA       DECIMAL(14,2),  @HORAULTIMADOSIS  SMALLINT,
        @FECHAMAX       DATETIME,        @FECHAULT        DATETIME,      @IDSERVICIO       VARCHAR(20),    @FECHA				  DATETIME,
        @FECHAPRIMER    DATETIME,        @VEZ             INT,           @QTOTDOSIS        DECIMAL(14,2),  @QTOTMEZCLA       DECIMAL(14,2),
        @CNSHBALI       VARCHAR(20),     @NCONSECUTIVO    INT,           @CANTIDAD         DECIMAL(18,6),  @CANTIDADBOLO     DECIMAL(14,2),
        @NCONSECUTIVOD  INT,             @CREAR           INT,           @IDSERVICIOMEZCLA VARCHAR(20),    @QMEZCLA          DECIMAL(14,2),
        @NUMHORASTOT    INT,             @NUMHORASIMP     INT,           @NUMHORASCON      INT,            @CNSIZSOLD        VARCHAR(20),
        @CNSIZSOL       VARCHAR(20),     @DURACIONIMP     DECIMAL(14,2), @QIMPSERVICIO     DECIMAL(14,2),  @QIMPMEZCLA       DECIMAL(14,2),
        @IDSEDEHAB      VARCHAR(5),      @IDBODEGAATIENDE VARCHAR(20),   @CLASEHTX         VARCHAR(2),     @FECHAULTHHOM     DATETIME,
        @RAZONNEC       SMALLINT,        @HORAAM          SMALLINT,      @QAM              DECIMAL(14,2),  @HORAPM           SMALLINT,       @QPM   DECIMAL(14,2),
        @FEC1           DATETIME,        @FEC2            DATETIME,      @TIP              SMALLINT,       @GOTEO            DECIMAL(14,2), 
        @INDBOLO        SMALLINT,        @Q1              DECIMAL(14,2), @Q2               DECIMAL(14,2) , @DURACION         DECIMAL(14,2), 
        @HORASXDOSIS    DECIMAL(14,2)=0, @SUMHXD          DECIMAL(14,2) = 0,
        @QDOSIS         DECIMAL(14,2)=0, @NUTPHADM        SMALLINT,      @FECHAHCA         DATETIME,       @CONSECUTIVOHCA   VARCHAR(13),
        @IDSERVICIONUTP VARCHAR(20),     @CANTIDADNUTP    DECIMAL(18,6), @CANTDOSIS        DECIMAL(14,2),  @CANTIDADT        DECIMAL(14,2),
        @JERARQUIA      VARCHAR(20),     @IDSERVICIODEF   VARCHAR(20),   @CANTIDADEF       DECIMAL(14,2),  @VECES_EN_T       DECIMAL(14,2),
        @T_ESTABILIDAD  DECIMAL(14,2),   @EQUICC          DECIMAL(14,2), @CNSHCA           VARCHAR(20),    @SOBRANTEN        DECIMAL(14,2), 
        @EQUICCINF      DECIMAL(14,2),   @EQUIVALE        DECIMAL(14,2), @SOBRANTE         DECIMAL(14,2),  @NUWTDOSIS        DECIMAL(14,2),
        @CNSHDUXS       VARCHAR(20),     @NUEVOHDUXS      VARCHAR(20),   @PEDIR            INT,            
        @IDSERVICIOANT  VARCHAR(20),     @NOMBRESER       VARCHAR(100),  @TDOSISINF        INT,
        @CONFAUT        SMALLINT,        @TIPOBODEGA      VARCHAR(10),   @IMPRECNACION     INT,            @ITEMRED          INT, 
        @IDAREA         VARCHAR(20),     @CCOSTO          VARCHAR(20),   @IDMEDICO         VARCHAR(12),	  @OMCODNUTRICIONP  VARCHAR(20),
		  @MPL_EVO			VARCHAR(20)
BEGIN
   SET @HORAULTIMADOSIS = DBO.FNK_HORAULTIMADOSIS()
   
   SELECT @FECHA    = CONVERT(DATE,FECHA) FROM IZSOLM WHERE CNSIZSOLM=@CNSIZSOLM 
	SET @FECHA	  = DATEADD(HOUR,@HORAULTIMADOSIS,@FECHA)
	SET @FECHAMAX = DATEADD(HOUR,24,@FECHA)

   --Cargo CODOM
   SELECT @OMCODNUTRICIONP=DATO FROM USVGS WHERE IDVARIABLE='OMCODNUTRICIONP'
   SELECT @MPL_EVO=DATO FROM USVGS WHERE IDVARIABLE='HCPLANTILLARED'
   
   
   --Se remplaza cursor para las diferentes camas
   DECLARE @CAMAS TABLE (ID INT IDENTITY(1,1), HABCAMA VARCHAR(10), SECTOR VARCHAR(10), NOADMISION VARCHAR(20), IDSEDE VARCHAR(5))
   DECLARE @FIX INT, @FIX_TO INT, @PASANDO INT=0
   	
   DECLARE @HHOM TABLE (ID INT, ITEM INT)
   DECLARE @FIX2 INT, @FIX2_TO INT, @ITEM_HHOM INT
   
   PRINT '@TIPO='+STR(@TIPO)
   PRINT '@FILTRO='+COALESCE(@FILTRO,'NO TRAIGO NADA')
   
   INSERT INTO @CAMAS (HABCAMA, SECTOR, NOADMISION, IDSEDE)
   SELECT HABCAMA, SECTOR, NOADMISION, IDSEDE FROM HHAB 
   WHERE  CLASE     = 'Cama'
	AND ESTADOHAB = 'Ocupada' 
	--AND COALESCE(NOADMISION,'') <>''
	AND EXISTS (SELECT 1 FROM HADM WHERE HADM.NOADMISION=HHAB.NOADMISION AND HADM.FACTURABLE=1 AND COALESCE(HADM.CERRADA,0)=0)
	AND EXISTS (SELECT 1 FROM HHOM WHERE HHOM.NOADMISION=HHAB.NOADMISION)
	AND SECTOR=(CASE @TIPO WHEN 2 THEN @FILTRO ELSE SECTOR END)
	AND COALESCE(NOADMISION,'')=CASE @TIPO WHEN 4 THEN COALESCE(@FILTRO,'') ELSE NOADMISION END
	--AND NOT EXISTS (SELECT 1 FROM IZSOL WHERE IZSOL.CNSIZSOLM=@CNSIZSOLM AND IZSOL.NOADMISION=HHAB.NOADMISION)
   ORDER BY SECTOR, HABCAMA
   --RETURN
   SELECT @FIX=1, @FIX_TO=COUNT(1) FROM @CAMAS
    BEGIN
      BEGIN TRY
		   SELECT @HABCAMA=HABCAMA, @SECTOR=SECTOR, @NOADMISION=NOADMISION, @IDSEDEHAB=IDSEDE FROM @CAMAS WHERE ID=@FIX
		
		   PRINT ''
         PRINT ' ========================= NOADMISION='+@NOADMISION+' ========================= '
		   PRINT ''

		
      
		
   /* --------------------------- MNKR --------------------------- */

		   --Se remplaza cursor para los diferentes servicios de la cama
		   INSERT INTO @HHOM (ID, ITEM)
		   SELECT ROW_NUMBER() OVER (ORDER BY ITEM) ID, ITEM 
		   FROM HHOM WHERE NOADMISION=@NOADMISION AND ESTADO='A' AND COALESCE(RAZONNEC,0)<>1

		   SELECT @FIX2=1, @FIX2_TO=COUNT(1) FROM @HHOM

		   WHILE @FIX2 <= @FIX2_TO
		   BEGIN
            BEGIN TRY
			   SELECT @ITEM_HHOM=ITEM FROM @HHOM WHERE ID=@FIX2

			   SELECT 
				   @IDSERVICIO=HHOM.IDSERVICIO, 
				   @CANTIDAD=HHOM.CANTIDAD, 
				   @FRECUENCIA=HHOM.FRECUENCIA, 
				   @CLASEHTX=SER.CLASEHTX, 
				   @CODOM=HHOM.CODOM, 
				   @FECHAULTHHOM=HHOM.FECHAULT, 
				   @IDSERVICIOMEZCLA=COALESCE(HHOM.IDSERVICIOMEZCLA,''), 
				   @QMEZCLA=COALESCE(HHOM.QMEZCLA,0), 
				   @QIMPSERVICIO=HHOM.QIMPSERVICIO, 
				   @QIMPMEZCLA=HHOM.QIMPMEZCLA, 
				   @DURACIONIMP=COALESCE(HHOM.DURACIONIMP,0.00), 
				   @RAZONNEC=COALESCE(HHOM.RAZONNEC,0), 
				   @HORAAM=HHOM.HORAAM, 
				   @QAM=HHOM.QAM, 
				   @HORAPM=HHOM.HORAPM, 
				   @QPM=HHOM.QPM,
				   @GOTEO=COALESCE(HHOM.GOTEO,0),
				   @DURACION=COALESCE(HHOM.DURACION,24)
			   FROM   HHOM INNER JOIN SER ON HHOM.IDSERVICIO=SER.IDSERVICIO
			   WHERE  HHOM.NOADMISION=@NOADMISION
				   AND HHOM.ITEM=@ITEM_HHOM
		

            IF @IDSERVICIOANT<>@IDSERVICIO
               SELECT @IDSERVICIOANT=@IDSERVICIO, @PASANDO=1
            ELSE
				   SELECT @PASANDO=@PASANDO+1


            PRINT ' ===== IDSERVICIO='+COALESCE(@IDSERVICIO,'NO SERVICIO')+' ===== '+LTRIM(RTRIM(STR(@PASANDO)))         

			
			 
            --si es nutricion parenteral debemos colocar en las variables los datos pero de hcatd y hacerlo una sola vez
            IF @CODOM = @OMCODNUTRICIONP
            BEGIN
               IF @NUTPHADM = 0
               BEGIN
                  SELECT @FECHAHCA = MAX(HCA.FECHA) 
                  FROM   HCATD INNER JOIN HCA ON HCATD.CONSECUTIVO=HCA.CONSECUTIVO 
                  WHERE  HCA.NOADMISION=@NOADMISION AND HCATD.CODOM=@CODOM 

                  SELECT @CONSECUTIVOHCA = HCA.CONSECUTIVO
                  FROM   HCA INNER JOIN HCATD ON HCA.CONSECUTIVO = HCATD.CONSECUTIVO
                  WHERE  HCA.NOADMISION=@NOADMISION AND HCATD.CODOM=@CODOM AND HCA.FECHA=@FECHAHCA

                  SELECT @FECHAULTHHOM = @FECHAHCA

                  SELECT @IDSERVICIO = HCATD.IDSERVICIO, @CANTIDAD = HCATD.CANTIDAD, 
                         @FRECUENCIA = CASE WHEN @INFUSION IN (1,2, 3) THEN CASE WHEN HCATD.FRECUENCIA < 1 THEN 2 ELSE HCATD.FRECUENCIA END 
                                                     ELSE CASE WHEN HCATD.FRECUENCIA < 1 THEN 1 ELSE HCATD.FRECUENCIA END
                                               END, 
                         @CLASEHTX = SER.CLASEHTX,  @IDSERVICIOMEZCLA = COALESCE(HCATD.IDSERVICIOMEZCLA,''), @QMEZCLA = COALESCE(HCATD.QMEZCLA,0), 
                         @QIMPSERVICIO = HCATD.QIMPSERVICIO,  @QIMPMEZCLA = HCATD.QIMPMEZCLA, 
                         @DURACIONIMP  = COALESCE(HCATD.DURACIONIMP,0.00), @RAZONNEC = COALESCE(HCATD.RAZONNEC,0), @HORAAM = HCATD.HORAAM,  @QAM = HCATD.QAM, 
                         @HORAPM = HCATD.HORAPM, @QPM = HCATD.QPM, 
                         @GOTEO  = COALESCE(HCATD.GOTEO,0)
                  FROM   HCATD INNER JOIN SER ON HCATD.IDSERVICIO = SER.IDSERVICIO
                               INNER JOIN HCA ON HCATD.CONSECUTIVO=HCA.CONSECUTIVO
                               INNER JOIN MPL ON HCA.CLASEPLANTILLA=MPL.CLASEPLANTILLA
                  WHERE  HCATD.CONSECUTIVO = @CONSECUTIVOHCA 
                  AND    HCATD.CODOM       = @CODOM
                  AND    HCATD.CLASE      <> 'S'
                  AND    COALESCE(HCATD.RAZONNEC,0) <> 1  
                  AND    COALESCE(MPL.NOCOPIAOM,0)=0

                  SELECT @NUTPHADM = 1 
               END
               ELSE
               BEGIN
					   SET @FIX2 += 1
                  CONTINUE
               END
            END


			   --Reviso infusiones
            IF (SELECT DATO FROM USVGS WHERE IDVARIABLE='OMCODMEZCLA') = @CODOM
               SELECT @INFUSION = 1
            ELSE
               IF (SELECT DATO FROM USVGS WHERE IDVARIABLE='OMCODLIQUIDOSPARE') = @CODOM  
                  SELECT @INFUSION = 2
               ELSE
                  IF @OMCODNUTRICIONP = @CODOM  
                     SELECT @INFUSION = 3
                  ELSE
                     SELECT @INFUSION = 0

            IF @INFUSION IN (1,2,3) 
               IF @FRECUENCIA < 1
                  SELECT @FRECUENCIA = 2
            ELSE
               IF @FRECUENCIA < 1
                  SELECT @FRECUENCIA = 2




            --Vamos a revisar ultima hora de aplicacion
            IF @RAZONNEC <> 2
            BEGIN
               --PRINT '@FECHAULT EN @RAZONNEC <> 2'
               SELECT @FECHAULT = DATEADD(HOUR,24,MAX(HBALIDD.FECHA))
               FROM   HBALID INNER JOIN HBALI   ON HBALID.CNSHBALI = HBALI.CNSHBALI
                             INNER JOIN HBALIDD ON HBALID.CNSHBALI = HBALIDD.CNSHBALI
                                               AND HBALID.NTIPO    = HBALIDD.NTIPO
                                               AND HBALID.NCONSECUTIVO = HBALIDD.NCONSECUTIVO  
               WHERE  HBALI.NOADMISION  = @NOADMISION
               AND    HBALID.IDSERVICIO = @IDSERVICIO
               AND    HBALID.CLASE      = @CODOM

               IF @FECHAULT IS NULL
               BEGIN
                  SELECT @FECHAULT =    @FECHA
               END
            END
            ELSE
            BEGIN
               --ES DE TIPO  AM PM   CON DIFERENTES DOSIS
               SELECT @TIP = 0        
               IF ( CONVERT(DATE,GETDATE()) = CONVERT(DATE,@FECHAMAX) )
               BEGIN
                  IF @HORAAM >= DATEPART(HH,GETDATE())
                  BEGIN
                     SELECT @FEC1 = CONVERT(DATETIME,CONVERT(VARCHAR(10),CONVERT(VARCHAR(10),GETDATE(),103))+ ' '+CONVERT(VARCHAR(2),@HORAAM)+':00')
                     SELECT @TIP   = 1, @Q1 = @QAM
                  END
                  ELSE 
                      SELECT @TIP  = 3
               END
               ELSE
               BEGIN
                  IF @HORAPM >= DATEPART(HH,GETDATE()) 
                  BEGIN
                     SELECT @FEC1 = CONVERT(DATETIME,CONVERT(VARCHAR(10),CONVERT(VARCHAR(10),GETDATE(),103))+ ' '+CONVERT(VARCHAR(2),@HORAPM)+':00')
                     SELECT @FEC2 = CONVERT(DATETIME,CONVERT(VARCHAR(10),CONVERT(VARCHAR(10),@FECHAMAX,103))+ ' '+CONVERT(VARCHAR(2),@HORAAM)+':00')
                     SELECT @TIP   = 2, @Q1 = @QPM, @Q2 = @QAM
                  END
                  ELSE
                  BEGIN
                     SELECT @FEC1 = CONVERT(DATETIME,CONVERT(VARCHAR(10),CONVERT(VARCHAR(10),@FECHAMAX,103))+ ' '+CONVERT(VARCHAR(2),@HORAAM)+':00')
                     SELECT @TIP   = 1, @Q1 = @QAM
                  END
               END
               --PRINT '@FECHA1='+CONVERT(VARCHAR(30),COALESCE(@FEC1,'01/01/1800'))+'//@FECHA2='+CONVERT(VARCHAR(30),COALESCE(@FEC2,'01/01/1800'))        
            END
			
            --PRINT '@ADMISION='+@NOADMISION + ' // @IDSERVICIO ='+@IDSERVICIO+'//@FECHAULT='+CONVERT(VARCHAR(20),COALESCE(@FECHAULT,'01/01/1900'))+
		      --'//@FECHAMAX='+CONVERT(VARCHAR(20),COALESCE(@FECHAMAX,'01/01/1900'))



            IF @RAZONNEC = 2
            BEGIN
               SELECT @FECHAULT=@FEC1, @CANTIDAD=@Q1
            END
            ELSE
            BEGIN
               --PRINT '@FECHAULT '+CONVERT(VARCHAR,@FECHAULT,109)
               --PRINT 'COMPARACION '+CONVERT(VARCHAR,DATEADD(DAY, -1, @FECHA),109)
               IF @FECHAULT < DATEADD(DAY, -1, @FECHA)
               BEGIN
                  --PRINT '@FECHAULT < DATEADD(DAY, -1, @FECHA)'
                  SELECT @FECHAULT = @FECHA
                  --PRINT '@FECHAULT '+CONVERT(VARCHAR,@FECHAULT,109)
               END
               ELSE
               BEGIN
                  IF CONVERT(DATE,@FECHAULT) = CONVERT(DATE,GETDATE()+1)  
                  BEGIN
                     --PRINT 'ME DEVUELVO UN DIA'
                     SELECT @FECHAULT=DATEADD(DAY, -1, @FECHAULT)
                     --PRINT 'AGREGRO LA PRIMERA PARA QUE SEA DESPUES DE LA ULTIMA DOSIS '
                     SELECT @FECHAULT = dbo.FNK_FECHA_SIN_MLS(DATEADD(HOUR,@FRECUENCIA,@FECHAULT))
                  END
                  ELSE
                  BEGIN 
                     --PRINT 'AGREGRO LA PRIMERA PARA QUE SEA DESPUES DE LA ULTIMA DOSIS'
                     IF COALESCE(@FRECUENCIA,2)<24
                     BEGIN
                        SELECT @FECHAULT = dbo.FNK_FECHA_SIN_MLS(DATEADD(HOUR,@FRECUENCIA,@FECHAULT))  
                        --PRINT '@FECHAULT FRECUENCA DIFRENTE A 24'+CONVERT(VARCHAR,@FECHAULT,109) 
                     END
                     ELSE
                     BEGIN
                        IF DATEPART(HOUR,@FECHAULT)<DATEPART(HOUR,@FECHAMAX)
                        BEGIN
                           PRINT 'HORA DE LA PRIMERA DOSIS MENOR A LA HORA DE CORTE, DEBO AGREGAR FRECUENCIA....'
                           SELECT @FECHAULT = dbo.FNK_FECHA_SIN_MLS(DATEADD(HOUR,@FRECUENCIA,@FECHAULT)) 
                           PRINT '@FECHAULT=   '+CONVERT(VARCHAR(20),COALESCE(@FECHAULT,'01/01/1900'))
                        END
                     END               
                  END

               END
            END


			   IF (((@FECHAULT >= @FECHAMAX) OR (@RAZONNEC = 2 AND @TIP = 3)) AND @FRECUENCIA<>24)
            BEGIN
               SET @FIX2 += 1
               --PRINT '@FECHAULT  == '+CONVERT(VARCHAR,@FECHAULT,109)
               --PRINT '@FECHAMAX =='+CONVERT(VARCHAR,@FECHAMAX,109)
               PRINT 'ME DEVUELVO'
               CONTINUE
            END
            --PRINT 'NO ME DEVOLVI'






			   /******************** HBALI ***************************/

            SELECT @FECHAPRIMER = @FECHAULT
            --PRINT '@IDSERVICIO='+@IDSERVICIO +'//CODOM='+@CODOM
            --PRINT 'ANTES DEL WHILE'
            --SELECT @FECHAULT = CONVERT(DATETIME,CONVERT(VARCHAR(10),@FECHAULT,103)+ ' '+ dbo.FNK_VALORVARIABLE('HORAULTIMADOSIS')+':00')
		      --PRINT '@FECHAULT='+CONVERT(VARCHAR(20),COALESCE(@FECHAULT,'01/01/1900'))
		      --PRINT '@@FECHAMAX='+CONVERT(VARCHAR(20),COALESCE(@FECHAMAX,'01/01/1900'))

   /* ------------- mnkr -------------- */
            SELECT @VEZ = 1, @QTOTDOSIS = 0, @QTOTMEZCLA = 0
            WHILE @FECHAULT <=  @FECHAMAX
            BEGIN
               PRINT 'COMIENZA EL WHILE'
		         PRINT '@FECHAULT='+CONVERT(VARCHAR(20),COALESCE(@FECHAULT,'01/01/1900'))
		         PRINT '@FECHAMAX='+CONVERT(VARCHAR(20),COALESCE(@FECHAMAX,'01/01/1900'))
               IF DATEPART(HOUR,@FECHAULT) < 7  --ANTES DE SIETE
               BEGIN
                  IF (SELECT COUNT(1) FROM HBALI WHERE NOADMISION = @NOADMISION AND CONVERT(DATE,FECHA) = CONVERT(DATETIME,CONVERT(VARCHAR,@FECHAULT-1,103))) = 0
                  BEGIN
                     EXEC SPK_GENCONSECUTIVO '01', @IDSEDE,'@HBALI', @CNSHBALI OUTPUT  --AQUI CAMBIE
                     SELECT @CNSHBALI = @IDSEDE + REPLACE(SPACE(10 - LEN(@CNSHBALI))+LTRIM(RTRIM(@CNSHBALI)),SPACE(1),0) 
                     INSERT INTO HBALI(CNSHBALI, NOADMISION, FECHA)
                     SELECT @CNSHBALI, @NOADMISION, CONVERT(DATE,@FECHAULT-1)
                  END
                  ELSE
                  BEGIN
                     SELECT @CNSHBALI = CNSHBALI FROM HBALI WHERE NOADMISION=@NOADMISION AND CONVERT(DATE,FECHA)=CONVERT(DATETIME,CONVERT(VARCHAR,@FECHAULT-1,103))
                  END

                  IF (SELECT COUNT(1) FROM HBALID WHERE CNSHBALI = @CNSHBALI AND TIPO = 'HOJA TRAT' AND IDSERVICIO = @IDSERVICIO AND CLASE = @CODOM) =  0
                  BEGIN                    
                     SELECT @NCONSECUTIVO = COALESCE(MAX(NCONSECUTIVO),0) FROM HBALID WHERE CNSHBALI = @CNSHBALI AND TIPO = 'HOJA TRAT' --AND IDSERVICIO = @IDSERVICIO
                     SELECT @NCONSECUTIVO = @NCONSECUTIVO + 1
                     --PRINT 'CREANDO HBALID POR LO TANTO EL NCONSECUTIVO = '+CONVERT(VARCHAR(3),@NCONSECUTIVO)
				         IF @INFUSION = 0
				         BEGIN
				            INSERT INTO HBALID(CNSHBALI, NTIPO, NCONSECUTIVO, TIPO, CLASE, IDSERVICIO, H07, H07EST, H08, H08EST, H09, H09EST, H10, H10EST, H11, H11EST,
					                            H12, H12EST, H13, H13EST, H14, H14EST, H15, H15EST, H16, H16EST, H17, H17EST, H18, H18EST, H19, H19EST, H20, H20EST,
					       		                H21, H21EST, H22, H22EST, H23, H23EST, H00, H00EST, H01, H01EST, H02, H02EST, H03, H03EST, H04, H04EST, H05, H05EST,
					                            H06, H06EST)                   
				 	         SELECT @CNSHBALI, 1, @NCONSECUTIVO , 'HOJA TRAT', @CODOM, @IDSERVICIO, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			 		                0, 0, 0, 0, 0, 0, 0, 0, 
                               CASE DATEPART(HOUR,@FECHAULT) WHEN 0 THEN @CANTIDAD ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 0 THEN 1 ELSE 0 END,
                               CASE DATEPART(HOUR,@FECHAULT) WHEN 1 THEN @CANTIDAD ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 1 THEN 1 ELSE 0 END,
                               CASE DATEPART(HOUR,@FECHAULT) WHEN 2 THEN @CANTIDAD ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 2 THEN 1 ELSE 0 END,
                               CASE DATEPART(HOUR,@FECHAULT) WHEN 3 THEN @CANTIDAD ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 3 THEN 1 ELSE 0 END,
                               CASE DATEPART(HOUR,@FECHAULT) WHEN 4 THEN @CANTIDAD ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 4 THEN 1 ELSE 0 END,
                               CASE DATEPART(HOUR,@FECHAULT) WHEN 5 THEN @CANTIDAD ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 5 THEN 1 ELSE 0 END,
                               CASE DATEPART(HOUR,@FECHAULT) WHEN 6 THEN @CANTIDAD ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 6 THEN 1 ELSE 0 END
                     END                     
                     --AQUI SE DEBEN INSERTAR LOS DILUYENTES Y LAS INFUSIONES AL BALANCE DE LIQUIDOS
                     IF (COALESCE(@QMEZCLA,0) <> 0 AND COALESCE(@IDSERVICIOMEZCLA,'') <> '') OR (COALESCE(@INFUSION,0) IN (2,3))
                     BEGIN
                        SELECT @CREAR = 1
                        IF @INFUSION IN (1,2,3) -- 1: Infusión, 2: Líquido Base o de Sostenimiento, 3: Nutrición Parenteral
                           IF (SELECT COUNT(*) FROM HBALID WHERE CNSHBALI = @CNSHBALI AND IDSERVICIO = @IDSERVICIO 
                               AND    CLASE = CASE @INFUSION WHEN 1 THEN 'INFUSION' WHEN 2 THEN 'LIQSOSTE' WHEN 3 THEN 'NUTRICION' END) > 0
                               SELECT @CREAR = 0                        
                        IF @CREAR = 1
                        BEGIN 
                           SELECT @NCONSECUTIVOD = COALESCE(MAX(NCONSECUTIVO),0) FROM HBALID WHERE CNSHBALI = @CNSHBALI AND TIPO = 'BALIQ' AND NCONSECUTIVO < 200
                           SELECT @NCONSECUTIVOD = COALESCE(@NCONSECUTIVOD,0) + 1
                           INSERT INTO HBALID(CNSHBALI, NTIPO, NCONSECUTIVO, TIPO, CLASE, IDSERVICIO, H07, H07EST, H08, H08EST, H09, H09EST, H10, H10EST, H11, H11EST,
                                              H12, H12EST, H13, H13EST, H14, H14EST, H15, H15EST, H16, H16EST, H17, H17EST, H18, H18EST, H19, H19EST, H20, H20EST,
                                              H21, H21EST, H22, H22EST, H23, H23EST, H00, H00EST, H01, H01EST, H02, H02EST, H03, H03EST, H04, H04EST, H05, H05EST,
                                              H06, H06EST, IDSERVICIOMED, EG_IN, CLAMED)                   
                           SELECT @CNSHBALI, 2, @NCONSECUTIVOD , 'BALIQ', CASE COALESCE(@INFUSION,0) WHEN 1 THEN 'INFUSION' 
                                                                                                     WHEN 2 THEN 'LIQSOSTE' 
                                                                                                     WHEN 3 THEN 'NUTRICION'
                                                                                                     ELSE 'HOJA TRAT' END, 
                                  CASE COALESCE(@INFUSION,0) WHEN 1 THEN @IDSERVICIO WHEN 2 THEN @IDSERVICIO ELSE @IDSERVICIOMEZCLA END, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 0 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 0 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 1 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 1 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 2 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 2 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 3 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 3 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 4 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 4 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 5 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 5 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 6 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 6 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE COALESCE(@INFUSION,0) WHEN 1 THEN @IDSERVICIOMEZCLA WHEN 2 THEN '' ELSE @IDSERVICIO END, 'IN', @CODOM
                        END
                     END
                  END
                  ELSE
                  BEGIN
                     SELECT @NCONSECUTIVO = NCONSECUTIVO FROM HBALID WHERE CNSHBALI = @CNSHBALI AND IDSERVICIO = @IDSERVICIO AND CLASE = @CODOM 
                     --PRINT 'YA EXISTE HBALID POR LO TANTO EL NCONSECUTIVO = '+CONVERT(VARCHAR(3),@NCONSECUTIVO)
                     IF @INFUSION = 0
                     BEGIN
                        UPDATE HBALID  SET H00    = CASE WHEN DATEPART(HOUR,@FECHAULT)=0 AND H00=0    THEN @CANTIDAD ELSE H00 END, 
                                           H00EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=0 AND H00EST=0 THEN 1 ELSE H00EST END,
                                           H01    = CASE WHEN DATEPART(HOUR,@FECHAULT)=1 AND H01=0    THEN @CANTIDAD ELSE H01 END, 
                                           H01EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=1 AND H01EST=0 THEN 1 ELSE H01EST END,
                                           H02    = CASE WHEN DATEPART(HOUR,@FECHAULT)=2 AND H02=0    THEN @CANTIDAD ELSE H02 END, 
                                           H02EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=2 AND H02EST=0 THEN 1 ELSE H02EST END,
                                           H03    = CASE WHEN DATEPART(HOUR,@FECHAULT)=3 AND H03=0    THEN @CANTIDAD ELSE H03 END, 
                                           H03EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=3 AND H03EST=0 THEN 1 ELSE H03EST END,
                                           H04    = CASE WHEN DATEPART(HOUR,@FECHAULT)=4 AND H04=0    THEN @CANTIDAD ELSE H04 END, 
                                           H04EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=4 AND H04EST=0 THEN 1 ELSE H04EST END,
                                           H05    = CASE WHEN DATEPART(HOUR,@FECHAULT)=5 AND H05=0    THEN @CANTIDAD ELSE H05 END, 
                                           H05EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=5 AND H05EST=0 THEN 1 ELSE H05EST END,
                                           H06    = CASE WHEN DATEPART(HOUR,@FECHAULT)=6 AND H06=0    THEN @CANTIDAD ELSE H06 END, 
                                           H06EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=6 AND H06EST=0 THEN 1 ELSE H06EST END
                        WHERE  CNSHBALI   = @CNSHBALI
                        AND    IDSERVICIO = @IDSERVICIO
                        AND    NTIPO      = 1
                        AND    TIPO       = 'HOJA TRAT' 
                        AND    CLASE      = @CODOM
                        --SELECT @FECHAULT, @IDSERVICIO, @CNSHBALI
                     END


                     IF @QMEZCLA <> 0 AND COALESCE(@IDSERVICIOMEZCLA,'') <> '' AND COALESCE(@INFUSION,0) = 0
                     BEGIN
                        UPDATE HBALID  SET H00    = CASE DATEPART(HOUR,@FECHAULT) WHEN 0 THEN @QMEZCLA ELSE H00 END, 
                                           H00EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 0 THEN 1 ELSE H00EST END,
                                           H01    = CASE DATEPART(HOUR,@FECHAULT) WHEN 1 THEN @QMEZCLA ELSE H01 END, 
                                           H01EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 1 THEN 1 ELSE H01EST END,
                                           H02    = CASE DATEPART(HOUR,@FECHAULT) WHEN 2 THEN @QMEZCLA ELSE H02 END, 
                                           H02EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 2 THEN 1 ELSE H02EST END,
                                           H03    = CASE DATEPART(HOUR,@FECHAULT) WHEN 3 THEN @QMEZCLA ELSE H03 END, 
                                           H03EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 3 THEN 1 ELSE H03EST END,
                                           H04    = CASE DATEPART(HOUR,@FECHAULT) WHEN 4 THEN @QMEZCLA ELSE H04 END, 
                                           H04EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 4 THEN 1 ELSE H04EST END,
                                           H05    = CASE DATEPART(HOUR,@FECHAULT) WHEN 5 THEN @QMEZCLA ELSE H05 END, 
                                           H05EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 5 THEN 1 ELSE H05EST END,
                                           H06    = CASE DATEPART(HOUR,@FECHAULT) WHEN 6 THEN @QMEZCLA ELSE H06 END, 
                                           H06EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 6 THEN 1 ELSE H06EST END
                        WHERE  CNSHBALI   = @CNSHBALI
                        AND    IDSERVICIO = @IDSERVICIOMEZCLA
                        AND    NTIPO      = 2
                        AND    TIPO       = 'BALIQ'
                        AND    CLASE      = 'HOJA TRAT' 
                        AND    CLAMED     = @CODOM
                        AND    IDSERVICIOMED = @IDSERVICIO
                     END
                  END

                  IF @INFUSION =0
                  BEGIN
                     IF (SELECT COUNT(1) 
                         FROM   HBALIDD 
                         WHERE  CNSHBALI     = @CNSHBALI 
                         AND    NTIPO        = 1 
                         AND    NCONSECUTIVO = @NCONSECUTIVO 
                         AND    IDSERVICIO   = @IDSERVICIO 
                         AND    HORA         = DATEPART(HOUR,@FECHAULT)) = 0
                     BEGIN
                        INSERT INTO HBALIDD ( CNSHBALI, NTIPO, NCONSECUTIVO, IDSERVICIO, HORA, QAPLICADA, FECHA)
                        SELECT @CNSHBALI, 1, @NCONSECUTIVO, @IDSERVICIO, DATEPART(HOUR,@FECHAULT), @CANTIDAD , 
                               @FECHAULT
                     END
                  END
               END
               ELSE
               BEGIN   --'DESPUES DE 7'
                  --PRINT 'DESPUES DE 7'
                  --PRINT '@IDSERVICIO ='+@IDSERVICIO+' // CODOM = '+@CODOM
                  SELECT @NCONSECUTIVO = 0
                  IF (SELECT COUNT(1) FROM HBALI WHERE NOADMISION = @NOADMISION AND CONVERT(DATE,FECHA) = CONVERT(DATETIME,CONVERT(VARCHAR,@FECHAULT,103)))= 0
                  BEGIN                        
                     EXEC SPK_GENCONSECUTIVO '01',@IDSEDE,'@HBALI', @CNSHBALI OUTPUT  
                     SELECT @CNSHBALI = @IDSEDE + REPLACE(SPACE(10 - LEN(@CNSHBALI))+LTRIM(RTRIM(@CNSHBALI)),SPACE(1),0) 
                     INSERT INTO HBALI(CNSHBALI, NOADMISION, FECHA)
                     SELECT @CNSHBALI, @NOADMISION, CONVERT(DATE,@FECHAULT)
                  END
                  ELSE
                  BEGIN
                     SELECT @CNSHBALI = CNSHBALI FROM HBALI WHERE NOADMISION = @NOADMISION AND CONVERT(DATE,FECHA) = CONVERT(DATETIME,CONVERT(VARCHAR,@FECHAULT,103))
                  END
                  IF (SELECT COUNT(1) FROM HBALID WHERE CNSHBALI = @CNSHBALI AND TIPO = 'HOJA TRAT' AND IDSERVICIO = @IDSERVICIO AND CLASE = @CODOM) =  0
                  BEGIN
                     SELECT @NCONSECUTIVO = COALESCE(MAX(NCONSECUTIVO),0) FROM HBALID WHERE CNSHBALI = @CNSHBALI AND TIPO = 'HOJA TRAT'
                     SELECT @NCONSECUTIVO = COALESCE(@NCONSECUTIVO,0) + 1
                     IF @INFUSION = 0
			            BEGIN 
                        --PRINT 'INSERTO INFUSION = 0'
                        INSERT INTO HBALID(CNSHBALI, NTIPO, NCONSECUTIVO, TIPO, CLASE, IDSERVICIO, H07, H07EST, H08, H08EST, H09, H09EST, H10, H10EST, H11, H11EST,
                                         H12, H12EST, H13, H13EST, H14, H14EST, H15, H15EST, H16, H16EST, H17, H17EST, H18, H18EST, H19, H19EST, H20, H20EST,
                                         H21, H21EST, H22, H22EST, H23, H23EST, H00, H00EST, H01, H01EST, H02, H02EST, H03, H03EST, H04, H04EST, H05, H05EST,
                                         H06, H06EST)                   
                        SELECT @CNSHBALI, 1, @NCONSECUTIVO, 'HOJA TRAT', @CODOM, @IDSERVICIO, 
                             CASE DATEPART(HOUR,@FECHAULT) WHEN 7 THEN @CANTIDAD 
                                                                  ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 7 THEN 1 ELSE 0 END,
                             CASE DATEPART(HOUR,@FECHAULT) WHEN 8 THEN @CANTIDAD
                                                                  ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 8 THEN 1 ELSE 0 END,
                             CASE DATEPART(HOUR,@FECHAULT) WHEN 9  THEN @CANTIDAD 
                                                                   ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 9 THEN 1 ELSE 0 END,
                             CASE DATEPART(HOUR,@FECHAULT) WHEN 10 THEN @CANTIDAD 
                                                                   ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 10 THEN 1 ELSE 0 END,
                             CASE DATEPART(HOUR,@FECHAULT) WHEN 11 THEN @CANTIDAD 
                                                                   ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 11 THEN 1 ELSE 0 END,
                             CASE DATEPART(HOUR,@FECHAULT) WHEN 12 THEN @CANTIDAD 
                                                                   ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 12 THEN 1 ELSE 0 END,
                             CASE DATEPART(HOUR,@FECHAULT) WHEN 13 THEN @CANTIDAD 
                                                                   ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 13 THEN 1 ELSE 0 END,
                             CASE DATEPART(HOUR,@FECHAULT) WHEN 14 THEN @CANTIDAD 
                                                                   ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 14 THEN 1 ELSE 0 END,
                             CASE DATEPART(HOUR,@FECHAULT) WHEN 15 THEN @CANTIDAD 
                                                                   ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 15 THEN 1 ELSE 0 END,
                             CASE DATEPART(HOUR,@FECHAULT) WHEN 16 THEN @CANTIDAD 
                                                                   ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 16 THEN 1 ELSE 0 END,
                             CASE DATEPART(HOUR,@FECHAULT) WHEN 17 THEN @CANTIDAD 
                                                                        ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 17 THEN 1 ELSE 0 END,
                             CASE DATEPART(HOUR,@FECHAULT) WHEN 18 THEN @CANTIDAD 
                                                                        ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 18 THEN 1 ELSE 0 END,
                             CASE DATEPART(HOUR,@FECHAULT) WHEN 19 THEN @CANTIDAD 
                                                                        ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 19 THEN 1 ELSE 0 END,
                             CASE DATEPART(HOUR,@FECHAULT) WHEN 20 THEN @CANTIDAD 
                                                                   ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 20 THEN 1 ELSE 0 END,
                             CASE DATEPART(HOUR,@FECHAULT) WHEN 21 THEN @CANTIDAD 
                                                                   ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 21 THEN 1 ELSE 0 END,
                             CASE DATEPART(HOUR,@FECHAULT) WHEN 22 THEN @CANTIDAD 
                                                                   ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 22 THEN 1 ELSE 0 END,
                             CASE DATEPART(HOUR,@FECHAULT) WHEN 23 THEN @CANTIDAD 
                                                                   ELSE 0 END, CASE DATEPART(HOUR,@FECHAULT) WHEN 23 THEN 1 ELSE 0 END,
                             0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                     END
                     --AQUI SE DEBEN INSERTAR LOS DILUYENTES Y LAS INFUSIONES AL BALANCE DE LIQUIDOS
                     IF (COALESCE(@QMEZCLA,0) <> 0 AND COALESCE(@IDSERVICIOMEZCLA,'') <> '') OR (COALESCE(@INFUSION,0) IN (2,3))
                     BEGIN
                        SELECT @CREAR = 1
                        IF @INFUSION IN (1,2,3)
                           IF (SELECT COUNT(1) FROM HBALID WHERE CNSHBALI = @CNSHBALI AND IDSERVICIO = @IDSERVICIO 
                               AND    CLASE = CASE @INFUSION WHEN 1 THEN 'INFUSION' WHEN 2 THEN 'LIQSOSTE' WHEN 3 THEN 'NUTRICION' END) > 0
                               SELECT @CREAR = 0
                        IF @CREAR = 1
                        BEGIN
                           --PRINT 'DESP 7 INSERTO DILUYENTE O INFUSION = 2'
                           SELECT @NCONSECUTIVOD = COALESCE(MAX(NCONSECUTIVO),0) FROM HBALID WHERE CNSHBALI = @CNSHBALI AND TIPO = 'BALIQ' AND NCONSECUTIVO < 200
                           SELECT @NCONSECUTIVOD = COALESCE(@NCONSECUTIVOD,0) + 1

                           INSERT INTO HBALID(CNSHBALI, NTIPO, NCONSECUTIVO, TIPO, CLASE, IDSERVICIO, H07, H07EST, H08, H08EST, H09, H09EST, H10, H10EST, H11, H11EST,
                                              H12, H12EST, H13, H13EST, H14, H14EST, H15, H15EST, H16, H16EST, H17, H17EST, H18, H18EST, H19, H19EST, H20, H20EST,
                                              H21, H21EST, H22, H22EST, H23, H23EST, H00, H00EST, H01, H01EST, H02, H02EST, H03, H03EST, H04, H04EST, H05, H05EST,
                                              H06, H06EST, IDSERVICIOMED, EG_IN, CLAMED)
                           SELECT @CNSHBALI, 2, @NCONSECUTIVOD , 'BALIQ', CASE COALESCE(@INFUSION,0) WHEN 1 THEN 'INFUSION' 
                                                                                                     WHEN 2 THEN 'LIQSOSTE' 
                                                                                                     WHEN 3 THEN 'NUTRICION'
                                                                                                     ELSE 'HOJA TRAT' END, 
                                  CASE COALESCE(@INFUSION,0) WHEN 1 THEN @IDSERVICIO WHEN 2 THEN @IDSERVICIO WHEN 3 THEN @IDSERVICIO ELSE @IDSERVICIOMEZCLA END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 7 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 7 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 8 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 8 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 9 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 9 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 10 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 10 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 11 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 11 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 12 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 12 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 13 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 13 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 14 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 14 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 15 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 15 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 16 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 16 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 17 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 17 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 18 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 18 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 19 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 19 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 20 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 20 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 21 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 21 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 22 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 22 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 23 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE @QMEZCLA END ELSE 0 END, 
                                  CASE DATEPART(HOUR,@FECHAULT) WHEN 23 THEN CASE @INFUSION WHEN 1 THEN 0 WHEN 2 THEN 0 WHEN 3 THEN 0 ELSE 1 END ELSE 0 END,
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                                  CASE COALESCE(@INFUSION,0) WHEN 1 THEN @IDSERVICIOMEZCLA WHEN 2 THEN '' ELSE @IDSERVICIO END, 'IN', @CODOM
                        END
                     END
                  END
                  ELSE
                  BEGIN
                     IF @INFUSION = 0
					      BEGIN
                        SELECT @NCONSECUTIVO = NCONSECUTIVO FROM HBALID WHERE CNSHBALI = @CNSHBALI AND IDSERVICIO = @IDSERVICIO AND CLASE = @CODOM
                        UPDATE HBALID  SET H07    = CASE WHEN DATEPART(HOUR,@FECHAULT)=7  AND H07=0    THEN @CANTIDAD ELSE H07 END, 
                                           H07EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=7  AND H07EST=0 THEN 1 ELSE H07EST END,
                                           H08    = CASE WHEN DATEPART(HOUR,@FECHAULT)=8  AND H08=0    THEN @CANTIDAD ELSE H08 END, 
                                           H08EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=8  AND H08EST=0 THEN 1 ELSE H08EST END,
                                           H09    = CASE WHEN DATEPART(HOUR,@FECHAULT)=9  AND H09=0    THEN @CANTIDAD ELSE H09 END, 
                                           H09EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=9  AND H09EST=0 THEN 1 ELSE H09EST END,
                                           H10    = CASE WHEN DATEPART(HOUR,@FECHAULT)=10 AND H10=0    THEN @CANTIDAD ELSE H10 END, 
                                           H10EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=10 AND H10EST=0 THEN 1 ELSE H10EST END,
                                           H11    = CASE WHEN DATEPART(HOUR,@FECHAULT)=11 AND H11=0    THEN @CANTIDAD ELSE H11 END, 
                                           H11EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=11 AND H11EST=0 THEN 1 ELSE H11EST END,
                                           H12    = CASE WHEN DATEPART(HOUR,@FECHAULT)=12 AND H12=0    THEN @CANTIDAD ELSE H12 END, 
                                           H12EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=12 AND H12EST=0 THEN 1 ELSE H12EST END,
                                           H13    = CASE WHEN DATEPART(HOUR,@FECHAULT)=13 AND H13=0    THEN @CANTIDAD ELSE H13 END, 
                                           H13EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=13 AND H13EST=0 THEN 1 ELSE H13EST END,
                                           H14    = CASE WHEN DATEPART(HOUR,@FECHAULT)=14 AND H14=0    THEN @CANTIDAD ELSE H14 END, 
                                           H14EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=14 AND H14EST=0 THEN 1 ELSE H14EST END,
                                           H15    = CASE WHEN DATEPART(HOUR,@FECHAULT)=15 AND H15=0    THEN @CANTIDAD ELSE H15 END, 
                                           H15EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=15 AND H15EST=0 THEN 1 ELSE H15EST END,
                                           H16    = CASE WHEN DATEPART(HOUR,@FECHAULT)=16 AND H16=0    THEN @CANTIDAD ELSE H16 END, 
                                           H16EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=16 AND H16EST=0 THEN 1 ELSE H16EST END,
                                           H17    = CASE WHEN DATEPART(HOUR,@FECHAULT)=17 AND H17=0    THEN @CANTIDAD ELSE H17 END, 
                                           H17EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=17 AND H17EST=0 THEN 1 ELSE H17EST END,
                                           H18    = CASE WHEN DATEPART(HOUR,@FECHAULT)=18 AND H18=0    THEN @CANTIDAD ELSE H18 END, 
                                           H18EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=18 AND H18EST=0 THEN 1 ELSE H18EST END,
                                           H19    = CASE WHEN DATEPART(HOUR,@FECHAULT)=19 AND H19=0    THEN @CANTIDAD ELSE H19 END, 
                                           H19EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=19 AND H19EST=0 THEN 1 ELSE H19EST END,
                                           H20    = CASE WHEN DATEPART(HOUR,@FECHAULT)=20 AND H20=0    THEN @CANTIDAD ELSE H20 END, 
                                           H20EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=20 AND H20EST=0 THEN 1 ELSE H20EST END,
                                           H21    = CASE WHEN DATEPART(HOUR,@FECHAULT)=21 AND H21=0    THEN @CANTIDAD ELSE H21 END, 
                                           H21EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=21 AND H21EST=0 THEN 1 ELSE H21EST END,
                                           H22    = CASE WHEN DATEPART(HOUR,@FECHAULT)=22 AND H22=0    THEN @CANTIDAD ELSE H22 END, 
                                           H22EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=22 AND H22EST=0 THEN 1 ELSE H22EST END,
                                           H23    = CASE WHEN DATEPART(HOUR,@FECHAULT)=23 AND H23=0    THEN @CANTIDAD ELSE H23 END, 
                                           H23EST = CASE WHEN DATEPART(HOUR,@FECHAULT)=23 AND H23EST=0 THEN 1 ELSE H23EST END
                        WHERE  CNSHBALI   = @CNSHBALI
                        AND    IDSERVICIO = @IDSERVICIO
                        AND    TIPO       = 'HOJA TRAT'
                        AND    CLASE      = @CODOM
                     END
   --query 2
                     IF COALESCE(@QMEZCLA,0) <> 0 AND COALESCE(@IDSERVICIOMEZCLA,'') <> '' AND COALESCE(@INFUSION,0) = 0
                     BEGIN
                        --SELECT @NCONSECUTIVO = NCONSECUTIVO FROM HBALID WHERE CNSHBALI = @CNSHBALI AND IDSERVICIO = @IDSERVICIO
                        UPDATE HBALID  SET H07    = CASE DATEPART(HOUR,@FECHAULT) WHEN 7 THEN @QMEZCLA ELSE H07 END, 
                                           H07EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 7 THEN 1 ELSE H07EST END,
                                           H08    = CASE DATEPART(HOUR,@FECHAULT) WHEN 8 THEN @QMEZCLA ELSE H08 END, 
                                           H08EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 8 THEN 1 ELSE H08EST END,
                                           H09    = CASE DATEPART(HOUR,@FECHAULT) WHEN 9 THEN @QMEZCLA ELSE H09 END, 
                                           H09EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 9 THEN 1 ELSE H09EST END,
                                           H10    = CASE DATEPART(HOUR,@FECHAULT) WHEN 10 THEN @QMEZCLA ELSE H10 END, 
                                           H10EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 10 THEN 1 ELSE H10EST END,
                                           H11    = CASE DATEPART(HOUR,@FECHAULT) WHEN 11 THEN @QMEZCLA ELSE H11 END, 
                                           H11EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 11 THEN 1 ELSE H11EST END,
                                           H12    = CASE DATEPART(HOUR,@FECHAULT) WHEN 12 THEN @QMEZCLA ELSE H12 END, 
                                           H12EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 12 THEN 1 ELSE H12EST END,
                                           H13    = CASE DATEPART(HOUR,@FECHAULT) WHEN 13 THEN @QMEZCLA ELSE H13 END, 
                                           H13EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 13 THEN 1 ELSE H13EST END,
                                           H14    = CASE DATEPART(HOUR,@FECHAULT) WHEN 14 THEN @QMEZCLA ELSE H14 END, 
                                           H14EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 14 THEN 1 ELSE H14EST END,
                                           H15    = CASE DATEPART(HOUR,@FECHAULT) WHEN 15 THEN @QMEZCLA ELSE H15 END, 
                                           H15EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 15 THEN 1 ELSE H15EST END,
                                           H16    = CASE DATEPART(HOUR,@FECHAULT) WHEN 16 THEN @QMEZCLA ELSE H16 END, 
                                           H16EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 16 THEN 1 ELSE H16EST END,
                                           H17    = CASE DATEPART(HOUR,@FECHAULT) WHEN 17 THEN @QMEZCLA ELSE H17 END, 
                                           H17EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 17 THEN 1 ELSE H17EST END,
                                           H18    = CASE DATEPART(HOUR,@FECHAULT) WHEN 18 THEN @QMEZCLA ELSE H18 END, 
                                           H18EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 18 THEN 1 ELSE H18EST END,
                                           H19    = CASE DATEPART(HOUR,@FECHAULT) WHEN 19 THEN @QMEZCLA ELSE H19 END, 
                                           H19EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 19 THEN 1 ELSE H19EST END,
                                           H20    = CASE DATEPART(HOUR,@FECHAULT) WHEN 20 THEN @QMEZCLA ELSE H20 END, 
                                           H20EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 20 THEN 1 ELSE H20EST END,
                                           H21    = CASE DATEPART(HOUR,@FECHAULT) WHEN 21 THEN @QMEZCLA ELSE H21 END, 
                                           H21EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 21 THEN 1 ELSE H21EST END,
                                           H22    = CASE DATEPART(HOUR,@FECHAULT) WHEN 22 THEN @QMEZCLA ELSE H22 END, 
                                           H22EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 22 THEN 1 ELSE H22EST END,
                                           H23    = CASE DATEPART(HOUR,@FECHAULT) WHEN 23 THEN @QMEZCLA ELSE H23 END, 
                                           H23EST = CASE DATEPART(HOUR,@FECHAULT) WHEN 23 THEN 1 ELSE H23EST END
                        WHERE  CNSHBALI   = @CNSHBALI
                        AND    IDSERVICIO = @IDSERVICIOMEZCLA
                        AND    NTIPO      = 2
                        AND    TIPO       = 'BALIQ'
                        AND    CLASE      = 'HOJA TRAT' 
                        AND    CLAMED     = @CODOM
                        AND    IDSERVICIOMED = @IDSERVICIO
                     END
                  END
                  IF @INFUSION =0
                  BEGIN
                     IF (SELECT COUNT(*) 
                         FROM   HBALIDD 
                         WHERE  CNSHBALI   = @CNSHBALI AND NTIPO = 1 AND NCONSECUTIVO = @NCONSECUTIVO 
                         AND    IDSERVICIO = @IDSERVICIO AND HORA = DATEPART(HOUR,@FECHAULT)) = 0
                     BEGIN
                        INSERT INTO HBALIDD ( CNSHBALI, NTIPO, NCONSECUTIVO, IDSERVICIO, HORA, QAPLICADA, FECHA)
                        SELECT @CNSHBALI, 1, @NCONSECUTIVO, @IDSERVICIO, DATEPART(HOUR,@FECHAULT), @CANTIDAD, 
                               @FECHAULT
                     END   
                  END
               END
               --PRINT 'ME PREPRARO PARA INICIAR CONTINUAR WHILE'
               --PRINT '@INFUSION ==='+LTRIM(RTRIM(STR(@INFUSION)))
               --PRINT 'ANTES DE AGREGAR LA FRECUENCIA'
		         --PRINT '@FECHAULT='+CONVERT(VARCHAR(20),COALESCE(@FECHAULT,'01/01/1900'))
		         --PRINT '@@FECHAMAX='+CONVERT(VARCHAR(20),COALESCE(@FECHAMAX,'01/01/1900'))
               IF COALESCE(@FRECUENCIA,0)<1
               BEGIN
                  SELECT @FRECUENCIA=2
               END
               IF @FRECUENCIA<24
               BEGIN
                  SELECT @FECHAULT =  dbo.FNK_FECHA_SIN_MLS(DATEADD(HOUR,@FRECUENCIA,@FECHAULT))
               END
               ELSE
               BEGIN
                  SELECT @FECHAULT=dbo.FNK_FECHA_SIN_MLS(DATEADD(HOUR,1,@FECHAMAX)) 
               END
               PRINT 'YA AGREGUE UNA FRECUENCIA'+STR(@FRECUENCIA)  	
		         PRINT '@FECHAULT='+CONVERT(VARCHAR(20),COALESCE(@FECHAULT,'01/01/1900'))
		         PRINT '@FECHAMAX='+CONVERT(VARCHAR(20),COALESCE(@FECHAMAX,'01/01/1900'))           
            	      
               IF @INFUSION <> 1
               BEGIN
                  --PRINT ' LLEVO EL TOTAL  @QTOTDOSIS ==='+LTRIM(RTRIM(STR(@QTOTDOSIS)))
                  --PRINT '@CANTIDAD  +++'+LTRIM(RTRIM(STR(@CANTIDAD)))
                  SELECT @QTOTDOSIS  = @QTOTDOSIS + @CANTIDAD 
                  SELECT @QTOTMEZCLA = @QTOTMEZCLA + @QMEZCLA
                  --PRINT ' LLEVO EL TOTAL   @QTOTDOSIS  DESPUES DE AGREGAR==='+LTRIM(RTRIM(STR(@QTOTDOSIS)))
               END
               IF @RAZONNEC = 2 
               BEGIN
                  --PRINT 'INGRESO POR @RAZONNEC = 2 '
                  IF @TIP = 2
                     SELECT @FECHAULT =  @FEC2, @CANTIDAD = @Q2
                  ELSE
                     IF @TIP = 1
                        --PRINT 'INGRESO POR ACA RARO....'
                        SELECT @FECHAULT = @FECHAMAX + 1
               END
               IF @RAZONNEC = 2 AND @TIP = 2 AND @VEZ = 2  --ROMPEMOS SI ES DE AMPM Y YA VAN LAS DOS HORAS INCLUIDAS
               BEGIN
                  --PRINT 'ROMPIMIENTO'
                  BREAK
               END
               SELECT @VEZ += 1 
               --PRINT 'DEBO REGRESAR +'+STR(@VEZ)
               --PRINT 'AGREGO FECHA PARA EL WHIELE'
		         --PRINT '@FECHAULT='+CONVERT(VARCHAR(20),COALESCE(@FECHAULT,'01/01/1900'))
		         --PRINT '@@FECHAMAX='+CONVERT(VARCHAR(20),COALESCE(@FECHAMAX,'01/01/1900'))  
            END --SALI DE CICLO DE FRECUENCIA
            --PRINT 'FIN DEFINITIVO WHILE'

            END TRY
            BEGIN CATCH
               PRINT ERROR_MESSAGE()
            END CATCH
			   SET @FIX2 += 1
         END --Cierro @HHOM
		   DELETE @HHOM
		END TRY
      BEGIN CATCH
         PRINT ERROR_MESSAGE()
      END CATCH
		SET @FIX += 1
   END --Cierro @CAMAS
	DELETE @CAMAS
END