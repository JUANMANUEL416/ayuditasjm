USE KUNIPSSAM
DECLARE
@CODCAJA          VARCHAR(4)='002',
@CNSFACJ          VARCHAR(20)='00000261',
@COMPANIA         VARCHAR(2)='01',
@SEDE             VARCHAR(5)='02', 
@USUARIO          VARCHAR(12)='SOPORTE',
@SYS_COMPUTERNAME VARCHAR(254)='SOPORTE'
  
DECLARE @OK               INT
DECLARE @CLASER           VARCHAR(1)
DECLARE @TIPOPAGO         VARCHAR(3)
DECLARE @VALOR            DECIMAL(14,2)
DECLARE @TIPO             VARCHAR(7)
DECLARE @PROCEDENCIA      VARCHAR(10)
DECLARE @DATO             VARCHAR(80)
DECLARE @DATO1            VARCHAR(80)
DECLARE @ESTADO           VARCHAR(1) 
DECLARE @IDAFILIADO       VARCHAR(20)
DECLARE @NVOVONSEC        VARCHAR(20)
DECLARE @NVOCONSEC1       VARCHAR(20)
DECLARE @NVOCONSEC2       VARCHAR(20)
DECLARE @CNSACJ           VARCHAR(20)
DECLARE @CNSPCJ           VARCHAR(20)
DECLARE @ABIERTA          SMALLINT
DECLARE @VALORTOTAL       DECIMAL(14,2)
DECLARE @DOC1             VARCHAR(16)
DECLARE @DOC2             VARCHAR(16) 
DECLARE @CLASE_FAC        VARCHAR(5)
DECLARE @IDTERCERO        VARCHAR(20)
DECLARE @TIPOEGRESO       VARCHAR(8)
DECLARE @DATO2            VARCHAR(80)
DECLARE @DATO3            VARCHAR(80)
DECLARE @DATO4            VARCHAR(80)
DECLARE @DATO5            VARCHAR(80)
DECLARE @DATO6            VARCHAR(80)
DECLARE @DATO7            VARCHAR(80)
DECLARE @CPRECTRAS        VARCHAR(80)
DECLARE @DATOCHQ          VARCHAR(80)
DECLARE @DATOEFE          VARCHAR(80)
DECLARE @DATOAPE          VARCHAR(80)
DECLARE @DATON            VARCHAR(80)
DECLARE @DATOCATCAJA      VARCHAR(80)
DECLARE @BANCO            VARCHAR(3)
DECLARE @SUCURSAL         VARCHAR(2)
DECLARE @CTA_BCO          VARCHAR(40)
DECLARE @CSGBANCO         VARCHAR(3)
DECLARE @CSGSUCURSAL      VARCHAR(2)
DECLARE @CSGCTA_BCO       VARCHAR(40)
DECLARE @CNSDOC           VARCHAR(20)
DECLARE @NUMERODOCUMENTO  VARCHAR(20)   
DECLARE @NODOCUMENTO      VARCHAR(20)   
DECLARE @N_RECIBO         VARCHAR(20)
DECLARE @CODCAJADEP       VARCHAR(5)
DECLARE @CNSFACJDEP       VARCHAR(20)
DECLARE @DEAPERTURA       SMALLINT
DECLARE @ITEMBMOV         INT 
DECLARE @IDOPERACION      VARCHAR(20)
DECLARE @RENGLON          SMALLINT
DECLARE @CCOSTO           VARCHAR(20)
DECLARE @IDAREA           VARCHAR(20)
DECLARE @CUENTA           VARCHAR(16)
DECLARE @FECHA            DATETIME
DECLARE @CNSFCXP          VARCHAR(20)
DECLARE @CNSCXC           VARCHAR(20)
DECLARE @CONCEPTO         VARCHAR(10)
DECLARE @IDTERCERO_CXP    VARCHAR(20)
DECLARE @VALOR_CXP        DECIMAL (14,2)
DECLARE @F_VENCE          DATETIME
DECLARE @NOMBRECLIENTE    VARCHAR(40)
DECLARE @OBSERVACION      VARCHAR(255) 
DECLARE @DOCORIGEN        INT 
DECLARE @NVOCONSEC        VARCHAR(20)
DECLARE @ITEM             INT
DECLARE @CODIGOCPCJ       VARCHAR(20)
DECLARE @DATOCEHOSP       VARCHAR(80)
DECLARE @DEVDOC           VARCHAR(20)
DECLARE @NROCOMPROBANTE   VARCHAR(20)
DECLARE @RECBCO           INT
DECLARE @BANCO2           VARCHAR(3)
DECLARE @SUCURSAL2        VARCHAR(2)
DECLARE @CTA_BCO2         VARCHAR(20)
DECLARE @DEVREC           VARCHAR(20)
DECLARE @CODCAJA_DEV      VARCHAR(4)
DECLARE @CNSFACJ_DEV      VARCHAR(20)
DECLARE @PROC_DEV         VARCHAR(10)
DECLARE @NOADMISION_DEV   VARCHAR(20)
DECLARE @NOPRESTACION_DEV VARCHAR(20)
DECLARE @CONSECUTIVOCAN   VARCHAR (20)
DECLARE @VALORTOTAL1      DECIMAL(14,2)
DECLARE @VALORTOTAL2      DECIMAL(14,2)
DECLARE @IDTERCERO1       VARCHAR(20)
DECLARE @NOINGRESODEPORI  VARCHAR(16)
DECLARE @VALORDEPORI      DECIMAL(14,2)
DECLARE @TRASACAJA        VARCHAR(80) 
DECLARE @VALORREINTEGRO   DECIMAL(14,2)
DECLARE @G_REINT          SMALLINT
DECLARE @NVOCONSECTFCJ    VARCHAR(20)
DECLARE @CNSPCJAUX        VARCHAR(20)  
DECLARE @TOTREINTEGRO     DECIMAL(14,2)
DECLARE @CNSCXP           VARCHAR(20) --PPTO
DECLARE @CNSPPTO          VARCHAR(20) --PPTO
DECLARE @CNSCDP           VARCHAR(20) --PPTO
DECLARE @CNSRP            VARCHAR(20) --PPTO
DECLARE @CNSPAGO          VARCHAR(20) --PPTO
DECLARE @FPAGO            DATETIME    --PPTO
DECLARE @PBANCO           VARCHAR(20) --PPTO
DECLARE @PCUENTA          VARCHAR(20) --PPTO
DECLARE @PSUCURSAL        VARCHAR(20) --PPTO
DECLARE @PFORMA           VARCHAR(20) --PPTO
DECLARE @PCCOSTO          VARCHAR(20) --PPTO
DECLARE @DESFORMA         VARCHAR(50) --PPTO
DECLARE @PDOCUMENTO       VARCHAR(20) --PPTO
DECLARE @ESPART           BIT          --PPTO
DECLARE @PABONO           DECIMAL(14,2) --PPTO
DECLARE @OBSERVACIONPPTO  VARCHAR(500)  --PPTO
DECLARE @F_PAGOPPTO        DATETIME  --PPTO
DECLARE @CONSECUTIVO      VARCHAR(20)
DECLARE @RUBRO            VARCHAR(20)
DECLARE @RECO             VARCHAR(20)
DECLARE @CCOSTOPRESUP     VARCHAR(20)
DECLARE @RECA             VARCHAR(20)
DECLARE @SI               SMALLINT
DECLARE @VLR_CXPPANT      DECIMAL(14,2)
DECLARE @DATOPAGARE       VARCHAR (80)
DECLARE @CNSFCXPCJM VARCHAR(20)   --REEMBOLSO CAJA MENOR
DECLARE @RESPONCJM  VARCHAR(20)   --REEMBOLSO CAJA MENOR
DECLARE @CAJAMENOR  VARCHAR(4)    --REEMBOLSO CAJA MENOR
DECLARE @VLRPAGOCJM DECIMAL(14,2) --REEMBOLSO CAJA MENOR
DECLARE @CNSFCXPPM  VARCHAR(20)   --REEMBOLSO CAJA MENOR
DECLARE @AUX INT
DECLARE @PCJTERCERO  VARCHAR(20) --PGA.CXC=1
DECLARE @PCJTIPOPAGO VARCHAR(10) --PGA.CXC=1
DECLARE @VALORTPAGO  DECIMAL(14,2) --PGA.CXC=1
DECLARE @CNSDOCPCJ   VARCHAR(20) --PGA.CXC=1
DECLARE @FACTURADOC  VARCHAR(20) --PGA.CXC=1
DECLARE @CNSPCJPAGO  VARCHAR(20) --PGA.CXC=1
DECLARE @CUENTAPCJ   VARCHAR(20) --PGA.CXC=1
DECLARE @VALORPAGO   DECIMAL(14,2)-- ABONO A FACTURAS
DECLARE @IDCATEGORIA VARCHAR(10)
DECLARE @IDPLANFCJ   VARCHAR(6)
BEGIN
   --    SELECT @OK = COUNT(*) FROM FCJ WHERE CNSFACJ = @CNSFACJ AND CODCAJA = @CODCAJA AND IMPRESO = 0  
   --    IF @OK IS NULL
   --       SELECT @OK = 0
   --    IF @OK > 0 
   --       RETURN
   SET @OK = 0
   SELECT @ESPART=0
   PRINT 'INGRESO AL SPK'
   SELECT @DATOCEHOSP = DATO FROM USVGS WHERE IDVARIABLE = 'CETIPOAUTORIZACION'
   
   SELECT @ESTADO         = ESTADO,         @IDAFILIADO  = IDAFILIADO,   @VALORTOTAL    = VALORTOTAL, @VALORTOTAL2    = VALORTOTAL,
          @DOC1           = NOADMISION,     @DOC2        = NOPRESTACION, @CLASE_FAC     = CLASE_FAC,
          @IDTERCERO      = IDTERCERO,      @TIPOEGRESO  = TIPOEGRESO,   @N_RECIBO      = N_RECIBO,
          @DEAPERTURA     = COALESCE(DEAPERTURA,0),      @CSGBANCO    = BANCO,        @CSGSUCURSAL   = SUCURSAL,
          @CSGCTA_BCO     = CTA_BCO,        @FECHA       = FECHA,        @NOMBRECLIENTE = NOMBRECLIENTE,
          @NROCOMPROBANTE = NROCOMPROBANTE, @OBSERVACION = OBSERVACION,  @CLASER        = CLASER, 
          @TIPO           = TIPO,           @PROCEDENCIA = PROCEDENCIA,  @IDPLANFCJ     = IDPLAN
   FROM   FCJ 
   WHERE  CNSFACJ = @CNSFACJ AND CODCAJA = @CODCAJA

 
   SELECT @IDCATEGORIA=IDCATEGORIA FROM CJTE WHERE TIPOEGRESO=@TIPOEGRESO

   SELECT @AUX = COALESCE(PRI.CERRADO,0) FROM PRI WHERE ANO = DATEPART(YEAR,@FECHA) AND MES = DATEPART(MONTH,@FECHA)
   IF @AUX = 1
   BEGIN
      RAISERROR('PERIODO CERRADO ',16,1)
      RETURN
   END 
   IF NOT EXISTS(SELECT * FROM PCJ WHERE CODCAJA=@CODCAJA AND CNSFACJ=@CNSFACJ)
   BEGIN
      RAISERROR('NO EXISTEN FORMAS DE PAGO ',16,1)
      RETURN      
   END
   SELECT @DATOCHQ = DATO FROM USVGS WHERE IDVARIABLE = 'IDCJFPACHEQUE'
   SELECT @DATOEFE = DATO FROM USVGS WHERE IDVARIABLE = 'IDCJFPAEFECTIVO'
   SELECT @DATOAPE = DATO FROM USVGS WHERE IDVARIABLE = 'IDCJAPERTURACAJA'
   ---JGOMEZ---07.09.2015
   SELECT @DATOPAGARE= DATO FROM USVGS WHERE IDVARIABLE='IDCPCJPAGARE'
   
   IF @ESTADO IS NULL
   BEGIN
      SELECT @ESTADO = 'P'
   END
   
   IF @DEAPERTURA IS NULL
   BEGIN
      SELECT @DEAPERTURA = 0
   END
   
   CREATE TABLE #TPCJ (TIPOPAGO        VARCHAR(3)  COLLATE database_default,  
                       VALOR           DECIMAL(14,2),
                       BANCO           VARCHAR(3)  COLLATE database_default,  
                       SUCURSAL        VARCHAR(2)  COLLATE database_default,
                       CTA_BCO         VARCHAR(40) COLLATE database_default, 
                       CNSDOC          VARCHAR(20) COLLATE database_default,
                       NUMERODOCUMENTO VARCHAR(20) COLLATE database_default, 
                       CODCAJADEP      VARCHAR(5)  COLLATE database_default,
                       CNSFACJDEP      VARCHAR(20) COLLATE database_default) 
   
   IF @CLASE_FAC = 'COBRO'
   BEGIN   

      IF EXISTS(SELECT  * FROM    PCJ LEFT JOIN FPA ON PCJ.TIPOPAGO = FPA.FORMAPAGO
            WHERE PCJ.CODCAJA=@CODCAJA
            AND PCJ.CNSFACJ=@CNSFACJ
            AND ( COALESCE(FPA.REQBCO,0)=1 
            AND COALESCE(FPA.DATAFONO,0)=1) )
      BEGIN
         PRINT 'PAGO CON DATAFONO '

         DECLARE PCJ_CURSOR CURSOR FOR  
         SELECT  PCJ.TIPOPAGO, PCJ.VALOR, PCJ.BANCO, PCJ.SUCURSAL, PCJ.CTA_BCO, 
                  PCJ.CNSDOC, PCJ.NUMERODOCUMENTO, COALESCE(FPA.REQBCO,0) 
         FROM    PCJ LEFT JOIN FPA ON PCJ.TIPOPAGO = FPA.FORMAPAGO
         WHERE PCJ.CODCAJA=@CODCAJA
         AND PCJ.CNSFACJ=@CNSFACJ
         AND (COALESCE(FPA.REQBCO,0)=1  
         AND COALESCE(FPA.DATAFONO,0)=1)
         OPEN    PCJ_CURSOR  
         FETCH NEXT FROM PCJ_CURSOR  
         INTO    @TIPOPAGO, @VALOR, @BANCO, @SUCURSAL, @CTA_BCO, @CNSDOC, @NUMERODOCUMENTO, @RECBCO
         WHILE @@FETCH_STATUS = 0  
         BEGIN  
            IF @TIPOPAGO = @DATOEFE
            BEGIN
               BEGIN TRAN
               UPDATE CAJR SET VALOR = VALOR - @VALOR 
               WHERE FORMAPAGO = @TIPOPAGO AND CODCAJA = @CODCAJA          
               COMMIT
            END
            ELSE
            BEGIN
               SELECT @IDOPERACION = DATO FROM USVGS WHERE IDVARIABLE = 'IDBCOPAGOCHEQUE'
               IF @TIPOPAGO=@IDOPERACION
               BEGIN
                  UPDATE BCTDD SET IDTERCERO = @IDTERCERO, N_RECIBO = @N_RECIBO,
                                    UTILIZADO = 1, ESTADO = 'I', USUARIO = @USUARIO,
                                    FECHA = GETDATE(), VALOR = @VALOR,
                                    CNSFACJ=@CNSFACJ, CODCAJA=@CODCAJA 
                  WHERE  BANCO  = @BANCO  AND SUCURSAL    = @SUCURSAL AND CTA_BCO = @CTA_BCO 
                  AND    CNSDOC = @CNSDOC AND NODOCUMENTO = dbo.FNK_LIMPIATEXTO(@NUMERODOCUMENTO, '0-9')
               END
               /* AQUI SE CREA LA OPERACION FINANCIERA EN BANCOS*/
               IF @RECBCO = 1
               BEGIN
                  DECLARE @OBS VARCHAR(1024)
                  SELECT @OBS=OBSERVACION  FROM FCJ WHERE CODCAJA=@CODCAJA AND CNSFACJ=@CNSFACJ
                  
                  SELECT @ITEMBMOV = COALESCE(MAX(ITEM),0)+1 FROM BMOV 
                  WHERE  CTA_BCO = @CTA_BCO AND SUCURSAL=@SUCURSAL 
                  AND    BANCO   = @BANCO 
                  IF  @ITEMBMOV IS NULL
                  SELECT @ITEMBMOV = 1
                  INSERT INTO BMOV(BANCO, SUCURSAL, CTA_BCO, ITEM, FECHAOPERACION,
                                    NODOCUMENTO, NOTRANSFOPER, IDOPERACION, VLROPERACION,
                                    DESCRIPCION, USUARIO, SYS_ComputerName, SALDOANTES,
                                    SALDODESP, TIPOCOBROFIN, PROCEDENCIA, ESTADO, CONTABILIZADA, NROCOMPROBANTE,
                                    CODCAJA, CNSFACJ) 
                  SELECT @BANCO, @SUCURSAL, @CTA_BCO, @ITEMBMOV, @FECHA,
                        @CNSFACJ, NULL, DBO.FNK_VALORVARIABLE('IDOFINCAJADB'), 0, @OBS,
                        @USUARIO, @SYS_COMPUTERNAME, 0, 0, NULL, 'CAJA', 'C', 1, @NROCOMPROBANTE,
                        @CODCAJA, @CNSFACJ
                    
                  INSERT INTO BMOVD(BANCO, SUCURSAL, CTA_BCO, ITEM, RENGLON, FORMAPAGO,
                                    BANCODOC, NODOCUMENTO, VLRITEM, PROCEDENCIA, CODCAJA,
                                    CNSFACJ, IDTERCERO) 
                  SELECT @BANCO, @SUCURSAL, @CTA_BCO, @ITEMBMOV, 1, 
                        @TIPOPAGO, @BANCO, @NODOCUMENTO,  @VALOR, 'CAJA', @CODCAJA, @CNSFACJ, @IDTERCERO
                    
                  EXEC SPK_TOT_BMOV @BANCO, @SUCURSAL, @CTA_BCO, @ITEMBMOV 
                  --EXEC SPK_OK_BMOV @CSGBANCO, @CSGSUCURSAL, @CSGCTA_BCO, @ITEMBMOV,@USUARIO,@SYS_COMPUTERNAME,@COMPANIA,@SEDE,@NROCOMPROBANTE
                  EXEC SPK_OK_BMOV @BANCO, @SUCURSAL, @CTA_BCO, @ITEMBMOV,@USUARIO,@SYS_COMPUTERNAME,@COMPANIA,@SEDE,@NROCOMPROBANTE
               END                
                  
            END
            FETCH NEXT FROM PCJ_CURSOR  
            INTO @TIPOPAGO, @VALOR, @BANCO, @SUCURSAL, @CTA_BCO, @CNSDOC, @NUMERODOCUMENTO, @RECBCO
         END            
         CLOSE PCJ_CURSOR  
         DEALLOCATE PCJ_CURSOR 
      END
   END
END