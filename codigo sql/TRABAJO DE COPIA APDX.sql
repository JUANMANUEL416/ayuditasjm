IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'SPK_PASA_DATOS_LABORATORIO' AND TYPE = 'P')
BEGIN
   DROP PROCEDURE SPK_PASA_DATOS_LABORATORIO 
END
GO
CREATE PROCEDURE DBO.SPK_PASA_DATOS_LABORATORIO   
WITH ENCRYPTION
AS 
DECLARE @NOINGRESO VARCHAR(20)
DECLARE @NORDEN    VARCHAR(20)
DECLARE @TIPOINGRESO VARCHAR(2)
DECLARE @IDAFILIADO  VARCHAR(20)
DECLARE @NOPRESTACION VARCHAR(20)--NOAUT
DECLARE @IDSERVICIO   VARCHAR(20)
DECLARE @NOAUT       VARCHAR(20)
DECLARE @IDAUT       VARCHAR(20)
DECLARE @IDAUTAUX    VARCHAR(20)
DECLARE @NOAUTAUX    VARCHAR(20)
BEGIN
   DECLARE LING_CURSOR CURSOR FOR  
   SELECT LING.NOINGRESO,LORD.NORDEN,LING.TIPOINGRESO,LING.IDAFILIADO,LING.NOPRESTACION,LORD.IDSERVICIO
   FROM LING INNER JOIN LORD ON LING.NOINGRESO=LORD.NOINGRESO
   WHERE LORD.ESTADO='R'
   AND NOT EXISTS(SELECT * FROM KDIAGNOSTICAR.DBO.LORD X WHERE X.NOINGRESO=LORD.NOINGRESO AND X.NORDEN=LORD.NORDEN)    
   AND LING.AMBITOTR='LX'
   AND LING.FECHA>='01/08/2016'
   ORDER BY LING.NOINGRESO
   OPEN LING_CURSOR    
   FETCH NEXT FROM LING_CURSOR    
   INTO @NOINGRESO,@NORDEN,@TIPOINGRESO,@IDAFILIADO,@NOPRESTACION,@IDSERVICIO
   WHILE @@FETCH_STATUS = 0    
   BEGIN 
      PRINT 'PRIMERO AFI'
      IF NOT EXISTS(SELECT * FROM  KDIAGNOSTICAR.DBO.AFI WHERE IDAFILIADO=@IDAFILIADO)
      BEGIN
         INSERT INTO KDIAGNOSTICAR.DBO.AFI (IDAFILIADO, PAPELLIDO, SAPELLIDO, PNOMBRE, SNOMBRE, TIPO_DOC, DOCIDAFILIADO, IDALTERNA, IDAFILIADOPPAL, GRUPO_SANG, ESTADO_CIVIL, GRUPOETNICO, SEXO, IDPARENTESCO, LOCALIDAD, DIRECCION,                                              TELEFONORES, CIUDAD, ZONA, CODENTIDADANTERIOR, ESTADO, FECHAULTESTADO, IDSEDE, IDPROVEEDOR, FNACIMIENTO, FECHAAFILSGSSS, ACT_ECONO, IDESCOLARIDAD, INDCOTIZANTE, ULTIMOANOAPROBADO,                                              INCAPACIDADLABORAL, TIPODISCAPACIDAD, TIPOAFILIADO, GRUPOATESPECIAL, CABEZADEFAMILIA, ASOCIADO, TIENEOBS, CAMPOUSUARIO1, FECHAUVISITA, CONSANGUINIDAD, IDADMINISTRADORA, IDCAUSAL,                                              FECHACAUSAL, CLASIFPC, NIVELSOCIOEC, IDPLAN, FECHAAFILIACION, NUMCARNET, CIUDADDOC, IDEMPLEADOR, SEMANASCOT, CARNETIZADO, FECHACARNET, CONSCERTIFICADO, CIUDADNAC, IDOCUPACION,                                              NACIONALIDAD, CELULAR, DIRECCIONLAB, TELEFONOLAB, CNSAFIAA, SISBENNUMFICHA, SISBENFECHAFICHA, SISBENPUNTAJE, SISBENNUCLEOFAM, SISBENGRUPOB, IDCONTRATO, IDBARRIO, CLASEAFILIACIONARS,                                              FORMULARIO, EMAIL, NORADICACION, FECHARADICACION, IDTIPOAFILIACION, IDCLASEAFILIACION, V_FORMULARIO, SISBENNIVEL, CNSXCPA, FESTADO, OKBD, USUARIOBD, NACIMIENTO, ITFC, CNSITFC,                                              TIPOSUBSIDIO, COBERTURA_SALUD, TIPOAFILIADO2, IDAFI_TITULAR, ES_NN, IDESPECIAL, MTRIAGE, FTRIAGE, GRUPOPOB)
         SELECT IDAFILIADO, PAPELLIDO, SAPELLIDO, PNOMBRE, SNOMBRE, TIPO_DOC, DOCIDAFILIADO, IDALTERNA, IDAFILIADOPPAL, GRUPO_SANG, ESTADO_CIVIL, GRUPOETNICO, SEXO, IDPARENTESCO, LOCALIDAD, DIRECCION,                TELEFONORES, CIUDAD, ZONA, CODENTIDADANTERIOR, ESTADO, FECHAULTESTADO, IDSEDE, IDPROVEEDOR, FNACIMIENTO, FECHAAFILSGSSS, ACT_ECONO, IDESCOLARIDAD, INDCOTIZANTE, ULTIMOANOAPROBADO,                INCAPACIDADLABORAL, TIPODISCAPACIDAD, TIPOAFILIADO, GRUPOATESPECIAL, CABEZADEFAMILIA, ASOCIADO, TIENEOBS, CAMPOUSUARIO1, FECHAUVISITA, CONSANGUINIDAD, '800152039', IDCAUSAL,                FECHACAUSAL, CLASIFPC, NIVELSOCIOEC, 'CLIHON', FECHAAFILIACION, NUMCARNET, CIUDADDOC, IDEMPLEADOR, SEMANASCOT, CARNETIZADO, FECHACARNET, CONSCERTIFICADO, CIUDADNAC, IDOCUPACION,                NACIONALIDAD, CELULAR, DIRECCIONLAB, TELEFONOLAB, CNSAFIAA, SISBENNUMFICHA, SISBENFECHAFICHA, SISBENPUNTAJE, SISBENNUCLEOFAM, SISBENGRUPOB, IDCONTRATO, IDBARRIO, CLASEAFILIACIONARS,                FORMULARIO, EMAIL, NORADICACION, FECHARADICACION, IDTIPOAFILIACION, IDCLASEAFILIACION, V_FORMULARIO, SISBENNIVEL, CNSXCPA, FESTADO, OKBD, USUARIOBD, NACIMIENTO, ITFC, CNSITFC,                TIPOSUBSIDIO, COBERTURA_SALUD, TIPOAFILIADO2, IDAFI_TITULAR, ES_NN, IDESPECIAL, MTRIAGE, FTRIAGE, GRUPOPOB
         FROM AFI WHERE IDAFILIADO=@IDAFILIADO
      END
      IF NOT EXISTS(SELECT * FROM KDIAGNOSTICAR.DBO.LING WHERE NOINGRESO=@NOINGRESO)
      BEGIN
         IF @TIPOINGRESO='C'
         BEGIN
            EXEC SPK_GENCONSECUTIVO '01','01','@AUTF', @NOAUT OUTPUT  
            SELECT @NOAUT = '01' + REPLACE(SPACE(8 - LEN(@NOAUT))+LTRIM(RTRIM(@NOAUT)),SPACE(1),0)   
            EXEC SPK_GENCONSECUTIVO '01','01','@AUT', @IDAUT OUTPUT  
            SELECT @IDAUT = '01' + REPLACE(SPACE(8 - LEN(@IDAUT))+LTRIM(RTRIM(@IDAUT)),SPACE(1),0)      
      
            SELECT @IDAUTAUX=IDAUT FROM AUT WHERE NOAUT=@NOPRESTACION

            INSERT INTO KDIAGNOSTICAR.DBO.AUT(IDAUT, NOAUT, FECHA, FECHAVENCE, FECHASOL, IDAFILIADO, NUMCARNET, IDPLAN, PREFIJO, IDSEDE, IDSEDEORIGEN, TIPOAUTORIZACION, ALTOCOSTO, ATENCION, URGENCIA, IMPUTABLE_A, IDSOLICITANTE,                               IDPROVEEDOR, ESTADO, CONSANULADO, IDOPERADORANULA, FECHAANULA, CAUSALANULA, NO_ITEMES, VALORTOTAL, VALORCOPAGO, VALORBENEFICIO, VALOREXEDENTE, VALORTOTALCOSTO, VALORCOPAGOCOSTO,                               IMPRESO, CXPGEN, CXCGEN, AUTORIZADOPOR, NUMAUTORIZA, FECHAAUTORIZA, AUTORIZADO, IDPESPECIAL, IDESTADOE, USUARIO, RECOBRARA, FUENTE, IDCAUSAEXT, AMBITO, FINALIDAD, PERSONAL_AT, DXPPAL,                               DXRELACIONADO, COMPLICACION, FORMAQX, TIPOURGENCIA, SPD, NORECIBOCAJA, CLASEORDEN, GENEROCAJA, IDCONTRATANTE, TIPOCOPAGO, PEDIDOINV, ENVIO, OBS, ESCONTINUACION, NOAUTORIGEN,                               SEMANASCOT, LIQUIDAPC, OBSDX, COMITE, CERTIFICACION, IDCLASEAUT, CLASECONT, ESDEINV, NOGENERACIONOPS, FECHAGEN, CNSAFIAA, PROCEDENCIA, IDAREAH, IDAREA, CCOSTO, SUBCCOSTO, NIVELATENCION,                               FACTURADA, N_FACTURA, CNSFCT, VFACTURAS, FACTURABLE, DESCUENTO, TIPODTO, MARCAFAC, IDIPS, CLASECONTRATO, ENPAQUETE, IDCIRUGIA, SOAT, NOADMISION, IDCONTRATO, RUBRO, CLASERUBRO,                               PERIODICIDAD, CNSFACT, CONTINUACION, VLRUTOTRA, TIPOCONT, DXRELACIONADO2, FECHACOMITE, IDALTERNA, MARCAENV, COPAGOPROPIO, CNSHACTRAN, ESDELAB, ENLAB, COBRARA, IDTERCEROCA, CONSECUTIVOHCA,                               RAZONANULACION, PIDECCOSTO, FECHAREALIZACION, CODCAJA, TIPOCAJA, IDGRUPOSER, PEXTERNA, AQUIENCOBRO, CODUNG, CODPRG, ITFC, CNSITFC, SYS_COMPUTERNAME, CNSLABCOR, TIPOUSUARIO,                               NOADMISIONCE, INDLABCORE, CERRADA, CONTABILIZADA, NROCOMPROBANTE, MARCACONT, SINCRONIZADO, IDPLAN_AFI, IDTERCERO_AFI, USUARIONOFACTURABLE, FECHA_NOFAC)  
            SELECT @IDAUT, @NOAUT, FECHA, FECHAVENCE, FECHASOL, IDAFILIADO, NUMCARNET, 'CLIHON', PREFIJO, IDSEDE, IDSEDEORIGEN, TIPOAUTORIZACION, ALTOCOSTO, ATENCION, URGENCIA, IMPUTABLE_A, IDSOLICITANTE,                      IDPROVEEDOR, ESTADO, CONSANULADO, IDOPERADORANULA, FECHAANULA, CAUSALANULA, NO_ITEMES,CASE WHEN IDPLAN=DBO.FNK_VALORVARIABLE('IDPLANPART') THEN VALORTOTAL ELSE  VALORTOTAL*0.70 END, 0,                      VALORBENEFICIO,CASE WHEN IDPLAN=DBO.FNK_VALORVARIABLE('IDPLANPART') THEN VALORTOTAL ELSE  VALORTOTAL*0.70 END, VALORTOTALCOSTO, VALORCOPAGOCOSTO,                      IMPRESO, CXPGEN, CXCGEN, AUTORIZADOPOR, NUMAUTORIZA, FECHAAUTORIZA, AUTORIZADO, IDPESPECIAL, IDESTADOE, USUARIO, RECOBRARA, FUENTE, IDCAUSAEXT, AMBITO, FINALIDAD, PERSONAL_AT, DXPPAL,                      DXRELACIONADO, COMPLICACION, FORMAQX, TIPOURGENCIA, SPD, NORECIBOCAJA, CLASEORDEN, GENEROCAJA, IDCONTRATANTE, TIPOCOPAGO, PEDIDOINV, ENVIO, OBS, ESCONTINUACION, NOAUTORIGEN,                      SEMANASCOT, LIQUIDAPC, OBSDX, COMITE, CERTIFICACION, IDCLASEAUT, CLASECONT, ESDEINV, NOGENERACIONOPS, FECHAGEN, CNSAFIAA, PROCEDENCIA, IDAREAH, IDAREA, CCOSTO, SUBCCOSTO, NIVELATENCION,                      0, NULL, CNSFCT, VFACTURAS, FACTURABLE, DESCUENTO, TIPODTO, MARCAFAC, IDIPS, CLASECONTRATO, ENPAQUETE, IDCIRUGIA, SOAT, NOADMISION, IDCONTRATO, RUBRO, CLASERUBRO,                      PERIODICIDAD, NULL, CONTINUACION, VLRUTOTRA, TIPOCONT, DXRELACIONADO2, FECHACOMITE, IDALTERNA, MARCAENV, COPAGOPROPIO, CNSHACTRAN, ESDELAB, ENLAB, COBRARA, '800152039', CONSECUTIVOHCA,                      RAZONANULACION, PIDECCOSTO, FECHAREALIZACION, CODCAJA, TIPOCAJA, IDGRUPOSER, PEXTERNA, AQUIENCOBRO, CODUNG, CODPRG, ITFC, CNSITFC, SYS_COMPUTERNAME, CNSLABCOR, TIPOUSUARIO,                      NOADMISIONCE, INDLABCORE, CERRADA, CONTABILIZADA, NROCOMPROBANTE, MARCACONT, SINCRONIZADO, IDPLAN_AFI, IDTERCERO_AFI, USUARIONOFACTURABLE, FECHA_NOFAC  
            FROM AUT WHERE NOAUT=@NOPRESTACION   
                            
            INSERT INTO KDIAGNOSTICAR.DBO.AUTD(IDAUT, NO_ITEM, IDSERVICIO, CANTIDAD, VALOR, VALORCOPAGO, VALORCOPAGOCOSTO, VALOREXCEDENTE, VALORTOTALCOSTO, IDPLAN, IMPRESO, AUTORIZADO, COMENTARIOS, PCOBERTURA, OBS, NORDEN, CCOSTO,                                                 CODIGOCPCJ, MARCAPAGO, NOAUTORIZEXT, ESDELAB, ENLAB, IDTERCEROCA, IDCONTRATO, FACTURADA, N_FACTURA, CNSFCT, AQUIENCOBRO, MARCACOPAGOORDEN, VALORPROV, PCOSTO, ITFC, CNSITFC, SYS_COMPUTERNAME,                                                 NOCOBRABLE, MDOSIFICACION, CANTIDIA, DIAS, FRECUENCIA, CODCUPS, POSOLOGIA, SINCRONIZADO, APOYODG_AMBITO, CITAAUTORIZADA, DOSISAPL, DURACIONTTOF, DURACIONTTOC, CLASEPOSOLOGIA,                                                 MARCA, USUARIOMARCA, NUM_ORDEN)
            SELECT @IDAUT, NO_ITEM, IDSERVICIO, CANTIDAD, CASE WHEN IDPLAN=DBO.FNK_VALORVARIABLE('IDPLANPART') THEN VALOR ELSE  VALOR*0.70 END , 0, VALORCOPAGOCOSTO, CASE WHEN IDPLAN=DBO.FNK_VALORVARIABLE('IDPLANPART') THEN VALOR ELSE  VALOR*0.70 END, VALORTOTALCOSTO,                   'CLIHON', IMPRESO, AUTORIZADO, COMENTARIOS, PCOBERTURA, OBS, NORDEN, CCOSTO,                   CODIGOCPCJ, MARCAPAGO, NOAUTORIZEXT, ESDELAB, ENLAB, '800152039', IDCONTRATO, 0, NULL, NULL, AQUIENCOBRO, MARCACOPAGOORDEN, VALORPROV, PCOSTO, ITFC, CNSITFC, SYS_COMPUTERNAME,                   NOCOBRABLE, MDOSIFICACION, CANTIDIA, DIAS, FRECUENCIA, CODCUPS, POSOLOGIA, SINCRONIZADO, APOYODG_AMBITO, CITAAUTORIZADA, DOSISAPL, DURACIONTTOF, DURACIONTTOC, CLASEPOSOLOGIA,                   MARCA, USUARIOMARCA, NUM_ORDEN
            FROM AUTD WHERE IDAUT=@IDAUTAUX AND AUTD.IDSERVICIO=@IDSERVICIO
         END
         ELSE
         BEGIN
            EXEC SPK_GENCONSECUTIVO '01','01','@AUTF', @NOAUT OUTPUT  
            SELECT @NOAUT = '01' + REPLACE(SPACE(8 - LEN(@NOAUT))+LTRIM(RTRIM(@NOAUT)),SPACE(1),0)   
            EXEC SPK_GENCONSECUTIVO '01','01','@AUT', @IDAUT OUTPUT  
            SELECT @IDAUT = '01' + REPLACE(SPACE(8 - LEN(@IDAUT))+LTRIM(RTRIM(@IDAUT)),SPACE(1),0) 


            INSERT INTO KDIAGNOSTICAR.DBO.AUT(IDAUT, NOAUT, FECHA, FECHAVENCE, FECHASOL, IDAFILIADO, NUMCARNET, IDPLAN, PREFIJO, IDSEDE, IDSEDEORIGEN, TIPOAUTORIZACION, ALTOCOSTO, ATENCION, URGENCIA, IMPUTABLE_A, IDSOLICITANTE,                               IDPROVEEDOR, ESTADO, CONSANULADO, IDOPERADORANULA, FECHAANULA, CAUSALANULA, NO_ITEMES, VALORTOTAL, VALORCOPAGO, VALORBENEFICIO, VALOREXEDENTE, VALORTOTALCOSTO, VALORCOPAGOCOSTO,                               IMPRESO, CXPGEN, CXCGEN, AUTORIZADOPOR, NUMAUTORIZA, FECHAAUTORIZA, AUTORIZADO, IDPESPECIAL, IDESTADOE, USUARIO, RECOBRARA, FUENTE, IDCAUSAEXT, AMBITO, FINALIDAD, PERSONAL_AT, DXPPAL,                               DXRELACIONADO, COMPLICACION, FORMAQX, TIPOURGENCIA, SPD, NORECIBOCAJA, CLASEORDEN, GENEROCAJA, IDCONTRATANTE, TIPOCOPAGO, PEDIDOINV, ENVIO, OBS, ESCONTINUACION, NOAUTORIGEN,                               SEMANASCOT, LIQUIDAPC, OBSDX, COMITE, CERTIFICACION, IDCLASEAUT, CLASECONT, ESDEINV, NOGENERACIONOPS, FECHAGEN, CNSAFIAA, PROCEDENCIA, IDAREAH, IDAREA, CCOSTO, SUBCCOSTO, NIVELATENCION,                               FACTURADA, N_FACTURA, CNSFCT, VFACTURAS, FACTURABLE, DESCUENTO, TIPODTO, MARCAFAC, IDIPS, CLASECONTRATO, ENPAQUETE, IDCIRUGIA, SOAT, NOADMISION, IDCONTRATO, RUBRO, CLASERUBRO,                               PERIODICIDAD, CNSFACT, CONTINUACION, VLRUTOTRA, TIPOCONT, DXRELACIONADO2, FECHACOMITE, IDALTERNA, MARCAENV, COPAGOPROPIO, CNSHACTRAN, ESDELAB, ENLAB, COBRARA, IDTERCEROCA, CONSECUTIVOHCA,                               RAZONANULACION, PIDECCOSTO, FECHAREALIZACION, CODCAJA, TIPOCAJA, IDGRUPOSER, PEXTERNA, AQUIENCOBRO, CODUNG, CODPRG, ITFC, CNSITFC, SYS_COMPUTERNAME, CNSLABCOR, TIPOUSUARIO,                               NOADMISIONCE, INDLABCORE, CERRADA, CONTABILIZADA, NROCOMPROBANTE, MARCACONT, SINCRONIZADO, IDPLAN_AFI, IDTERCERO_AFI, USUARIONOFACTURABLE, FECHA_NOFAC) 
            SELECT @IDAUT, @NOAUT, FECHA, FECHA, FECHA, @IDAFILIADO, @IDAFILIADO, 'CLIHON', PREFIJO, IDSEDE, IDSEDE, 'Posterior', ALTOCOSTO, 'Asistencial', 1, 'Administradora', '',                      DBO.FNK_VALORVARIABLE('IDTERCEROINSTALADO'), 'Pendiente', NULL, NULL, NULL, NULL, NO_ITEMES,CASE WHEN IDPLAN=DBO.FNK_VALORVARIABLE('IDPLANPART') THEN VALORTOTAL ELSE  VALORTOTAL*0.70 END, 0,                      0,CASE WHEN IDPLAN=DBO.FNK_VALORVARIABLE('IDPLANPART') THEN VALORTOTAL ELSE  VALORTOTAL*0.70 END, 0, 0,                      IMPRESO, 0, 0, AUTORIZADOPOR, NUMAUTORIZA, FECHAAUTORIZA, AUTORIZADO, NULL, NULL, USUARIO, NULL, NULL, NULL, AMBITO, FINALIDAD, PERSONAL_AT, DXPPAL,                      DXRELACIONADO, COMPLICACION, FORMAQX, NULL, 1, NULL, CLASEORDEN, 0, '800152039', 'N', PEDIDOINV, '', '', '', '',                      0, 0, '', '', '', '', '', 0, '', NULL, NULL, PROCEDENCIA, IDAREAH, IDAREA, CCOSTO, SUBCCOSTO, NIVELATENCION,                      0, NULL, NULL, 0, 1, 0, NULL, 0, '', NULL, 0, NULL, 0, NOADMISION, NULL, NULL, NULL,                      0, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0, NULL, 1, ENLAB, COBRARA, '800152039', CONSECUTIVOHCA,                      NULL, 0, GETDATE(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, ITFC, CNSITFC, SYS_COMPUTERNAME, CNSLABCOR, NULL,                      NULL, INDLABCORE, CERRADA, CONTABILIZADA, NROCOMPROBANTE, MARCACONT, SINCRONIZADO, 'CLIHON', '800152039', NULL, NULL  
            FROM HPRE WHERE NOPRESTACION=@NOPRESTACION 

            INSERT INTO KDIAGNOSTICAR.DBO.AUTD(IDAUT, NO_ITEM, IDSERVICIO, CANTIDAD, VALOR, VALORCOPAGO, VALORCOPAGOCOSTO, VALOREXCEDENTE, VALORTOTALCOSTO, IDPLAN, IMPRESO, AUTORIZADO, COMENTARIOS, PCOBERTURA, OBS, NORDEN, CCOSTO,                                                 CODIGOCPCJ, MARCAPAGO, NOAUTORIZEXT, ESDELAB, ENLAB, IDTERCEROCA, IDCONTRATO, FACTURADA, N_FACTURA, CNSFCT, AQUIENCOBRO, MARCACOPAGOORDEN, VALORPROV, PCOSTO, ITFC, CNSITFC, SYS_COMPUTERNAME,                                                 NOCOBRABLE, MDOSIFICACION, CANTIDIA, DIAS, FRECUENCIA, CODCUPS, POSOLOGIA, SINCRONIZADO, APOYODG_AMBITO, CITAAUTORIZADA, DOSISAPL, DURACIONTTOF, DURACIONTTOC, CLASEPOSOLOGIA,                                                 MARCA, USUARIOMARCA, NUM_ORDEN)
            SELECT @IDAUT, NOITEM, IDSERVICIO, CANTIDAD, CASE WHEN IDPLAN=DBO.FNK_VALORVARIABLE('IDPLANPART') THEN VALOR ELSE  VALOR*0.70 END , 0, 0, CASE WHEN IDPLAN=DBO.FNK_VALORVARIABLE('IDPLANPART') THEN VALOR ELSE  VALOR*0.70 END, VALORTOTALCOSTO,                   'CLIHON', IMPRESO, AUTORIZADO, COMENTARIOS, 100, COMENTARIOS, NORDEN, CCOSTO,                   NULL, 0, NULL, 1, 1, '800152039', IDCONTRATO, 0, NULL, NULL, AQUIENCOBRO, NULL, 0, PCOSTO, ITFC, CNSITFC, NULL,                   NOCOBRABLE, 0, 0, 0, 0, CODCUPS, 0, SINCRONIZADO, APOYODG_AMBITO, NULL, NULL, NULL, NULL, NULL,                   MARCA, USUARIOMARCA, NUM_ORDEN
            FROM HPRED WHERE NOPRESTACION=@NOPRESTACION  AND IDSERVICIO=@IDSERVICIO    
         END
         PRINT 'NO EXISTE LING'
         INSERT INTO KDIAGNOSTICAR.DBO.LING(NOINGRESO, TIPOINGRESO, IDAFILIADO, IDTERCERO, IDPLAN, FECHA, NOADMISION, NOPRESTACION, FINALIDAD, AMBITO, PERSONAL_AT, IDMEDICO,                                              COBRARA, IDTERCEROCA, IMPRESO, ESTADO, RECIBE, IDRECIBE,NOMRECIBE, FALTAENTREGA, CONSECUTIVOHCA, AMBITOTR, USUARIO, FECHA_PRES, CCOSTO, IDAREA, INTERFACE)
         SELECT NOINGRESO, TIPOINGRESO, IDAFILIADO, '800152039', 'CLIHON', FECHA, NOADMISION, @NOAUT, FINALIDAD, AMBITO, PERSONAL_AT, IDMEDICO, COBRARA, '800152039', IMPRESO, ESTADO, RECIBE, IDRECIBE,                   NOMRECIBE, FALTAENTREGA, CONSECUTIVOHCA, AMBITOTR, USUARIO, FECHA_PRES, CCOSTO, IDAREA, INTERFACE
         FROM LING WHERE NOINGRESO=@NOINGRESO
      END
      ELSE
      BEGIN
         PRINT 'EXISTE Y VOY A INSERTAR EL SERVICIO'
         PRINT '@TIPOINGRESO ='+@TIPOINGRESO
         SELECT @NOAUTAUX=NOPRESTACION FROM KDIAGNOSTICAR.DBO.LING WHERE NOINGRESO=@NOINGRESO
         SELECT @IDAUT=IDAUT FROM  KDIAGNOSTICAR.DBO.AUT WHERE NOAUT=@NOAUTAUX
         SELECT @IDAUTAUX=IDAUT FROM AUT WHERE NOAUT=@NOPRESTACION
         PRINT '@NOAUTAUX ='+@NOAUTAUX
         PRINT '@IDAUT = '+@IDAUT
         PRINT '@NOPRESTACION = '+@NOPRESTACION  --SELECT * FROM HPRED WHERE NOPRESTACION='0100039738'
         PRINT '@IDAUTAUX='+@IDAUTAUX
         PRINT '@IDSERVICIO='+@IDSERVICIO
         IF @TIPOINGRESO='C'
         BEGIN
            INSERT INTO KDIAGNOSTICAR.DBO.AUTD(IDAUT, NO_ITEM, IDSERVICIO, CANTIDAD, VALOR, VALORCOPAGO, VALORCOPAGOCOSTO, VALOREXCEDENTE, VALORTOTALCOSTO, IDPLAN, IMPRESO, AUTORIZADO, COMENTARIOS, PCOBERTURA, OBS, NORDEN, CCOSTO,                                                 CODIGOCPCJ, MARCAPAGO, NOAUTORIZEXT, ESDELAB, ENLAB, IDTERCEROCA, IDCONTRATO, FACTURADA, N_FACTURA, CNSFCT, AQUIENCOBRO, MARCACOPAGOORDEN, VALORPROV, PCOSTO, ITFC, CNSITFC, SYS_COMPUTERNAME,                                                 NOCOBRABLE, MDOSIFICACION, CANTIDIA, DIAS, FRECUENCIA, CODCUPS, POSOLOGIA, SINCRONIZADO, APOYODG_AMBITO, CITAAUTORIZADA, DOSISAPL, DURACIONTTOF, DURACIONTTOC, CLASEPOSOLOGIA,                                                 MARCA, USUARIOMARCA, NUM_ORDEN)
            SELECT @IDAUT, NO_ITEM, IDSERVICIO, CANTIDAD, CASE WHEN IDPLAN=DBO.FNK_VALORVARIABLE('IDPLANPART') THEN VALOR ELSE  VALOR*0.70 END , 0, VALORCOPAGOCOSTO, CASE WHEN IDPLAN=DBO.FNK_VALORVARIABLE('IDPLANPART') THEN VALOR ELSE  VALOR*0.70 END, VALORTOTALCOSTO,                   'CLIHON', IMPRESO, AUTORIZADO, COMENTARIOS, PCOBERTURA, OBS, NORDEN, CCOSTO,                   CODIGOCPCJ, MARCAPAGO, NOAUTORIZEXT, ESDELAB, ENLAB, '800152039', IDCONTRATO, 0, NULL, NULL, AQUIENCOBRO, MARCACOPAGOORDEN, VALORPROV, PCOSTO, ITFC, CNSITFC, SYS_COMPUTERNAME,                   NOCOBRABLE, MDOSIFICACION, CANTIDIA, DIAS, FRECUENCIA, CODCUPS, POSOLOGIA, SINCRONIZADO, APOYODG_AMBITO, CITAAUTORIZADA, DOSISAPL, DURACIONTTOF, DURACIONTTOC, CLASEPOSOLOGIA,                   MARCA, USUARIOMARCA, NUM_ORDEN
            FROM AUTD WHERE IDAUT=@IDAUTAUX AND AUTD.IDSERVICIO=@IDSERVICIO
         END
         ELSE
         BEGIN
            INSERT INTO KDIAGNOSTICAR.DBO.AUTD(IDAUT, NO_ITEM, IDSERVICIO, CANTIDAD, VALOR, VALORCOPAGO, VALORCOPAGOCOSTO, VALOREXCEDENTE, VALORTOTALCOSTO, IDPLAN, IMPRESO, AUTORIZADO, COMENTARIOS, PCOBERTURA, OBS, NORDEN, CCOSTO,                                                 CODIGOCPCJ, MARCAPAGO, NOAUTORIZEXT, ESDELAB, ENLAB, IDTERCEROCA, IDCONTRATO, FACTURADA, N_FACTURA, CNSFCT, AQUIENCOBRO, MARCACOPAGOORDEN, VALORPROV, PCOSTO, ITFC, CNSITFC, SYS_COMPUTERNAME,                                                 NOCOBRABLE, MDOSIFICACION, CANTIDIA, DIAS, FRECUENCIA, CODCUPS, POSOLOGIA, SINCRONIZADO, APOYODG_AMBITO, CITAAUTORIZADA, DOSISAPL, DURACIONTTOF, DURACIONTTOC, CLASEPOSOLOGIA,                                                 MARCA, USUARIOMARCA, NUM_ORDEN)
            SELECT @IDAUT, NOITEM, IDSERVICIO, CANTIDAD, CASE WHEN IDPLAN=DBO.FNK_VALORVARIABLE('IDPLANPART') THEN VALOR ELSE  VALOR*0.70 END , 0, 0, CASE WHEN IDPLAN=DBO.FNK_VALORVARIABLE('IDPLANPART') THEN VALOR ELSE  VALOR*0.70 END, VALORTOTALCOSTO,                   'CLIHON', IMPRESO, AUTORIZADO, COMENTARIOS, 100, COMENTARIOS, NORDEN, CCOSTO,                   NULL, 0, NULL, 1, 1, '800152039', IDCONTRATO, 0, NULL, NULL, AQUIENCOBRO, NULL, 0, PCOSTO, ITFC, CNSITFC, NULL,                   NOCOBRABLE, 0, 0, 0, 0, CODCUPS, 0, SINCRONIZADO, APOYODG_AMBITO, NULL, NULL, NULL, NULL, NULL,                   MARCA, USUARIOMARCA, NUM_ORDEN
            FROM HPRED WHERE NOPRESTACION=@NOPRESTACION  AND IDSERVICIO=@IDSERVICIO  
         END
      END
      IF NOT EXISTS(SELECT * FROM KDIAGNOSTICAR.DBO.LORD WHERE NOINGRESO=@NOINGRESO AND NORDEN=@NORDEN)
      BEGIN
         INSERT INTO KDIAGNOSTICAR.DBO.LORD(NORDEN, NOINGRESO, IDSERVICIO, FECHA, ESTADO, CNSTRA, IMPRESO, RECIBE, IDRECIBE, NOMRECIBE, PEDIDOINV, NOITEM, CONSECUTIVOHCA, ITEMRED, CODOM, REALIZADO, LISTOENTREGA, ENTREGADO, OBSERVACION,                                              FECHARES, USUARIORES, RESPMUESTRA, FECHAMUESTRA, MUESTRA, IDMEDICO, OPORTUNIDAD, RESULTADO, CONCLUSION, MARCA, SYS_COMPUTERNAME_MARCA, NUM_ORDEN, SERIAL)
         SELECT NORDEN, NOINGRESO, IDSERVICIO, FECHA, ESTADO, CNSTRA, IMPRESO, RECIBE, IDRECIBE, NOMRECIBE, PEDIDOINV, NOITEM, CONSECUTIVOHCA, ITEMRED, CODOM, REALIZADO, LISTOENTREGA, ENTREGADO, OBSERVACION,                   FECHARES, USUARIORES, RESPMUESTRA, FECHAMUESTRA, MUESTRA, IDMEDICO, OPORTUNIDAD, RESULTADO, CONCLUSION, MARCA, SYS_COMPUTERNAME_MARCA, NUM_ORDEN, SERIAL
         FROM LORD WHERE NOINGRESO=@NOINGRESO AND NORDEN=@NORDEN

         INSERT INTO KDIAGNOSTICAR.DBO.LORDD(NORDEN, NOITEM, IDDATO, MEMO, ALFANUMERICO, FECHA, OBS, IDSERVICIO, TIPOCAMPO, SEXO, TIPORANGO, RANGOINI, RANGOFIN, MINIMO, MAXIMO, NOTA, IDIMG, VR_MINIMO, VR_MAXIMO, UNIDADES, COD_ANALITO,                                              SERIE)
         SELECT NORDEN, NOITEM, IDDATO, MEMO, ALFANUMERICO, FECHA, OBS, IDSERVICIO, TIPOCAMPO, SEXO, TIPORANGO, RANGOINI, RANGOFIN, MINIMO, MAXIMO, NOTA, IDIMG, VR_MINIMO, VR_MAXIMO, UNIDADES, COD_ANALITO,                   SERIE
         FROM LORDD WHERE NORDEN=@NORDEN

         INSERT INTO KDIAGNOSTICAR.DBO.LORDDM (NORDEN, IDDATO, NOITEM, OPCION, MULTICHECK, OBS, SEXO, TIPORANGO, RANGOINI, RANGOFIN, MINIMO, MAXIMO, NOTA)
         SELECT NORDEN, IDDATO, NOITEM, OPCION, MULTICHECK, OBS, SEXO, TIPORANGO, RANGOINI, RANGOFIN, MINIMO, MAXIMO, NOTA 
         FROM LORDDM WHERE NORDEN=@NORDEN
      END
      FETCH NEXT FROM LING_CURSOR    
      INTO  @NOINGRESO,@NORDEN,@TIPOINGRESO,@IDAFILIADO,@NOPRESTACION,@IDSERVICIO
   END
   CLOSE LING_CURSOR
   DEALLOCATE LING_CURSOR
END
GO

