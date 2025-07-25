SELECT TOP 1 * INTO #B  FROM IACT

SELECT DBO.FNK_COLUMNAS_TABLAS('IACT')

INSERT INTO IACT(IDACTIVO, IDTIPOACTIVO, DESCRIPCION, FECHACOMPRA, PRECIOCOMPRA, PRECIOCOMERCIAL, REFERENCIA, MODELO, MARCA, NOESCRITURA, LINDEROS, NOPARTE, MATRICULA, SERIAL, CCOSTO, UBICACION, RESPONSABLE,  IDTERCERO, ESTADO, DEPACUMHISTORICA, DEPACUMDIFERIDA, FECHAULTDEPRECIACION, TIPOASOCIACION, IDACTIVOGRUPO, CODIGOINTERNO, CODIGOBARRA, CUENTA, IDBODEGA, MESESADEPRECIAR,  MESESDEPRECIADOS, VALORSALVAMENTO, AJUSTEACUMULADO, IDAREA, NOLOTE, CATEGORIA, IDITAR, IDARTICULO, CODPRG, CODUNG, CUENTA_AJINFLACION, CUENTA_AJDEPRECIACION, CUENTA_AJINFLA_DEP,  AJUSTEDEPACUMULADA, DEPRECIABLE, subccosto, ICODALTERNO, IDTIPONIIF, PRECIOCOMERCIALNIIF, DEPACUMHISTORICANIIF, DEPACUMDIFERIDANIIF, FECHAULTDEPRECNIIF, VALORSALVAMENTONIIF, MESESADEPRECIARNIIF,  MESESDEPRECIADOSNIIF, SECTOR, CLASEGRUPO, FPRIMERMTTO, NROMTTOANUAL, FULTIMOMTTO, CLASEMMTO, ANOFAB, RINVIMA, ESTAUSO, VOLTAMAX, VOLTAMIN, CORRIENTEMAX, FUSIBLE, POTENCIA,  FRECUENCIA, VELOCIDAD, PESO, PRESION, TEMPOPERA, HUMEREL, TECNODOMI, RIESGO, CLASEQUI, FUNCIONAMIENTO, SECALIBRA, PERIOCALI, FULTIMACALI, PARADA, IDFOTO, M_OPERE, M_MMTO,  M_PARTES, PLANO_ELECT, PLANO_ELEC, PLANO_NEU, PLANO_MECA, USO, TIPO_MMTO, ALTERNATIVA, PROPIEDAD, GARANTIA, M_DESPIECE, TIPOELEMENTO, REFRIGERANTE, CAPACIDAD, CAPACITOR)
SELECT #A.IDACTIVO, IDTIPOACTIVO, #A.DESCRIPCION, #A.F_COMPRA, #A.VLR_COMPRA, #A.VLR_COMPRA, REFERENCIA, #A.MODELO, #A.MARCA, #A.SERIAL, LINDEROS, NOPARTE, MATRICULA, #A.SERIAL, #A.CCOSTO, #A.UBICACION, NULL,  NULL, ESTADO, 0, 0, NULL, TIPOASOCIACION, IDACTIVOGRUPO, #A.IDACTIVO, CODIGOBARRA, #A.CUENTA, IDBODEGA, 0,  0, 0, 0, #A.IDAREA, 'SI', CATEGORIA, IDITAR, IDARTICULO, CODPRG, CODUNG, CUENTA_AJINFLACION, CUENTA_AJDEPRECIACION, CUENTA_AJINFLA_DEP,  AJUSTEDEPACUMULADA, DEPRECIABLE, subccosto, ICODALTERNO, IDTIPONIIF, PRECIOCOMERCIALNIIF, DEPACUMHISTORICANIIF, DEPACUMDIFERIDANIIF, FECHAULTDEPRECNIIF, VALORSALVAMENTONIIF, MESESADEPRECIARNIIF,  MESESDEPRECIADOSNIIF, SECTOR, CLASEGRUPO, FPRIMERMTTO, NROMTTOANUAL, FULTIMOMTTO, CLASEMMTO, ANOFAB, RINVIMA, ESTAUSO, VOLTAMAX, VOLTAMIN, CORRIENTEMAX, FUSIBLE, POTENCIA,  FRECUENCIA, VELOCIDAD, PESO, PRESION, TEMPOPERA, HUMEREL, TECNODOMI, RIESGO, CLASEQUI, FUNCIONAMIENTO, SECALIBRA, PERIOCALI, FULTIMACALI, PARADA, IDFOTO, M_OPERE, M_MMTO,  M_PARTES, PLANO_ELECT, PLANO_ELEC, PLANO_NEU, PLANO_MECA, USO, TIPO_MMTO, ALTERNATIVA, PROPIEDAD, GARANTIA, M_DESPIECE, TIPOELEMENTO, REFRIGERANTE, CAPACIDAD, CAPACITOR
FROM #A,#B

SELECT * FROM #A

UPDATE #A SET F_COMPRA=REPLACE(F_COMPRA,'&','/')

ALTER TABLE #A ALTER COLUMN VLR_COMPRA DECIMAL(14,2)


SELECT IDACTIVO,IDTIPOACTIVO,DESCRIPCION,DBO.FNK_FECHA_DDMMAA(FECHACOMPRA)FECHACOMRA,PRECIOCOMPRA FROM IACT WHERE IDACTIVO>='ACT00000012'

SELECT IDTIPOACTIVO,DESCRIPCION,VIDAUTIL FROM IACTT 

DELETE IACTT WHERE CLASE='NIIF'

SELECT  * FROM SequenceControl WHERE PREFIJO LIKE'%ACTIVO%'

SELECT  * FROM USCXS WHERE PREFIJO LIKE'%ACTIVO%'

SELECT  * FROM FCXP WHERE CNSFCXP='01SR000257'

<i class="fa-solid fa-check"></i>
<i class="fa-solid fa-xmark"></i>