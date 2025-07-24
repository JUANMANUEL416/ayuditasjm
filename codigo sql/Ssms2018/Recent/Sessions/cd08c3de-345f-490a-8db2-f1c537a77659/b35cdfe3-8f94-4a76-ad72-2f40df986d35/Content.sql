use KOFTAL
SELECT  * FROM FTR WHERE N_FACTURA='FEOP71883'
SELECT  * FROM FTRJSON WHERE CNSFCT='0100094929'

SELECT TOP 10 * FROM API_LOG WHERE USUARIO='JJIMENEZ' ORDER BY ITEM DESC


EXEC SPQ_JSON '{"MODELO":"FTR_COL","METODO":"RIPS_JSON","PARAMETROS":{"CNSFCT":"0100094110","TIPODOC":"FACTURA"},"USUARIO":"JJIMENEZ"}'

SELECT  * FROM TGEN WHERE TABLA='TRANSIEND'

5
SELECT TOP 20 * FROM tgen WHERE TABLA = 'TRANSIENT'

SELECT  * FROM FTR WHERE CNSFCT='0100094847'

UPDATE FTR SET CUV='a576720b47b7e0ae100d4285902a5c5a6f716b8a2fb5dc13eda85561b0550fc05aafd2daa996bcf628f027f2ffff069f' WHERE CNSFCT='0100094929'

UPDATE FTRJSON SET JSON_RESPUESTA='{
  "ResultState": true,
  "ProcesoId": 27428,
  "NumFactura": "FEOP72702",
  "CodigoUnicoValidacion": "a576720b47b7e0ae100d4285902a5c5a6f716b8a2fb5dc13eda85561b0550fc05aafd2daa996bcf628f027f2ffff069f",
  "FechaRadicacion": "2025-03-13T21:51:34.6119543+00:00",
  "RutaArchivos": null,
  "ResultadosValidacion": [
    {
      "Clase": "NOTIFICACION",
      "Codigo": "FED129",
      "Descripcion": "[Interoperabilidad.Group.Collection.AdditionalInformation.NUMERO_CONTRATO.Value] El apartado no existe o no tiene valor en el XML del documento electrónico. Por favor verifique que la etiqueta Xml use mayúsculas y minúsculas según resolución",
      "Observaciones": "",
      "PathFuente": "",
      "Fuente": "FacturaElectronica"
    },
    {
      "Clase": "NOTIFICACION",
      "Codigo": "RVC017",
      "Descripcion": "El código de CUPS puede ser validado que corresponda a la cobertura o plan de beneficios informada en la factura electrónica de venta.",
      "Observaciones": "Verificar tabla de referencia Dato (115308)",
      "PathFuente": "usuarios[0].servicios.procedimientos[0].codProcedimiento",
      "Fuente": "Rips"
    },
    {
      "Clase": "NOTIFICACION",
      "Codigo": "RVC019",
      "Descripcion": "El código de CUPS se puede validar con el diagnóstico principal.",
      "Observaciones": "Verificar tabla de referencia Dato (115308)",
      "PathFuente": "usuarios[0].servicios.procedimientos[0].codProcedimiento",
      "Fuente": "Rips"
    },
    {
      "Clase": "NOTIFICACION",
      "Codigo": "RVC059",
      "Descripcion": "El código de CUPS puede ser validado con el grupo de servicio, servicio, finalidad o causa.",
      "Observaciones": "Verificar tabla de referencia codProcedimiento (115308) - Finalidad (16)",
      "PathFuente": "usuarios[0].servicios.procedimientos[0].codProcedimiento",
      "Fuente": "Rips"
    },
    {
      "Clase": "NOTIFICACION",
      "Codigo": "FED129",
      "Descripcion": "[Interoperabilidad.Group.Collection.AdditionalInformation.NUMERO_CONTRATO.Value] El apartado no existe o no tiene valor en el XML del documento electrónico. Por favor verifique que la etiqueta Xml use mayúsculas y minúsculas según resolución",
      "Observaciones": "",
      "PathFuente": "",
      "Fuente": "FacturaElectronica"
    }
  ]
}',CUV='a576720b47b7e0ae100d4285902a5c5a6f716b8a2fb5dc13eda85561b0550fc05aafd2daa996bcf628f027f2ffff069f' WHERE CNSFCT='0100094929'