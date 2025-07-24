CREATE OR ALTER PROCEDURE DBO.SPK_GENERA_ORDENPAGO_IZIPAY
@NOADMISION VARCHAR(20),
@TABLA      VARCHAR(20),
@PROCEDENCIA VARCHAR(20),
@IDAFILIADO  VARCHAR(20),
@VALOR       DECIMAL(14,2),
@N_FACTURA   VARCHAR(20),
@USUARIO     VARCHAR(20),
@IDKPAGE     INT = 0,
@PROCESO     VARCHAR(20)
WITH ENCRYPTION
AS 
DECLARE @FECHA		DATETIME
DECLARE @DATE		VARCHAR(20)
DECLARE @MES		VARCHAR(2)
DECLARE @ANIO		VARCHAR(4)
DECLARE @DIA		VARCHAR(2)
DECLARE @HORA		VARCHAR(8)
DECLARE @BODY		VARCHAR(1000)
DECLARE @sUrl		VARCHAR(3096)
DECLARE @obj		INT
DECLARE @response	VARCHAR(max)
DECLARE @urlpago	VARCHAR(255)
DECLARE @CNSFCJ		VARCHAR(20)
DECLARE @answer		NVARCHAR(max)
DECLARE @RESPUESTA	VARCHAR(20)
DECLARE @paymentOrderId		 VARCHAR(40)
DECLARE @paymentOrderStatus	 VARCHAR(40)
DECLARE @MENSAJE	VARCHAR(200)
DECLARE @BASIC   VARCHAR(500) 
DECLARE @EMAIL   VARCHAR(500)
DECLARE @CELULAR VARCHAR(20)
DECLARE @NOMBREAFI VARCHAR(150)
DECLARE @HOY DATETIME
DECLARE @MODO VARCHAR(20)
BEGIN
   PRINT 'SPK_GENERA_ORDENPAGO_IZIPAY'
   IF EXISTS(SELECT * FROM KPAGE WHERE CONSECUTIVO=@NOADMISION AND PROCEDENCIA=@PROCEDENCIA AND TABLA=@TABLA AND COALESCE(ESTADO,'') IN('RUNNING','SEND') AND F_EXPIRA<=GETDATE())
   BEGIN
      PRINT 'EXISTE'
      UPDATE KPAGE SET ESTADO='EXPIRED' WHERE CONSECUTIVO=@NOADMISION AND PROCEDENCIA=@PROCEDENCIA AND TABLA=@TABLA AND COALESCE(ESTADO,'') IN('RUNNING','SEND') AND F_EXPIRA<=GETDATE()
      IF @PROCESO<>'CREAR'
      BEGIN
         RETURN
      END
   END
   IF EXISTS(SELECT * FROM KPAGE WHERE CONSECUTIVO=@NOADMISION AND PROCEDENCIA=@PROCEDENCIA AND TABLA=@TABLA AND COALESCE(ESTADO,'') IN('RUNNING','SEND') AND F_EXPIRA>GETDATE() AND @PROCESO='CREAR')
   BEGIN
      PRINT 'Link de pago Activo, me regreso'
      RETURN
   END
   SELECT @sUrl= DBO.FNK_VALORVARIABLE('URL_PASARELA_IZIPAY')
   IF DB_NAME()=DBO.FNK_VALORVARIABLE('BDATA_PRODUCCION')
   BEGIN
      SELECT @BASIC=DBO.FNK_VALORVARIABLE('IZIPAY_SERVICEMODE')
      SELECT @MODO='PRODUCTION'
   END
   ELSE
   BEGIN
      SELECT @BASIC=LTRIM(RTRIM(DBO.FNK_VALORVARIABLE('IZIPAYSERVCEMODETEST')))
      SELECT @MODO='PRUEBAS'
   END
   IF @PROCESO='CREAR'
   BEGIN
      PRINT 'VOY A CREAR'
      IF @IDKPAGE>0
      BEGIN
         IF EXISTS(SELECT * FROM KPAGE WHERE IDKPAGE=@IDKPAGE AND ESTADO='PAID')
         BEGIN
            PRINT 'Orden ya fue Pagada por el Usuario'
            RETURN
         END
         IF EXISTS(SELECT * FROM KPAGE WHERE IDKPAGE=@IDKPAGE AND ESTADO IN('UNPAID','RUNNING'))
         BEGIN
            PRINT 'Orden activa  a la espera del pago'
            RETURN
         END
         PRINT 'Orden cancelada o expirada debo Crear una nueva'
      END
      SELECT @sUrl=LTRIM(RTRIM(@sUrl))+'CreatePaymentOrder'

      IF @TABLA='CIT'
      BEGIN
          SELECT @FECHA=DATEADD(MINUTE,290,FECHA) FROM CIT  WHERE CONSECUTIVO=@NOADMISION
      END
      IF @TABLA='AUT'
      BEGIN
        SELECT @FECHA=DATEADD(HOUR,29,GETDATE()) FROM AUT  WHERE IDAUT=@NOADMISION
      END

	   SELECT @HOY =   @FECHA
      SELECT @DIA =   convert(varchar, @HOY, 3),@MES =   convert(varchar, @HOY, 1), @ANIO =  convert(varchar, @HOY, 23), @HORA =  convert(varchar, @HOY, 8)
	   SELECT @DATE = @ANIO+'-'+@MES+'-'+@DIA+'T'+@HORA

      PRINT '@DATE '+COALESCE(@DATE,'NO TENGO FECHA')
  

      INSERT INTO KPAGE(CONSECUTIVO, TABLA, PROCEDENCIA, FECHAGEN,MODO, VALOR, ESTADO,USUCOBRA, IDPLAN,REF_PAGO,RESPONSABLEPAGO,F_EXPIRA)
   	SELECT @NOADMISION,@TABLA,@PROCEDENCIA, CONVERT(SMALLDATETIME,GETDATE()),@MODO, @VALOR, 'CREATED',@USUARIO,NULL,@N_FACTURA,@IDAFILIADO,DATEADD(MINUTE,-300,@HOY)
	
		SET @IDKPAGE = @@IDENTITY
      IF @TABLA='CIT'
      BEGIN
         UPDATE CIT SET IDKPAGE=@IDKPAGE WHERE CONSECUTIVO=@NOADMISION
      END
      IF @TABLA='AUT'
      BEGIN
         UPDATE AUT SET IDKPAGE=@IDKPAGE WHERE IDAUT=@NOADMISION
      END

      SELECT @EMAIL = LTRIM(RTRIM(REPLACE(REPLACE(EMAIL,CHAR(13),''),CHAR(10),''))), 
      @CELULAR = CELULAR, @NOMBREAFI =LTRIM(TRIM(NOMBREAFI)) 
      FROM AFI WHERE IDAFILIADO = @IDAFILIADO

      SELECT @BODY='{ '
      SELECT @BODY=@BODY+'"amount":'+REPLACE(REPLACE(CONVERT(varchar(50), CAST(@VALOR AS money), 1),'.',''),',','')+','
      SELECT @BODY=@BODY+' "currency": "PEN",'
      SELECT @BODY=@BODY+' "customer": { '
      SELECT @BODY=@BODY+' "reference": "Servicios de Salud", '
      SELECT @BODY=@BODY+' "email": "'+@EMAIL+'"'
      SELECT @BODY=@BODY+'},'
      SELECT @BODY=@BODY+' "dataCollectionForm": false,'
      SELECT @BODY=@BODY+' "expirationDate": "'+@DATE+'+00:00",'
      SELECT @BODY=@BODY+'"orderId": "'+CAST(@IDKPAGE AS VARCHAR(10))+'",'
      SELECT @BODY=@BODY+'"subMerchantDetails": { '
      SELECT @BODY=@BODY+'"name": "'+@NOMBREAFI+'" '
      SELECT @BODY=@BODY+' }, "locale":"es_CO" '
      SELECT @BODY=@BODY+'}'

   END
   ELSE
   BEGIN
      IF @PROCESO='VALIDAR'
      BEGIN
         SELECT @sUrl=LTRIM(RTRIM(@sUrl))+'PaymentOrder/Get'
         IF COALESCE(@IDKPAGE,0)=0
         BEGIN
            SELECT @IDKPAGE=IDKPAGE FROM KPAGE 
            WHERE CONSECUTIVO=@NOADMISION 
            AND PROCEDENCIA=@PROCEDENCIA 
            AND TABLA=@TABLA 
            AND COALESCE(ESTADO,'') IN('RUNNING','SEND','ERROR') 
            AND F_EXPIRA>GETDATE()
         END
         SELECT @paymentOrderId=paymentOrderId FROM KPAGE WHERE IDKPAGE=@IDKPAGE
         SELECT @Body =' {"paymentOrderId": "'+@paymentOrderId+'"} ' 
      END
      IF @PROCESO='ANULAR'
      BEGIN
         SELECT @sUrl=LTRIM(RTRIM(@sUrl))+'PaymentOrder/Cancel'
         IF COALESCE(@IDKPAGE,0)=0
         BEGIN
            SELECT @IDKPAGE=IDKPAGE FROM KPAGE 
            WHERE CONSECUTIVO=@NOADMISION 
            AND PROCEDENCIA=@PROCEDENCIA 
            AND TABLA=@TABLA 
            AND COALESCE(ESTADO,'') IN('RUNNING','SEND','') 
            AND F_EXPIRA>GETDATE()
         END
         SELECT @paymentOrderId=paymentOrderId FROM KPAGE WHERE IDKPAGE=@IDKPAGE
         SELECT @Body =' {"paymentOrderId": "'+@paymentOrderId+'"} ' 
      END
   END
   IF COALESCE(@IDKPAGE,0)=0
   BEGIN
      RETURN
   END
   PRINT '@BODY '+ @BODY
   UPDATE KPAGE SET BODY = @BODY WHERE IDKPAGE = @IDKPAGE	

	EXEC sys.sp_OACreate 'MSXML2.ServerXMLHttp', @obj OUT
	EXEC sys.sp_OAMethod @obj, 'Open', NULL, 'POST', @sUrl, false
	EXEC sys.sp_OAMethod @Obj, 'setRequestHeader', null, 'Authorization', @basic 
	EXEC sys.sp_OAMethod @Obj, 'setRequestHeader', null, 'Content-Type', 'application/json'
	EXEC sys.sp_OAMethod @Obj, 'setRequestHeader', null, 'Accept', 'application/json'
	EXEC SYS.sp_OAMethod @obj, 'send', null, @Body
	EXEC sys.sp_OAMethod @obj, 'responseText', @response OUTPUT
	IF @response IS NULL
	BEGIN
		DECLARE @TABLA_TMP AS TABLE (ITEM INT IDENTITY(1,1), RESPONSE VARCHAR(MAX))
		INSERT INTO @TABLA_TMP(RESPONSE)
		EXEC sys.sp_OAGetProperty @obj, 'responseText'
		SELECT @response=RESPONSE FROM @TABLA_TMP
	END
   PRINT @response
	EXEC sys.sp_OADestroy @obj

	select @RESPUESTA = [status] from openjson (@response) with (status varchar(20) '$.status')

   IF @RESPUESTA='SUCCESS'
   BEGIN
      --select @response
	   SELECT @answer = answer FROM OPENJSON(@response) with( answer NVARCHAR(MAX) AS JSON )
	   SELECT @urlpago = paymentURL, @paymentOrderId = paymentOrderId,@paymentOrderStatus=paymentOrderStatus
      FROM OPENJSON( @answer ) 
      with ( paymentURL VARCHAR(100) '$.paymentURL',
      paymentOrderId  varchar(40) '$.paymentOrderId',
      paymentOrderStatus  VARCHAR(40)   '$.paymentOrderStatus'
      )
      IF @PROCESO='CREAR'
      BEGIN
		   UPDATE KPAGE SET ESTADO=@paymentOrderStatus,RESPUESTA = @response, paymentOrderId = @paymentOrderId,LINKPAGO=@urlpago WHERE IDKPAGE = @IDKPAGE	
      END
      ELSE 
      BEGIN
         IF @PROCESO='ANULAR'
         BEGIN
            IF @TABLA='CIT'
            BEGIN
               UPDATE CIT SET IDKPAGE=NULL WHERE CONSECUTIVO=@NOADMISION
            END
            IF @TABLA='AUT'
            BEGIN
               UPDATE AUT SET IDKPAGE=NULL WHERE IDAUT=@NOADMISION
            END
         END
         ELSE
         BEGIN
            UPDATE KPAGE SET ESTADO=@paymentOrderStatus WHERE IDKPAGE = @IDKPAGE	
         END
      END
   END
   ELSE
   BEGIN
      UPDATE KPAGE SET ESTADO='ERROR',RESPUESTA = @response WHERE IDKPAGE = @IDKPAGE	
   END
END





