IF EXISTS(SELECT NAME FROM SYS.OBJECTS WHERE NAME = 'SPK_ENVIO_LINKPAGO_VENTASINV' AND TYPE='P')
BEGIN
	DROP PROCEDURE SPK_ENVIO_LINKPAGO_VENTASINV
END
GO
CREATE PROCEDURE DBO.SPK_ENVIO_LINKPAGO_VENTASINV
(
	@CONSECUTIVO	VARCHAR(13), --CONSECUTIVO MOVIMIENTO
	@USUARIO		VARCHAR(12), --USUARIO QUE ENVÍA EL ENLACE
   @IDKPAGE INT =0  -- IMOV. IDKPAGE

)
WITH ENCRYPTION
AS
DECLARE @IDAFILIADO VARCHAR(20)
DECLARE @EMAIL		VARCHAR(100)
DECLARE @CELULAR	VARCHAR(15)
DECLARE @NOMBREAFI  VARCHAR(100)
DECLARE @VALORCOP	DECIMAL(16,2)
DECLARE @HEAD		VARCHAR(MAX)
DECLARE @HTML		VARCHAR(MAX)
DECLARE @BODY_EMAIL VARCHAR(MAX)
DECLARE @FOOTER		VARCHAR(MAX)
DECLARE @FECHA		DATETIME
DECLARE @DATE		VARCHAR(19)
DECLARE @MES		VARCHAR(2)
DECLARE @ANIO		VARCHAR(4)
DECLARE @DIA		VARCHAR(2)
DECLARE @HORA		VARCHAR(8)
DECLARE @BODY		VARCHAR(1000)
DECLARE @sUrl		VARCHAR(3096) =  'https://api.micuentaweb.pe/api-payment/V4/Charge/CreatePaymentOrder'
DECLARE @obj		INT
DECLARE @response	VARCHAR(max)
DECLARE @urlpago	VARCHAR(255)
DECLARE @CNSFCJ		VARCHAR(20)
DECLARE @answer		NVARCHAR(max)
DECLARE @RESPUESTA	VARCHAR(20)
DECLARE @paymentOrderId		 VARCHAR(40)
DECLARE @paymentOrderStatus	 VARCHAR(40)
DECLARE @NOADMISION VARCHAR(16) 
DECLARE @MENSAJE	VARCHAR(200)
DECLARE @BASIC   VARCHAR(500) = DBO.FNK_VALORVARIABLE('IZIPAY_SERVICEMODE')
DECLARE @N_FACTURA VARCHAR(20)
DECLARE @IDPLAN VARCHAR(6)
DECLARE @PROCEDENCIA	VARCHAR(20)

SELECT  @HEAD	=  '<!DOCTYPE html>'+ '<html lang="es"><head><meta charset="UTF-8">'+
				   '<meta name="viewport" content="width=device-width, initial-scale=1.0"></head><body>'+
				   '<div style=" width: 100%; text-align: center">'+
				   '<img src="https://app.expertta.com.pe:28000/mails/banner.jpg" alt="bannerExpertta" style="width:100%; ">'+
				   '</div>'
SELECT  @FOOTER =   '<div style=" width: 100%; text-align: center">'+
                   '<img src="https://app.expertta.com.pe:28000/mails/footer.png" alt="bannerExpertta"  style="width:100%;">'+
                   '</div></body></html>'
