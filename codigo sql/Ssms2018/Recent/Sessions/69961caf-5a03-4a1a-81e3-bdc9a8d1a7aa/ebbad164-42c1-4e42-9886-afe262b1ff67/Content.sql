use PINTERNACIONAL

SELECT  * FROM FNOT

EXEC SPK_JSON_FTR_PERU_INTERFAX 'B001-00000027'

EXEC SPK_ANU

EXEC SPK_JSON_FTR_PERU_INTERFAX_FNOT

SELECT * FROM FTRAPILOG WHERE N_FACTURA='B001-00000027'

select top 1 * from API_LOG  WHERE USUARIO='TEST' order by ITEM desc

EXEC SPQ_JSON '{"MODELO":"SAP","METODO":"RPTA_PREFECTURA","PARAMETROS":{"DATOS":{"EmisionFacturaSUNAT":{"CO_ERROR":"","CO_ESTA_PREFA":"1","DE_ERROR":"","FE_COMP_SUNAT":"20241129","FE_ERROR":"","NU_COMP_SUNAT":"03-BH04-00023740","PK_PREFA_PREABO":"8355903","TI_COMP_XHIS":"0","TI_ORIGEN":"1"}}},"USUARIO":"TEST"}'


SELECT * FROM DBO.FNK_EXPLODE('W,R,T',',')