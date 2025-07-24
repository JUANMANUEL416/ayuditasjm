TEST00000092

EXEC SPK_GENERA_JSON_PERU_FACTURA 'B001-00000101'

EXEC DBO.SPK_CONSULTA_DOCUMENTO_ELECTRONICA 'B001-00000101'

exec spk_

SELECT RAZONANULACION,TIPOFIN, * FROM FTR WHERE N_fACTURA='TEST00000092'
'Se encontraron errores: 20240820-16:00:22 329|ProcesoCargaJson|Error| Fallo en validacion: La serie del comprobante electronico tiene que iniciar con B para (boletas, nota de credito o debito de boleta), F para (facturas, nota de credito o debito de factu'

SELECT  * FROM FTR WHERE F_FACTURA>=GETDATE()-1