USE KSANITASPERU
--

SELECT  * FROM FTR WHERE N_FACTURA='B004-00000307'
SELECT  * FROM FTRD WHERE N_FACTURA='B004-00000307'
SELECT * FROM AUT WHERE IDAUT='0100004354'
SELECT * FROM AUTD WHERE NFACTURA='B004-00000307'
SELECT  * FROM CIT WHERE N_FACTURA='F002-00000197'

SELECT  * FROM TER WHERE NIT='08753726'
UPDATE TER SET TIPO_ID='DNI' WHERE NIT='08753726'

UPDATE FTR SET FACTEP=NULL WHERE N_FACTURA='B004-00000294'


	CREATE TABLE #FTRD1(CNSFTR VARCHAR(40), N_CUOTA	int IDENTITY, FECHA datetime,
				DB_CR varchar(2), AREAPRESTACION varchar(20), UBICACION varchar(16),
				VR_TOTAL float, IMPUTACION varchar(16), CCOSTO varchar (20),
				PREFIJO varchar(6), ANEXO varchar(1024), REFERENCIA varchar(40), 
				IDCIRUGIA varchar(20), CANTIDAD smallint, VALOR decimal(14,2),
				VLR_SERVICI decimal(14,2), VLR_COPAGOS decimal(14,2),
				VLR_PAGCOMP decimal(14,2), IDPROVEEDOR varchar(20),
				NOADMISION varchar(16), NOPRESTACION	varchar(16), NOITEM int,	
				AREAFUNCONT varchar(20), N_FACTURA varchar(16),
				SUBCCOSTO varchar(4), PCOSTO	decimal(14,2), FECHAPREST datetime, IDPLAN VARCHAR(6),
				IDIMPUESTO VARCHAR(10),
				IDCLASE    VARCHAR(10),
				ITEM       SMALLINT,
				VLRIMPUESTO DECIMAL(14,2),
				PIVA        DECIMAL(14,2),
				VIVA        DECIMAL(14,2),
				CUENTA_FIMPDV VARCHAR(20)
				) --FTRD


				INSERT INTO #FTRD1(CNSFTR, FECHA, DB_CR, AREAPRESTACION, UBICACION, VR_TOTAL,
						IMPUTACION, CCOSTO, PREFIJO, ANEXO, REFERENCIA, IDCIRUGIA, CANTIDAD,
						VALOR, VLR_SERVICI, VLR_COPAGOS, VLR_PAGCOMP, IDPROVEEDOR, NOADMISION,
						NOPRESTACION, NOITEM, AREAFUNCONT, N_FACTURA, SUBCCOSTO, PCOSTO, FECHAPREST, IDPLAN,IDIMPUESTO, IDCLASE,ITEM , VLRIMPUESTO, PIVA, VIVA,CUENTA_FIMPDV)
				SELECT '9900000338', GETDATE(), 'DB', AUT.IDAREA, NULL, 
						AUTD.VALORCOPAGO, 
						NULL, CASE WHEN  'SER:CCOSTO' = 'SER:CCOSTO' THEN AUTD.CCOSTO ELSE AUT.CCOSTO END, SER.PREFIJO,
						CASE WHEN dbo.FNK_VALORVARIABLE('MANEJA_GARANTIA_SER') = 'SI' THEN 
							CASE WHEN dbo.FNK_VALORVARIABLE('CLASE_IPS') = 'OPTICA' THEN  CASE WHEN COALESCE(SER.GARANTIA, 0) = 0 THEN COALESCE(SER.DESCSERVICIO, '')+' '+'Producto sin Garantia'
																																ELSE COALESCE(SER.DESCSERVICIO, '')+' '+COALESCE(SER.COMENTARIOS, '')
																																END
																				
																						ELSE SER.DESCSERVICIO
																						END
																					ELSE SER.DESCSERVICIO
																					END, 
						AUTD.IDSERVICIO, NULL, AUTD.CANTIDAD,AUTD.VALORCOPAGO, 
						AUTD.VALORCOPAGO,0, 
						0, AUT.IDPROVEEDOR, '0100004347',AUTD.IDAUT, AUTD.NO_ITEM, NULL, 
						'B004-00000307', AUT.SUBCCOSTO, AUTD.VALORTOTALCOSTO,AUT.FECHA, AUT.IDPLAN,
						CASE WHEN COALESCE(SER.IVA,'')='SER' THEN  SER.IDIMPUESTO ELSE NULL END,
						CASE WHEN COALESCE(SER.IVA,'')='SER' THEN  SER.IDCLASE ELSE NULL END,
						CASE WHEN COALESCE(SER.IVA,'')='SER' THEN  (SELECT ITEM FROM  DBO.FNK_VALOR_IMPUESTO(SER.IDIMPUESTO,SER.IDCLASE,GETDATE(),AUTD.VALORCOPAGO)) ELSE 0 END,
						CASE WHEN COALESCE(SER.IVA,'')='SER' THEN  AUTD.VALORCOPAGO  ELSE 0 END ,
						CASE WHEN COALESCE(SER.IVA,'')='SER' THEN  (SELECT VALOR FROM  DBO.FNK_VALOR_IMPUESTO(SER.IDIMPUESTO,SER.IDCLASE,GETDATE(), AUTD.VALORCOPAGO)) ELSE 0 END,
						CASE WHEN COALESCE(SER.IVA,'')='SER' THEN  (SELECT ROUND(AUTD.VALORCOPAGO*(VALOR/100),2) 
																	FROM  DBO.FNK_VALOR_IMPUESTO(SER.IDIMPUESTO,SER.IDCLASE,GETDATE(),(AUTD.CANTIDAD * AUTD.VALOR))) ELSE 0 END,
						CASE WHEN COALESCE(SER.IVA,'')='SER' THEN  (SELECT CUENTA FROM  DBO.FNK_VALOR_IMPUESTO(SER.IDIMPUESTO,SER.IDCLASE,GETDATE(),AUTD.VALORCOPAGO)) ELSE NULL END
				FROM   AUT INNER JOIN AUTD ON AUTD.IDAUT = AUT.IDAUT 
							INNER JOIN SER ON SER.IDSERVICIO = AUTD.IDSERVICIO 
							LEFT JOIN  TER ON TER.IDTERCERO = AUTD.IDTERCEROCA
				WHERE  AUT.NOAUT = '0100004347'                
					AND (AUTD.FACTURADA=0 OR AUTD.FACTURADA IS NULL OR AUTD.FACTURADA=2)
					--AND (TER.IDTERCERO = @IDTERCEROCA OR (TER.IDTERCERO IS NULL AND @IDTERCEROF=@IDTERCEROCA)) 
					AND AUTD.IDTERCEROCA='20523470761'
					AND AUTD.IDPLAN = 'PAQ002'
               AND COALESCE(AUTD.NOCOBRABLE,0)=0
               AND COALESCE(AUTD.GENERADO,0)=1

               			UPDATE #FTRD1 SET 
			CANTIDAD    = CASE WHEN CANTIDAD    IS NULL THEN 0 ELSE CANTIDAD    END,
			VALOR       = CASE WHEN VALOR       IS NULL THEN 0 ELSE VALOR       END,
			VLR_SERVICI = CASE WHEN VLR_SERVICI IS NULL THEN 0 ELSE VLR_SERVICI END,
			VR_TOTAL    = CASE WHEN VR_TOTAL    IS NULL THEN 0 ELSE VR_TOTAL    END,
			VLR_COPAGOS = CASE WHEN VLR_COPAGOS IS NULL THEN 0 ELSE VLR_COPAGOS END,
			VLR_PAGCOMP = CASE WHEN VLR_PAGCOMP IS NULL THEN 0 ELSE VLR_PAGCOMP END
         WHERE 1=1

         			INSERT INTO FTRD(CNSFTR, N_CUOTA, FECHA, DB_CR, AREAPRESTACION, UBICACION
                         ,VR_TOTAL,
						IMPUTACION, CCOSTO, PREFIJO, ANEXO, REFERENCIA, IDCIRUGIA, CANTIDAD,
						VALOR, VLR_SERVICI, VLR_COPAGOS, VLR_PAGCOMP, IDPROVEEDOR, NOADMISION,
						NOPRESTACION, NOITEM, AREAFUNCONT, N_FACTURA, SUBCCOSTO, PCOSTO, FECHAPREST,
						IDIMPUESTO, IDCLASE,ITEM , VLRIMPUESTO, PIVA, VIVA,CUENTA_FIMPDV)
			SELECT '9900000338', N_CUOTA, FECHA, DB_CR, AREAPRESTACION, UBICACION
               ,VR_TOTAL
               ,IMPUTACION ,CCOSTO, PREFIJO, ANEXO, REFERENCIA, IDCIRUGIA,CASE WHEN COALESCE(CANTIDAD,0)<=0 THEN 1 ELSE CANTIDAD END
               ,VALOR,VLR_SERVICI, VLR_COPAGOS, VLR_PAGCOMP, IDPROVEEDOR, NOADMISION
               ,NOPRESTACION, NOITEM, AREAFUNCONT, 'B004-00000307', SUBCCOSTO, PCOSTO, FECHAPREST
               ,IDIMPUESTO, IDCLASE,ITEM , VLRIMPUESTO, PIVA, VIVA,CUENTA_FIMPDV        
			FROM   #FTRD1


         DECLARE @VIVA DECIMAL(14,2)
         DECLARE @PIVA DECIMAL(7,2)
         DECLARE @MIVA BIT
         DECLARE @NVOCONSEC VARCHAR(20)='B004-00000307'
         DECLARE @VRTOTAL DECIMAL(14,2)
         DECLARE @VRSERV DECIMAL(14,2)
         DECLARE @VRCOPA DECIMAL(14,2)
         DECLARE @VRPACO DECIMAL(14,2)
			SELECT @VIVA=SUM(COALESCE(VIVA,0)) FROM FTRD WHERE FTRD.N_FACTURA = @NVOCONSEC  
			IF @VIVA>0
			BEGIN
				SELECT TOP 1 @PIVA=PIVA ,@MIVA=1 FROM FTRD WHERE FTRD.N_FACTURA = @NVOCONSEC  AND COALESCE(PIVA,0)<>0            
				UPDATE FTR SET MIVA=@MIVA,PIVA=@PIVA,VIVA=@VIVA WHERE N_FACTURA = @NVOCONSEC
				--UPDATE FTRD SET VALOR=VALOR-CASE WHEN COALESCE(VIVA,0)>0 THEN VIVA ELSE 0 END WHERE N_FACTURA = @NVOCONSEC
			END

			SELECT @VRTOTAL = SUM(VR_TOTAL), @VRSERV = SUM(VLR_SERVICI),@VRCOPA = SUM(VLR_COPAGOS)  ,
				@VRPACO  = SUM(VLR_PAGCOMP)
			FROM FTRD WHERE N_FACTURA = @NVOCONSEC

         			UPDATE FTR SET VALORSERVICIOS = @VRSERV, VALORCOPAGO = ROUND(@VRCOPA,0), VALORPCOMP = @VRPACO,
					DESCUENTO = 0
			WHERE N_FACTURA = @NVOCONSEC
         
     
         
			UPDATE FTR SET VR_TOTAL = COALESCE(VALORSERVICIOS,0) - COALESCE(VALORCOPAGO,0) - COALESCE(VALORPCOMP,0) - COALESCE(DESCUENTO,0) - COALESCE(VR_ABONOS,0)--+CASE WHEN @BASE_IVA_SER='CONIVA' THEN 0 ELSE  COALESCE(@VIVA,0) END                      
			WHERE  N_FACTURA = @NVOCONSEC  

         DROP TABLE #FTRD1