IF NOT EXISTS(SELECT * FROM PRI WHERE ANOMES=FORMAT(GETDATE(),'yyyyMM') )
BEGIN
	INSERT INTO PRI (COMPANIA, ANO, MES, NOMPERIODO, FECHA_INI, CERRADO, FECHA_FIN, AJUSTADO, PAAG, COMPROBANTE, DOCUMENTO, NROCOMPROBANTE, TIPO_AJ, CERRADO_INV, NROCOMPROBANTE_AJI, 
	COMPROBANTE_AJI, NOREFERENCIA_AJI,  CERRADO_CARTERA, DESALDOSINICIALES, CERRADO_FAC, SI, CIERREFISCAL, EJERCICIOMES, BDATOS, CIERRECOSTOS, CIERREIMP, CERRADO_PPTO,
	CERRADONIIF, DETCARTERANIIF, DETINVENTARIONIIF,  COMP_DETCARTERA, COMP_DETINVENTARIO, SINIIF, CERRADO_CXP, MCIERRECOSTOS, NROCOMTRASCOSTO, CIERRE_TRASCOSTOS)
	SELECT '01',YEAR(GETDATE()),MONTH(GETDATE()),UPPER(DATENAME(MONTH,GETDATE()))+' '+CAST(YEAR(GETDATE()) AS VARCHAR(4)),
	CONVERT(DATETIME,'01'+'/'+CAST(MONTH(GETDATE()) AS VARCHAR(2))+'/'+CAST(YEAR(GETDATE()) AS VARCHAR(4))),0,
	DATEADD(MONTH,1, CONVERT(DATETIME,'01'+'/'+CAST(MONTH(GETDATE()) AS VARCHAR(2))+'/'+CAST(YEAR(GETDATE()) AS VARCHAR(4)))+'23:59:59')-1,
	0,0,'','','','Mensual',0,'','','',0,0,0,0,0,0,'',0,0,0,0,0,0,'','',0,0,0,'',0
END