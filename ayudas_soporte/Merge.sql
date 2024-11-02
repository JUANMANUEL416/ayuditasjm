MERGE IXVER.DBO.TER AS Target
USING (SELECT IDTERCERO, RAZONSOCIAL, NIT, DV, TIPO_ID, IDALTERNA1, IDALTERNA2, DIRECCION, NATJURIDICA, CIUDAD, TELEFONOS, FAX, APA, F_INSCRIPTO, F_RENOVACION,
              F_VENCIMIENT, R_LEGAL, TIPO_ID_R, NIT_R, ESTADO, REQAUTORIZA, CUENTA, ZONA, CIA, ACT_ECONOMICA, ENVIODICAJA, MODOCOPAGO, EMPIDMODELOPC, DIASVTO,
              ESEXTRANJERO, CLASIFICADOR, IDGRUPOIMP, AUTORETENEDOR, GRANCONTRIBUYENTE, EMAIL, URL, NOMBRES_R_LEGAL, P_APELLIDO_R_LEGAL, S_APELLIDO_R_LEGAL,
              DE_NIT_R_LEGAL, IDACTIVIDAD, TIPOREGIMEN, MSUCURSALES, FORMAPRE, CODIGO_ARP, NORAD, TIPOAPORTANTE, CODOPERADOR, CODIGO_AFP,CODIGO_CCF, ASESOR_AFI,
              ASESOR_MTO, FNAC_RLEGAL, HOBBIE_RL, PROF_RL, EMAIL_RL, TIPOID_TH, NID_TH, DE_NIT_TH, NOMBRES_TH, P_APELLIDO_TH, S_APELLIDO_TH, FNAC_TH, 
              HOBBIE_TH, PROF_TH, EMAIL_TH, ITFC, CNSITFC, HOMOLOGO, PNOMBRE, SNOMBRE ,PAPELLIDO, SAPELLIDO, CUE_BANCARIA, TIPO_CUE, BANCO, SUCURSAL 
       FROM dbo.ter) AS Source
