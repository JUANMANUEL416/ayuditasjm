USE KUNIPSSAM

SELECT  * FROM FTR WHERE CAPITADA=1 ORDER BY F_FACTURA DESC

SELECT  * FROM FTR WHERE N_FACTURA='UV20183'

SELECT  * FROM FTRDC WHERE CNSFTR='0200013116'


DECLARE @JSON VARCHAR(MAX)
EXEC SPK_RIPS_JSON_FTR_CAPI 'UV20183','F:\BDATA\ExpoSql',@JSON OUTPUT
SELECT @JSON


DECLARE @CONSULTAS TABLE (
	codPrestador VARCHAR(20),
   CONSECUTIVO VARCHAR(20),
   IDAFILIADO VARCHAR(20),
	fechaInicioAtencion VARCHAR(16),
	numAutorizacion VARCHAR(30),
	codConsulta VARCHAR(6),
	modalidadGrupoServicioTecSal VARCHAR(2),
	grupoServicios VARCHAR(2),
	codServicio VARCHAR(4),
	finalidadTecnologiaSalud VARCHAR(2),
	causaMotivoAtencion VARCHAR(2),
	codDiagnosticoPrincipal VARCHAR(20),
	codDiagnosticoRelacionado1 VARCHAR(20),
	codDiagnosticoRelacionado2 VARCHAR(20),
	codDiagnosticoRelacionado3 VARCHAR(20),
	tipoDiagnosticoPrincipal VARCHAR(3),
	vrServicio int,
	tipoPagoModerador VARCHAR(2),
   tipoDocumentoIdentificacion VARCHAR(2),
	numDocumentoIdentificacion VARCHAR(20),
	conceptoRecaudo VARCHAR(20),
	valorPagoModerador VARCHAR(10),
	numFEVPagoModerador VARCHAR(20),
	usuarioId  INT 
)



			INSERT INTO @CONSULTAS(codPrestador,CONSECUTIVO,IDAFILIADO,fechaInicioAtencion,numAutorizacion,codConsulta,modalidadGrupoServicioTecSal,grupoServicios,codServicio,
								finalidadTecnologiaSalud,causaMotivoAtencion,codDiagnosticoPrincipal,codDiagnosticoRelacionado1,codDiagnosticoRelacionado2,
								codDiagnosticoRelacionado3,tipoDiagnosticoPrincipal,vrServicio,valorPagoModerador, 	tipoDocumentoIdentificacion, numDocumentoIdentificacion) --STORRES
			SELECT COALESCE('',''),HADM.NOADMISION,HADM.IDAFILIADO,fechaInicioAtencion=REPLACE(CONVERT(VARCHAR,HPRE.FECHA,102),'.','-')+' '+LEFT(CONVERT(VARCHAR,HPRE.FECHA,108),5),
			numAutorizacion=HADM.NOAUTORIZACION,codConsulta=REPLACE(REPLACE(LTRIM(RTRIM(SER.CODCUPS)),CHAR(13),''),CHAR(10),''),
         modalidadGrupoServicioTecSal='01',grupoServicios='01',
			codServicio='325',finalidadTecnologiaSalud=LEFT(CASE WHEN HPRE.FINALIDAD IS NULL OR HPRE.FINALIDAD='' OR HPRE.FINALIDAD='10'THEN '44' ELSE HPRE.FINALIDAD END,2),
			causaMotivoAtencion='38',COALESCE(HADM.DXINGRESO,HADM.DXEGRESO),COALESCE(HADM.DXSALIDA1,''),COALESCE(HADM.DXSALIDA2,''),COALESCE(HADM.DXSALIDA3,''),
			1,COALESCE(HPRED.VALOR,0),COALESCE(HPRED.VALORCOPAGO,0), MED.TIPO_ID, MED.IDMEDICO --STORRES
			FROM  FTRDC INNER JOIN HADM ON FTRDC.NOADMISION=HADM.NOADMISION  
               INNER JOIN  HPRE ON HADM.NOADMISION=HPRE.NOADMISION
					INNER JOIN HPRED ON HPRE.NOPRESTACION=HPRED.NOPRESTACION
					INNER JOIN SER ON HPRED.IDSERVICIO=SER.IDSERVICIO
					INNER JOIN RIPS_CP ON SER.CODIGORIPS=RIPS_CP.IDCONCEPTORIPS
               INNER JOIN MED ON MED.IDMEDICO = CASE WHEN COALESCE(HPRE.IDMEDICO,'') = '' THEN COALESCE(HADM.IDMEDICOALTA,HADM.IDMEDICOTRA) ELSE HPRE.IDMEDICO END-- STORRES
			WHERE FTRDC.CNSFTR='0200013116'
         --AND HADM.IDAFILIADO=@IDAFILIADO
			AND HPRED.N_FACTURA='UV20183'
         AND COALESCE(HPRED.VALOR,0)>0
			AND RIPS_CP.ARCHIVO='AC'
         AND HPRED.CANTIDAD=1