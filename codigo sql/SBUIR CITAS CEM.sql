


SELECT  * FROM CIT WHERE CONSECUTIVO LIKE '%SI%'


 SELECT  * FROM #A

 UPDATE #A SET FECHA=  REPLACE(FECHA,'&','/')

 ALTER TABLE #A ALTER COLUMN FECHA DATETIME

 DROP TABLE #B

 SELECT *, ROW_NUMBER() OVER(PARTITION BY FECHA ORDER BY FECHA DESC)NRO INTO #B FROM #A


 SELECT * FROM #B WHERE IDAFILIADO IS NULL

 UPDATE #B SET FECHA=DATEADD(HOUR,3,FECHA)
 UPDATE #B SET FECHA=DATEADD(MINUTE,NRO*10,FECHA)

 ALTER TABLE #B ADD IDAFILIADO VARCHAR(20)

 UPDATE #B SET IDAFILIADO=AFI.IDAFILIADO
 FROM #B INNER JOIN AFI ON #B.DOCIDAFILIADO=AFI.DOCIDAFILIADO

 DELETE #B WHERE IDAFILIADO IS NULL

 SELECT  * INTO #C FROM CIT WHERE CONSECUTIVO='SI0000011257'


 SELECT DBO.FNK_COLUMNAS_TABLAS('CIT')

 INSERT INTO CIT(CONSECUTIVO, FECHASOL, FECHA, FECHAATENCION, IDAFILIADO, NUMCARNET, TIPOCITA, TIPOSOLICITUD, IDSERVICIO, IDSERVICIOPROC, ATENCION, PVEZ, IDCONTRATANTE, IDSEDE, IDMEDICO, IDPLAN, URGENCIA,  VALORTOTAL, VALORCOPAGO, VALOREXEDENTE, VALORTOTALCOS, VALORCOPAGOCOSTO, IMPRESO, CUMPLIDA, IDPESPECIAL, IDESTADOE, ESTADO, CAUSALBLOQUEO, GENEROCAJA, IDSEDEATENCION, TELEFONOAVISO,  IDCAUSAL, DISPONIBILIDAD, SPD, NORECIBOCAJA, CLASEORDEN, USUARIO, NOADMISION, GENPRESTACION, FINCONSULTA, CODCAJA, FECHALLEGA, USUARIOLLEGA, OBSERVACIONES, NOAUTORIZACION,  IDSEDEORIGEN, IDIPSSOLICITA, IDMEDICOSOLICITA, AUTORIZADOPOR, FECHAAUTORIZACION, CNSAFIAA, TIPOCOPAGO, PROCEDENCIA, IDAREAH, IDAREA, CCOSTO, SUBCCOSTO, NIVELATENCION, FACTURADA,  N_FACTURA, CNSFCT, VFACTURAS, FACTURABLE, DESCUENTO, TIPODTO, MARCAFAC, IDIPS, CLASECONTRATO, ENPAQUETE, IDCIRUGIA, CNSFACT, SOAT, COPAGOPROPIO, CNSHACTRAN, ALTOCOSTO, IDDX, IDEMEDICA,  IDTERCEROCA, FINALIDAD, TIPOCAJA, CONSECUTIVOHCA, AQUIENCOBRO, VALORPROV, CODUNG, CODPRG, NOCITA, REASIGNADA, IDCONTRATO, ITFC, CNSITFC, SYS_COMPUTERNAME, NOCOBRAR, CCONTRATANTE,  CONTABILIZADA, NROCOMPROBANTE, MARCACONT, QXCONSECUTIVO, FECHACIRUGIA, FECHAREASIG, USUARIOREASIG, CODCUPS, IDPLAN_AFI, IDTERCERO_AFI, NOMBREACOMPA, TELEFONOACOMPA, PARENTESCOACOMPA,  NOMBRERESPO, TELEFONORESPO, PARENTESCORESPO, USUARIONOFACTURABLE, FECHA_NOFAC, PVEZANO, F_REQUERIDA, RIESGO, DURACION, MVARIAS, NROCITAS, CNSORIGINAL, PREGUNTAPOR, MPLAN,  IDPLANDISP, WEB, DIRECCION, CIUDAD, CORREGIMIENTO, LAT_DIR, LNG_DIR, IDBARRIO, MODALIDAD, TIPOAFILIADO, IDAUTSE, COVID, USUATENCION, USURESPONSABLE, USUGENAGENDA, FGENERACION,  IDKPAGE, COMERCIAL, HORADESDE, HORAHASTA, RESULTADOLLAMADA, USUPREANALITICA, FECHAPREANALITICA, FECHAENVIOLAB, ESTADOPREANALITICA, USUNOPROCESA, FECHANOPROCESA, RAZONNOPROCESA, ESPROGRAMAS,  URLVIDEOLLAMADA, CANTIDADC, IDFIRMAPTE, IDFIRMARESP, MODELOS, RCAMBIO, CONFIRMADA, ENUSO, USUARIOENUSO, NOPROGRAMACION, CITAENSEDE)
 SELECT #B.CONSECUTIVO, #B.FECHA, #B.FECHA, #B.FECHA, #B.IDAFILIADO,  #B.IDAFILIADO, TIPOCITA, TIPOSOLICITUD, #B.IDSERVICIO, IDSERVICIOPROC, ATENCION, PVEZ, 
 IDCONTRATANTE,COALESCE(AFI.IDSEDE,#C.IDSEDE), IDMEDICO, #B.PLAND, URGENCIA,  VALORTOTAL, VALORCOPAGO, VALOREXEDENTE, VALORTOTALCOS, VALORCOPAGOCOSTO,
 IMPRESO, CUMPLIDA, IDPESPECIAL, IDESTADOE,#C.ESTADO, CAUSALBLOQUEO, GENEROCAJA, IDSEDEATENCION, COALESCE(AFI.TELEFONORES,AFI.CELULAR),  #C.IDCAUSAL, 
 DISPONIBILIDAD, SPD, NORECIBOCAJA, CLASEORDEN, USUARIO, NOADMISION, GENPRESTACION, FINCONSULTA, CODCAJA, FECHALLEGA, 
 USUARIOLLEGA, 'Atencion de Pacienes Entidad Externa', NOAUTORIZACION,  IDSEDEORIGEN, IDIPSSOLICITA, IDMEDICOSOLICITA, AUTORIZADOPOR, 
 FECHAAUTORIZACION, #C.CNSAFIAA, TIPOCOPAGO, #C.PROCEDENCIA, IDAREAH, IDAREA, CCOSTO, SUBCCOSTO, NIVELATENCION, FACTURADA,  
 N_FACTURA, CNSFCT, VFACTURAS, FACTURABLE, DESCUENTO, TIPODTO, MARCAFAC, IDIPS, CLASECONTRATO, ENPAQUETE, IDCIRUGIA, 
 CNSFACT, SOAT, COPAGOPROPIO, CNSHACTRAN, ALTOCOSTO, 'Z000', IDEMEDICA,  IDTERCEROCA, FINALIDAD, TIPOCAJA, CONSECUTIVOHCA, 
 AQUIENCOBRO, VALORPROV, CODUNG, CODPRG, NOCITA, REASIGNADA, #C.IDCONTRATO, #C.ITFC, #C.CNSITFC, SYS_COMPUTERNAME, NOCOBRAR,
 CCONTRATANTE,  CONTABILIZADA, NROCOMPROBANTE, MARCACONT, QXCONSECUTIVO, FECHACIRUGIA, FECHAREASIG, USUARIOREASIG, 
 CODCUPS, IDPLAN_AFI, IDTERCERO_AFI, NOMBREACOMPA, TELEFONOACOMPA, PARENTESCOACOMPA,  NOMBRERESPO, TELEFONORESPO,
 PARENTESCORESPO, USUARIONOFACTURABLE, FECHA_NOFAC, PVEZANO, F_REQUERIDA, RIESGO, DURACION, MVARIAS, NROCITAS,
 CNSORIGINAL, PREGUNTAPOR, MPLAN,  IDPLANDISP, WEB, AFI.DIRECCION, #C.CIUDAD, AFI.CORREGIMIENTO, AFI.LAT_DIR, AFI.LNG_DIR, AFI.IDBARRIO, 
 MODALIDAD, #C.TIPOAFILIADO, IDAUTSE, COVID, USUATENCION, USURESPONSABLE, USUGENAGENDA, FGENERACION,  IDKPAGE, COMERCIAL,
 HORADESDE, HORAHASTA, RESULTADOLLAMADA, USUPREANALITICA, FECHAPREANALITICA, FECHAENVIOLAB, ESTADOPREANALITICA, USUNOPROCESA,
 FECHANOPROCESA, RAZONNOPROCESA, ESPROGRAMAS,  URLVIDEOLLAMADA, CANTIDADC, IDFIRMAPTE, IDFIRMARESP, MODELOS, RCAMBIO,
 CONFIRMADA, ENUSO, USUARIOENUSO, NOPROGRAMACION, CITAENSEDE
 FROM #B, #C,AFI
 WHERE #B.IDAFILIADO=AFI.IDAFILIADO

 SELECT  FACTURADA,N_FACTURA,* FROM CIT WHERE CONSECUTIVO='SI0000011260'

 DROP TABLE #A

 select IDTERCERO from ter where nit in(
'1017196417',
'1037622352',
'1040360209'

 )


 select * from fcxp where CNSFCXP like '%si%'
 use CEM

 SELECT  * FROM #B


 SELECT  * FROM #N WHERE COALESCE(CORREO,'')=''

 DELETE  #N WHERE COALESCE(CORREO,'')=''

 SELECT * FROM TER INNER JOIN #N ON TER.NIT=#N.NIT
 WHERE COALESCE(EMAIL,'')<>#N.CORREO

 UPDATE TER SET EMAIL=#N.CORREO
 FROM TER INNER JOIN #N ON TER.NIT=#N.NIT
 WHERE COALESCE(EMAIL,'')<>#N.CORREO


 SELECT  NIT,RAZONSOCIAL FROM NEMP INNER JOIN TER ON NEMP.NUMDOC=TER.IDTERCERO
 WHERE COALESCE(TER.EMAIL,'')=''


 SELECT VALORSERVICIOS,VALORCOPAGO,VR_TOTAL FROM FTR WHERE N_FACTURA='fv848'

 UPDATE  FTR SET VR_TOTAL=VALORSERVICIOS-CP_VLR_COPAGOS WHERE N_FACTURA='fv848'


 
 SELECT  * FROM CIT WHERE  OBSERVACIONES= 'Atencion de Pacienes Entidad Externa' AND IDDX='Z000' AND CONSECUTIVO<'SI0000012203'

 UPDATE  CIT SET VALORTOTAL='86600' WHERE  OBSERVACIONES= 'Atencion de Pacienes Entidad Externa' AND IDDX='Z000' AND CONSECUTIVO<'SI0000012203'

 
 SELECT  * FROM CIT INNER JOIN #B ON CIT.CONSECUTIVO=#B.CONSECUTIVO

 UPDATE CIT SET IDDX=#B.IDDX
 FROM CIT INNER JOIN #B ON CIT.CONSECUTIVO=#B.CONSECUTIVO


 SELECT  NEMPF.NUMDOC,CONCAT(NEMP.PRIMERAPELLIDO,' ',NEMP.SEGUNDOAPELLIDO,' ',NEMP.PRIMERNOMBRE,' '+NEMP.SEGUNDONOMBRE) FROM NEMPF INNER JOIN NEMP ON NEMPF.NUMDOC=NEMP.NUMDOC
 WHERE CNSPAGO=@CNSPAGO

 USE CEM

 SELECT  * INTO #C FROM FCXPD WHERE CNSFCXP='06SI000501'

 SELECT  * FROM #A

 SELECT '06SI000615' CNSFCXP,'CN71'NOREFERENCIA,'1017196417'NIT,'2072633' VALOR INTO #B UNION ALL
 SELECT '06SI000616','CN84','1037622352','7790753' UNION ALL
 SELECT '06SI000617','CN99','1040360209','833317'


 SELECT  * FROM #B

 ALTER TABLE #B ADD IDTERCERO VARCHAR(20)

 UPDATE #B SET IDTERCERO=TER.IDTERCERO
 FROM TER INNER JOIN #B ON TER.NIT=#B.NIT

 SELECT DBO.FNK_COLUMNAS_TABLAS('FCXPD')

 INSERT INTO FCXP (CNSFCXP, FECHA, CNSFCOM, IDTERCERO, NOREFERENCIA, F_FACTURAREF, F_VENCE, VALOR, ESTADO, F_CANCELADO, USUARIO, TIPOCXP, PROCEDENCIA, OBSERVACION, COMPANIA, SYS_ComputerName, USUARIOMOD,  FECHAMOD, NUMCUOTA, MARCACONT, CONTABILIZADA, NROCOMPROBANTE, SALDO, IDCLASEIMP, VLR_DESCUENTO, VLR_IVA, VLR_NETO, VLR_IMPUESTOS, SALDO_IMPUESTO, VLR_NOTASDEBITO, VLR_COMISION,  VLR_GLOSAS, VLR_FLETE, CUEDEBITO, CUECREDITO, CNSFCXPPM, MODALIDAD, SUBSIDIO, IDCONTRATO, VLR_NOTASCREDITO, VLR_ABONOS, IDSEDE, PERIODO_ANO, PERIODO_MES, CODUNG, CODPRG, CIUDAD,  ENPRESUPUESTO, SEAMORTIZA, NUMPERAMORT, IDPROPIETARIO, FACCONTROL, USUARIOMARCA, FECHAMARCA, CNSCDP, CNSRP, RUBRO, CNSPPTO, DOCEQUIVALENTE, DIASEQ, CNSENVIOFIN, N_FACTURA, VARIOSTER,  VLR_TDOLAR, TCAMBIO, CONTAAJUSCAMBIO, NROCOMPROCAMBIO, NROCOMPROESPEJO, CNSFCXPOLD, AUDITADO, USUAUDITA, CNSRESOL, CAJAMENOR, RUBRO_ID, ESTADODIAN, ZIPKEY, CUDS)
 SELECT #B.CNSFCXP, FECHA, CNSFCOM, #B.IDTERCERO, #B.NOREFERENCIA, F_FACTURAREF, F_VENCE, #B.VALOR, ESTADO, F_CANCELADO, USUARIO, TIPOCXP, PROCEDENCIA, OBSERVACION, COMPANIA, SYS_ComputerName, USUARIOMOD,  FECHAMOD, NUMCUOTA, MARCACONT, CONTABILIZADA, NROCOMPROBANTE, #B.VALOR, IDCLASEIMP, VLR_DESCUENTO, VLR_IVA, #B.VALOR, VLR_IMPUESTOS, SALDO_IMPUESTO, VLR_NOTASDEBITO, VLR_COMISION,  VLR_GLOSAS, VLR_FLETE, CUEDEBITO, CUECREDITO, CNSFCXPPM, MODALIDAD, SUBSIDIO, IDCONTRATO, VLR_NOTASCREDITO, VLR_ABONOS, IDSEDE, PERIODO_ANO, PERIODO_MES, CODUNG, CODPRG, CIUDAD,  ENPRESUPUESTO, SEAMORTIZA, NUMPERAMORT, IDPROPIETARIO, #B.NOREFERENCIA, USUARIOMARCA, FECHAMARCA, CNSCDP, CNSRP, RUBRO, CNSPPTO, DOCEQUIVALENTE, DIASEQ, CNSENVIOFIN, #B.NOREFERENCIA, VARIOSTER,  VLR_TDOLAR, TCAMBIO, CONTAAJUSCAMBIO, NROCOMPROCAMBIO, NROCOMPROESPEJO, CNSFCXPOLD, AUDITADO, USUAUDITA, CNSRESOL, CAJAMENOR, RUBRO_ID, ESTADODIAN, ZIPKEY, CUDS
 FROM #B,#A


 INSERT INTO FCXPD(CNSFCXP, ITEM, IDSERVICIO, CANTIDAD, VALOR, ESTADO, N_PRESUP, ITEM_PRESUP, IDCLASEIMP, VLR_DESCUENTO, VLR_IVA, VLR_NETO, NOLOTE, IDGRUPOSER, PREFIJO, CCOSTO, CCOSTO2, IDAREAH, IDAREA,  NROCOMPROBANTE, CUENTA_SER, VLR_GLOSAS, CUENTA_GLO, PROCEDENCIA, CODUNG, CODPRG, IDIMPUESTO, IDCLASE, ITEM_FIMPDV, CUENTA_IVA, REDONDEO, RUBRO, MIMPCONSUMO, VLRIMPCONSUMO, CTAIMPCONSUMO,  IDTERCERO, VLRCOPAGO, TIPOCOPAGO, VLR_DOLARES, CNSFCXPOLD, RUBRO_ID, UNSPSC, IDSEDE)
 SELECT #B.CNSFCXP, 1, '004', 1,  #B.VALOR, ESTADO, N_PRESUP, ITEM_PRESUP, IDCLASEIMP, VLR_DESCUENTO, VLR_IVA, #B.VALOR, NOLOTE, IDGRUPOSER, PREFIJO, CCOSTO, CCOSTO2, IDAREAH, IDAREA,  NROCOMPROBANTE, CUENTA_SER, VLR_GLOSAS, CUENTA_GLO, PROCEDENCIA, CODUNG, CODPRG, IDIMPUESTO, IDCLASE, ITEM_FIMPDV, CUENTA_IVA, REDONDEO, RUBRO, MIMPCONSUMO, VLRIMPCONSUMO, CTAIMPCONSUMO,  NULL, VLRCOPAGO, TIPOCOPAGO, VLR_DOLARES, CNSFCXPOLD, RUBRO_ID, UNSPSC, IDSEDE
 FROM #B,#C