ON (Target.IDtercero COLLATE database_default= Source.IDtercero COLLATE database_default)
WHEN MATCHED THEN
     UPDATE SET Target.RAZONSOCIAL = Source.RAZONSOCIAL,                 Target.NIT = Source.NIT,
                Target.DV = Source.DV,                                   Target.TIPO_ID = Source.TIPO_ID,
                Target.IDALTERNA1 = Source.IDALTERNA1,                   Target.IDALTERNA2 = Source.IDALTERNA2,
                Target.DIRECCION = Source.DIRECCION,                     Target.NATJURIDICA = Source.NATJURIDICA,
                Target.CIUDAD = Source.CIUDAD,                           Target.TELEFONOS = Source.TELEFONOS,
                Target.FAX = Source.FAX,                                 Target.APA = Source.APA,
                Target.F_INSCRIPTO = Source.F_INSCRIPTO,                 Target.F_RENOVACION = Source.F_RENOVACION,
                Target.F_VENCIMIENT = Source.F_VENCIMIENT,               Target.R_LEGAL = Source.R_LEGAL,
                Target.TIPO_ID_R = Source.TIPO_ID_R,                     Target.NIT_R = Source.NIT_R,
                Target.ESTADO = Source.ESTADO,                           Target.REQAUTORIZA = Source.REQAUTORIZA,
                Target.CUENTA = Source.CUENTA,                           Target.ZONA = Source.ZONA,
                Target.CIA = Source.CIA,                                 Target.ACT_ECONOMICA = Source.ACT_ECONOMICA,
                Target.ENVIODICAJA = Source.ENVIODICAJA,                 Target.MODOCOPAGO = Source.MODOCOPAGO,             
                Target.EMPIDMODELOPC = Source.EMPIDMODELOPC,             Target.DIASVTO = Source.DIASVTO,
                Target.ESEXTRANJERO = Source.ESEXTRANJERO,               Target.CLASIFICADOR = Source.CLASIFICADOR, 
                Target.IDGRUPOIMP = Source.IDGRUPOIMP,                   Target.AUTORETENEDOR = Source.AUTORETENEDOR, 
                Target.GRANCONTRIBUYENTE = Source.GRANCONTRIBUYENTE,     Target.EMAIL = Source.EMAIL, 
                Target.URL = Source.URL ,                                Target.NOMBRES_R_LEGAL = Source.NOMBRES_R_LEGAL, 
                Target.P_APELLIDO_R_LEGAL  = Source.P_APELLIDO_R_LEGAL,  Target.S_APELLIDO_R_LEGAL  = Source.S_APELLIDO_R_LEGAL,
                Target.DE_NIT_R_LEGAL  = Source.DE_NIT_R_LEGAL,          Target.IDACTIVIDAD  = Source.IDACTIVIDAD, 
                Target.TIPOREGIMEN  = Source.TIPOREGIMEN,                Target.MSUCURSALES  = Source.MSUCURSALES, 
                Target.FORMAPRE  = Source.FORMAPRE,                      Target.CODIGO_ARP  = Source.CODIGO_ARP, 
                Target.NORAD  = Source.NORAD,                            Target.TIPOAPORTANTE  = Source.TIPOAPORTANTE, 
                Target.CODOPERADOR  = Source.CODOPERADOR,                Target.CODIGO_AFP  = Source.CODIGO_AFP,
                Target.CODIGO_CCF  = Source.CODIGO_CCF,                  Target.ASESOR_AFI  = Source.ASESOR_AFI,
                Target.ASESOR_MTO  = Source.ASESOR_MTO,                  Target.FNAC_RLEGAL  = Source.FNAC_RLEGAL, 
                Target.HOBBIE_RL  = Source.HOBBIE_RL,                    Target.PROF_RL  = Source.PROF_RL, 
                Target.EMAIL_RL  = Source.EMAIL_RL,                      Target.TIPOID_TH  = Source.TIPOID_TH, 
                Target.NID_TH  = Source.NID_TH,                          Target.DE_NIT_TH  = Source.DE_NIT_TH, 
                Target.NOMBRES_TH  = Source.NOMBRES_TH,                  Target.P_APELLIDO_TH  = Source.P_APELLIDO_TH, 
                Target.S_APELLIDO_TH  = Source.S_APELLIDO_TH,            Target.FNAC_TH  = Source.FNAC_TH, 
                Target.HOBBIE_TH  = Source.HOBBIE_TH,                    Target.PROF_TH  = Source.PROF_TH, 
                Target.EMAIL_TH  = Source.EMAIL_TH,                      Target.ITFC  = Source.ITFC, 
                Target.CNSITFC  = Source.CNSITFC,                        Target.HOMOLOGO  = Source.HOMOLOGO, 
                Target.PNOMBRE  = Source.PNOMBRE,                        Target.SNOMBRE  = Source.SNOMBRE,
                Target.PAPELLIDO  = Source.PAPELLIDO,                    Target.SAPELLIDO  = Source.SAPELLIDO, 
                Target.CUE_BANCARIA  = Source.CUE_BANCARIA,              Target.TIPO_CUE  = Source.TIPO_CUE, 
                Target.BANCO  = Source.BANCO,                            Target.SUCURSAL  = Source.SUCURSAL
