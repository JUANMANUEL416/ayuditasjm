IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'SPKH_GENERACXC_FACTURA_PARTICULAR' AND TYPE = 'P')
BEGIN
   DROP PROCEDURE SPKH_GENERACXC_FACTURA_PARTICULAR
END
GO
CREATE PROCEDURE DBO.SPKH_GENERACXC_FACTURA_PARTICULAR 
@N_FACTURA   VARCHAR(20)  
WITH ENCRYPTION
AS  
DECLARE @EXISTE INT
DECLARE @ITEM_FCXCDV   INT
DECLARE @CNSFPAG       VARCHAR(20)
DECLARE @IDPLANFCJ VARCHAR(6)
DECLARE @CNSFACJ VARCHAR(20)
DECLARE @CODCAJA VARCHAR(10)
DECLARE @PROCEDENCIA  VARCHAR(10)
DECLARE @AUTFACTURADA BIT
DECLARE @CCOSTO       VARCHAR(20)
DECLARE @IDAREA       VARCHAR(20)
DECLARE @DOC2         VARCHAR(20)
DECLARE @N_FACTURA_AUT VARCHAR(20)
DECLARE @VALORTOTAL DECIMAL(14,2)
DECLARE @CNSCXC_AUT VARCHAR(20)
DECLARE @OK_AUT     SMALLINT
DECLARE @COMPANIA   VARCHAR(2)='02'
DECLARE @CUENTA     VARCHAR(20)
DECLARE @SEDE       VARCHAR(6)
DECLARE @IDTERCERO  VARCHAR(20)                       
DECLARE @FECHA      DATETIME
DECLARE @USUARIO    VARCHAR(20)
DECLARE @VALORPAGO  DECIMAL(14,2)
DECLARE @SYS_COMPUTERNAME VARCHAR(20)
BEGIN
   
   SELECT  @PROCEDENCIA=CASE WHEN FTR.PROCEDENCIA='CE' THEN 'CE' WHEN FTR.PROCEDENCIA='SALUD' THEN 'SALUD' ELSE 'CITAS' END,@DOC2=NOREFERENCIA,
   @USUARIO=USUARIOFACTURA,@IDTERCERO=IDTERCERO,@COMPANIA='01',@SEDE=FTR.IDSEDE,
   @IDPLANFCJ=FTR.IDPLAN
   FROM FTR 
   WHERE N_FACTURA=@N_FACTURA
  
   PRINT '@PROCEDENCIA='+@PROCEDENCIA
   PRINT '@DOC2='+@DOC2

   IF @PROCEDENCIA = 'CE'  
   BEGIN
      SELECT @AUTFACTURADA = COALESCE(AUT.FACTURADA,0), @N_FACTURA_AUT =AUT.N_FACTURA,
               @CCOSTO       = AUT.CCOSTO, @IDAREA = AUT.IDAREA,@CODCAJA=AUT.CODCAJA,@CNSFACJ=NORECIBOCAJA
      FROM   AUTD INNER JOIN AUT ON AUTD.IDAUT=AUT.IDAUT
      WHERE AUT.NOAUT = @DOC2
      --AND  AUTD.IDPLAN=@IDPLANFCJ
	  --AND  @N_FACTURA=CASE WHEN COALESCE(AUTD.N_FACTURA,'')<>'' THEN AUTD.N_FACTURA ELSE AUT.N_FACTURA END
   END
   IF @PROCEDENCIA = 'CITAS'
   BEGIN                       
      SELECT @AUTFACTURADA = COALESCE(CIT.FACTURADA,0), @N_FACTURA_AUT = N_FACTURA,
               @CCOSTO       = CCOSTO, @IDAREA = IDAREA,
               @CODCAJA=CIT.CODCAJA,@CNSFACJ=NORECIBOCAJA
      FROM   CIT WHERE CONSECUTIVO = @DOC2
   END

 IF @PROCEDENCIA = 'SALUD'
               BEGIN
                  PRINT 'REVISAMOS SI ES ASISTENCIAL Y PARTICULAR PARA VER SI YA ESTA FACTURADA'
                 
                  DECLARE @IDPLANHADM     VARCHAR(6), @HADMFACTURADA INT, @OK_HADM INT, @N_FACTURA_HADM VARCHAR(16), @CNSCXC_HADM VARCHAR(16)
                  SELECT @IDPLANHADM = IDPLAN FROM HADMF WHERE NOADMISION = @DOC2 AND IDTERCERO=@IDTERCERO
                  PRINT 'ESTE ES EL PLAN:  '+@IDPLANHADM
                  IF @IDPLANHADM = DBO.FNK_VALORVARIABLE('IDPLANPART')  OR
                     @IDPLANHADM = DBO.FNK_VALORVARIABLE('IDPLANPART2') OR
                     @IDPLANHADM = DBO.FNK_VALORVARIABLE('IDPLANPART3') OR
                     @IDPLANHADM = DBO.FNK_VALORVARIABLE('IDPLANPART4') OR
                     @IDPLANHADM = DBO.FNK_VALORVARIABLE('IDPLANPART5') 
                  BEGIN
                     PRINT 'INGRESE'
                     SELECT @HADMFACTURADA = COUNT(*) FROM FTR WHERE NOREFERENCIA = @DOC2 AND ESTADO <> 'A' AND COALESCE(TIPOANULACION,'') <> 'NC'
                     IF @HADMFACTURADA > 0
                     BEGIN
                        SELECT @N_FACTURA_HADM = N_FACTURA FROM FTR WHERE NOREFERENCIA = @DOC2 AND ESTADO <> 'A' AND COALESCE(TIPOANULACION,'') <> 'NC'
						AND IDTERCERO=@IDTERCERO
                        PRINT 'FACTURADA'
                        SELECT @VALORTOTAL = VR_TOTAL FROM FTR WHERE N_FACTURA = @N_FACTURA_HADM
                        
                        SELECT @OK_HADM = COALESCE(COUNT(*),0) FROM FCXCD WHERE N_FACTURA = @N_FACTURA_HADM
                        --SET @FECHA=DBO.FNK_FECHA_SIN_MLS(GETDATE())
                        SET @CUENTA=(SELECT CUENTA FROM TTEC WHERE TIPO=DBO.FNK_VALORVARIABLE('IDTERCONTABLEPART'))
                        
						SELECT @CNSFACJ=FCJ.CNSFACJ,@CODCAJA=FCJ.CODCAJA
						FROM FCJ WHERE NOADMISION=@DOC2 --AND N_FACTURA=@N_FACTURA
						AND CERRADA=1 
						AND ESTADO='P'                                                                                                                                                                                                                                                                                                                                                                                                                   

						PRINT '@CODCAJA='+COALESCE(@CODCAJA,'')+'  @CNSFACJ='+COALESCE(@CNSFACJ,'NADA DE NADA')
						PRINT '@OK_HADM ='+STR(@OK_HADM)
                        IF @OK_HADM = 0
                        BEGIN                       
                           PRINT'/*NO TIENE CXC GENERADA Y LA GENERO AUTOMATICAMENTE/*'
                           SET @CNSCXC_HADM=SPACE(20)
                           EXEC SPK_GENCONSECUTIVO @COMPANIA,@SEDE,'@CXC',@CNSCXC_HADM OUTPUT
                           SELECT @CNSCXC_HADM = @SEDE + REPLACE(SPACE(8 - LEN(@CNSCXC_HADM))+LTRIM(RTRIM(@CNSCXC_HADM)),SPACE(1),0)
                           
                           EXEC SPK_ADMIN_CXC_CONTAB
                             @CNSCXC_HADM,
                             @IDTERCERO,
                             @N_FACTURA_HADM,
                             @FECHA,
                             @FECHA,
                             @USUARIO,
                             'CXC GENERADA EN CAJA',
                             @COMPANIA,
                             '',
                             @VALORTOTAL,     
                             @CCOSTO,
                             @IDAREA,  
                             'INSERT',
                             0,
                             @CUENTA                                        
                           SELECT @ITEM_FCXCDV = ITEM FROM FCXCDV WHERE N_FACTURA = @N_FACTURA_HADM AND TIPO = 'F'
                        END
                        ELSE
                        BEGIN
                           SELECT @CNSCXC_HADM  = CNSCXC FROM FCXCD WHERE N_FACTURA = @N_FACTURA_HADM
                           SELECT @ITEM_FCXCDV = ITEM FROM FCXCDV WHERE N_FACTURA = @N_FACTURA_HADM AND TIPO = 'F'
                        END                   
                        /*YA TIENE CXC GENERADA Y SE CRUZA AUTOMATICAMENTE EN PAGOS
                        YA SEA POR QUE SE HABIA FACTURADO O PQ ACABAMOS DE HACERLO AQUI*/
                        SET @CNSFPAG=SPACE(20)
                    /*SE ESTABAN GENERANDO LOS CONSECUTIVOS DE LAS CUENTAS POR COBRAR Y NO AHUMENTABA EL DE PAGOS @FPAG*/
                      --EXEC SPK_GENCONSECUTIVO @COMPANIA,@SEDE,'@CXC',@CNSFPAG OUTPUT
                        EXEC SPK_GENCONSECUTIVO @COMPANIA,@SEDE,'@FPAG',@CNSFPAG OUTPUT
                        SELECT @CNSFPAG = @SEDE + REPLACE(SPACE(8 - LEN(@CNSFPAG))+LTRIM(RTRIM(@CNSFPAG)),SPACE(1),0)
                           
                        EXEC SPK_ADMIN_PAGOS 
                              'CXC', 
                              @N_FACTURA_HADM, 
                              @CNSCXC_HADM,
                              @CNSFPAG,
                              'INSERT',
                              @VALORTOTAL,
                              @IDTERCERO,
                              @USUARIO,     
                              @SYS_COMPUTERNAME,
                              @COMPANIA,
                              @SEDE,
                              'PAGO REALIZADO EN CAJA',
                              'CAJA',
                              'P',
                              NULL, 
                              @FECHA,
                              @CODCAJA,
                              @CNSFACJ,
                              @CUENTA,
                              'F',
                              NULL
                        INSERT INTO FCJPCXC (CNSFACJ, CODCAJA, CNSCXC, N_FACTURA, ITEM_FCXCDV, IDTERCERO, VALOR, 
                                             VLR_IMPUESTOS, ESTADO, CNSFPAG, TIPOCXC)
                        SELECT @CNSFACJ, @CODCAJA, @CNSCXC_HADM, @N_FACTURA_HADM, @ITEM_FCXCDV, @IDTERCERO, @VALORTOTAL,
                                0, 'P', @CNSFPAG, 0
                     END
                       
                  END
               END
        ELSE
         BEGIN


      SELECT @IDPLANFCJ = IDPLAN FROM FCJ WHERE CNSFACJ = @CNSFACJ AND CODCAJA = @CODCAJA

      PRINT '@N_FACTURA_AUT='+@N_FACTURA_AUT
      PRINT '@AUTFACTURADA='+STR(@AUTFACTURADA)
      IF @AUTFACTURADA = 1
      BEGIN
         PRINT 'FACTURADA'
         SELECT @VALORTOTAL = VR_TOTAL FROM FTR WHERE N_FACTURA = @N_FACTURA_AUT
                     
         SELECT @OK_AUT = COALESCE(COUNT(*),0) FROM FCXCD WHERE N_FACTURA = @N_FACTURA_AUT
         --  SET @FECHA=DBO.FNK_FECHA_SIN_MLS(GETDATE())
         SET @CUENTA=(SELECT CUENTA FROM TTEC WHERE TIPO=DBO.FNK_VALORVARIABLE('IDTERCONTABLEPART'))
                     
         IF @OK_AUT = 0
         BEGIN
            PRINT '/*NO TIENE CXC GENERADA Y LA GENERO AUTOMATICAMENTE*/'
            SET @CNSCXC_AUT=SPACE(20)
            EXEC SPK_GENCONSECUTIVO @COMPANIA,@SEDE,'@CXC',@CNSCXC_AUT OUTPUT
            SELECT @CNSCXC_AUT = @SEDE + REPLACE(SPACE(8 - LEN(@CNSCXC_AUT))+LTRIM(RTRIM(@CNSCXC_AUT)),SPACE(1),0)
                        
            EXEC SPK_ADMIN_CXC_CONTAB
                  @CNSCXC_AUT,
                  @IDTERCERO,
                  @N_FACTURA_AUT,
                  @FECHA,
                  @FECHA,
                  @USUARIO,
                  'CXC GENERADA EN CAJA',
                  @COMPANIA,
                  '',
                  @VALORTOTAL,     
                  @CCOSTO,
                  @IDAREA,  
                  'INSERT',
                  0,
                  @CUENTA    
                                                                 
               SELECT @ITEM_FCXCDV = ITEM FROM FCXCDV WHERE N_FACTURA = @N_FACTURA_AUT AND TIPO = 'F'
         END
         ELSE
         BEGIN
            SELECT @CNSCXC_AUT  = CNSCXC FROM FCXCD WHERE N_FACTURA = @N_FACTURA_AUT
            SELECT @ITEM_FCXCDV = ITEM FROM FCXCDV WHERE N_FACTURA = @N_FACTURA_AUT AND TIPO = 'F'
         END
         /*YA TIENE CXC GENERADA Y SE CRUZA AUTOMATICAMENTE EN PAGOS
            YA SEA POR QUE SE HABIA FACTURADO O PQ ACABAMOS DE HACERLO AQUI*/
         SET @CNSFPAG=SPACE(20)
         /*SE ESTABAN GENERANDO LOS CONSECUTIVOS DE LAS CUENTAS POR COBRAR Y NO AUMENTABA EL DE PAGOS @FPAG*/
         --EXEC SPK_GENCONSECUTIVO @COMPANIA,@SEDE,'@CXC',@CNSFPAG OUTPUT
         EXEC SPK_GENCONSECUTIVO @COMPANIA,@SEDE,'@FPAG',@CNSFPAG OUTPUT
         SELECT @CNSFPAG = @SEDE + REPLACE(SPACE(8 - LEN(@CNSFPAG))+LTRIM(RTRIM(@CNSFPAG)),SPACE(1),0)
                     
         SELECT @VALORPAGO=VALORTOTAL  FROM FCJ WHERE CODCAJA=@CODCAJA AND CNSFACJ=@CNSFACJ
                       
         EXEC SPK_ADMIN_PAGOS 
               'CXC', 
               @N_FACTURA_AUT, 
               @CNSCXC_AUT,
               @CNSFPAG,
               'INSERT',
               @VALORPAGO,
               @IDTERCERO,
               @USUARIO,     
               @SYS_COMPUTERNAME,
               @COMPANIA,
               @SEDE,
               'PAGO REALIZADO EN CAJA',
               'CAJA',
               'P',
               NULL, 
               @FECHA,
               @CODCAJA,
               @CNSFACJ,
               @CUENTA,
               'F',
               NULL
         INSERT INTO FCJPCXC (CNSFACJ, CODCAJA, CNSCXC, N_FACTURA, ITEM_FCXCDV, IDTERCERO, VALOR, 
                              VLR_IMPUESTOS, ESTADO, CNSFPAG, TIPOCXC)
         SELECT @CNSFACJ, @CODCAJA, @CNSCXC_AUT, @N_FACTURA_AUT, @ITEM_FCXCDV, @IDTERCERO, @VALORTOTAL,
                  0, 'P', @CNSFPAG, 0
      END
   END

END