BEGIN
SET DATEFORMAT dmy
	SELECT  @N_FACTURA=FTR.N_FACTURA,@VALORCOP=FTR.VR_TOTAL,@IDPLAN=FTR.IDPLAN,@IDAFILIADO=CNSTRAN,@FECHA=DATEADD(HOUR,6,IMOV.FECHAMOV),
   @PROCEDENCIA ='VENTASINV'
   FROM IMOV INNER JOIN FTR ON IMOV.N_FACTURA=FTR.N_FACTURA 
   WHERE CNSMOV = @CONSECUTIVO
	IF COALESCE(@IDKPAGE,0) = 0
   BEGIN
      INSERT INTO KPAGE(CONSECUTIVO, TABLA, PROCEDENCIA, FECHAGEN,MODO, VALOR, ESTADO,USUCOBRA, IDPLAN,REF_PAGO)
   	SELECT @CONSECUTIVO, 'IMOV','VENTASINV', CONVERT(SMALLDATETIME,GETDATE()),'PRODUCTION', @VALORCOP, 'CREATED',@USUARIO, @IDPLAN,@N_FACTURA
	
		SET @IDKPAGE = @@IDENTITY

		UPDATE IMOV SET IDKPAGE = @IDKPAGE WHERE CNSMOV = @CONSECUTIVO

   END
	SELECT @EMAIL = EMAIL, @CELULAR = CELULAR, @NOMBREAFI = CONCAT(PNOMBRE,' ',PAPELLIDO) FROM AFI WHERE IDAFILIADO = @IDAFILIADO
	
	SELECT @DIA  =  convert(varchar, @FECHA, 3)
	SELECT @MES  = 	convert(varchar, @FECHA, 1)
	SELECT @ANIO =  convert(varchar, @FECHA, 23)
	SELECT @HORA =  convert(varchar, @FECHA, 8)

	SET @DATE = @ANIO+'-'+@MES+'-'+@DIA+'T'+@HORA

	SELECT @BODY =' {"amount": '+
						REPLACE(REPLACE(CONVERT(varchar(50), CAST(@VALORCOP AS money), 1),'.',''),',','')+
					', "currency": "PEN", "orderId": "'+CONVERT(VARCHAR,@IDKPAGE)+
					'", "channelOptions": {"channelType": "URL", "mailOptions": { "recipient": "'+
					@EMAIL+'"}},"paymentReceiptEmail": "'+@EMAIL+'","expirationDate": "'+@DATE+'+05:00","dataCollectionForm": "false"} '
					
	BEGIN
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
		EXEC sys.sp_OADestroy @obj
			
		select @RESPUESTA = [status] from openjson (@response) with (status varchar(20) '$.status')

		UPDATE KPAGE SET BODY = @response WHERE IDKPAGE = @IDKPAGE	
		--select @response
         
		IF @RESPUESTA = 'SUCCESS'
		BEGIN
			SELECT @answer = answer FROM OPENJSON(@response) with( answer NVARCHAR(MAX) AS JSON )
			SELECT @urlpago = paymentURL, @paymentOrderId = paymentOrderId FROM OPENJSON( @answer ) with ( paymentURL VARCHAR(100) '$.paymentURL', paymentOrderId  varchar(40) '$.paymentOrderId' )
			UPDATE KPAGE SET ESTADO='SEND',RESPUESTA = @answer, paymentOrderId = @paymentOrderId WHERE IDKPAGE = @IDKPAGE	
			--SELECT @urlpago, @paymentOrderId 
			BEGIN 
				SELECT @BODY_EMAIL = '<div class="text" style="font: 100% sans-serif">'+
											'<p>Hola '+ @NOMBREAFI +'</p>'+
											'<p>El enlace para realizar el pago es el siguiente: <b>' + @urlpago + '</b>.</p>'+
											'<p>Muchas gracias.</p>'+
										'</div>'
				SET @html = @HEAD + @BODY_EMAIL + @FOOTER
				EXEC DBO.SPK_SENDMAIL_EXPERTTA  @to = @EMAIL, @subject = 'Enlace de pago', @body_html=@html 
			END

			IF LEN(@CELULAR) = 9
			BEGIN
				print @mensaje
				SET @MENSAJE = 'Hola, a continuación el enlace para realizar el pago: ' +@urlpago+ ' Gracias por utilizar nuestros servicios, Expertta te cuida.'
				EXEC SPK_SENDSMS @CELULAR,@MENSAJE 
			END
		END
	END
END