WHEN NOT MATCHED BY TARGET THEN
      INSERT (IDTERCERO, RAZONSOCIAL, NIT, DV, TIPO_ID, IDALTERNA1, IDALTERNA2, DIRECCION, NATJURIDICA, CIUDAD, TELEFONOS, FAX, APA, F_INSCRIPTO, F_RENOVACION,
              F_VENCIMIENT, R_LEGAL, TIPO_ID_R, NIT_R, ESTADO, REQAUTORIZA, CUENTA, ZONA, CIA, ACT_ECONOMICA, ENVIODICAJA, MODOCOPAGO, EMPIDMODELOPC, DIASVTO,
              ESEXTRANJERO, CLASIFICADOR, IDGRUPOIMP, AUTORETENEDOR, GRANCONTRIBUYENTE, EMAIL, URL, NOMBRES_R_LEGAL, P_APELLIDO_R_LEGAL, S_APELLIDO_R_LEGAL,
              DE_NIT_R_LEGAL, IDACTIVIDAD, TIPOREGIMEN, MSUCURSALES, FORMAPRE, CODIGO_ARP, NORAD, TIPOAPORTANTE, CODOPERADOR, CODIGO_AFP,CODIGO_CCF, ASESOR_AFI,
              ASESOR_MTO, FNAC_RLEGAL, HOBBIE_RL, PROF_RL, EMAIL_RL, TIPOID_TH, NID_TH, DE_NIT_TH, NOMBRES_TH, P_APELLIDO_TH, S_APELLIDO_TH, FNAC_TH, 
              HOBBIE_TH, PROF_TH, EMAIL_TH, ITFC, CNSITFC, HOMOLOGO, PNOMBRE, SNOMBRE ,PAPELLIDO, SAPELLIDO, CUE_BANCARIA, TIPO_CUE, BANCO, SUCURSAL)
      VALUES (Source.IDTERCERO, Source.RAZONSOCIAL, Source.NIT, Source.DV, Source.TIPO_ID, Source.IDALTERNA1, Source.IDALTERNA2, Source.DIRECCION, Source.NATJURIDICA, 
              Source.CIUDAD, Source.TELEFONOS, Source.FAX, Source.APA, Source.F_INSCRIPTO, Source.F_RENOVACION,
              Source.F_VENCIMIENT, Source.R_LEGAL, Source.TIPO_ID_R, Source.NIT_R, Source.ESTADO, Source.REQAUTORIZA, Source.CUENTA, Source.ZONA, Source.CIA, 
              Source.ACT_ECONOMICA, Source.ENVIODICAJA, Source.MODOCOPAGO, Source.EMPIDMODELOPC, Source.DIASVTO,
              Source.ESEXTRANJERO, Source.CLASIFICADOR, Source.IDGRUPOIMP, Source.AUTORETENEDOR, Source.GRANCONTRIBUYENTE, Source.EMAIL, Source.URL, 
              Source.NOMBRES_R_LEGAL, Source.P_APELLIDO_R_LEGAL, Source.S_APELLIDO_R_LEGAL, Source.DE_NIT_R_LEGAL, Source.IDACTIVIDAD, Source.TIPOREGIMEN, 
              Source.MSUCURSALES, Source.FORMAPRE, Source.CODIGO_ARP, Source.NORAD, Source.TIPOAPORTANTE, Source.CODOPERADOR, Source.CODIGO_AFP,Source.CODIGO_CCF, 
              Source.ASESOR_AFI, Source.ASESOR_MTO, Source.FNAC_RLEGAL, Source.HOBBIE_RL, Source.PROF_RL, Source.EMAIL_RL, Source.TIPOID_TH, Source.NID_TH, 
              Source.DE_NIT_TH, Source.NOMBRES_TH, Source.P_APELLIDO_TH, Source.S_APELLIDO_TH, Source.FNAC_TH, 
              Source.HOBBIE_TH, Source.PROF_TH, Source.EMAIL_TH, Source.ITFC, Source.CNSITFC, Source.HOMOLOGO, Source.PNOMBRE, Source.SNOMBRE ,Source.PAPELLIDO, 
              Source.SAPELLIDO, Source.CUE_BANCARIA, Source.TIPO_CUE, Source.BANCO, Source.SUCURSAL)
WHEN NOT MATCHED BY SOURCE THEN
     DELETE;

SELECT COLUMN_NAME +' as ORIGEN_' + COLUMN_NAME + ', ' from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='TER'

