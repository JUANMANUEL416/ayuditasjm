SELECT A.N_FACTURA, A.PROCEDENCIA, A.NOREFERENCIA, A.CNSHACTRAN, A.IDAFILIADO, B.CONDICIONACC, B.NATUREVENTO
FROM (
      SELECT FCXCD.N_FACTURA, FTR.PROCEDENCIA, FTR.NOREFERENCIA, FTR.IDAFILIADO,
             CASE FTR.PROCEDENCIA WHEN 'CE' THEN (SELECT AUT.CNSHACTRAN FROM AUT WHERE AUT.NOAUT = FTR.NOREFERENCIA)
                                  WHEN 'CI' THEN (SELECT CIT.CNSHACTRAN FROM CIT WHERE CIT.CONSECUTIVO = FTR.NOREFERENCIA)
                                  WHEN 'SALUD' THEN (SELECT CNSHACTRAN FROM HADM WHERE HADM.NOADMISION = FTR.NOREFERENCIA)
             END CNSHACTRAN
      FROM   FCXCD INNER JOIN FTR ON FCXCD.N_FACTURA = FTR.N_FACTURA
      WHERE  FCXCD.CNSCXC = '0100016575'
     ) A LEFT JOIN 
     (
       SELECT CNSHACTRAN, CONDICIONACC, NATUREVENTO
       FROM   HACTRAN
     ) B ON A.CNSHACTRAN = B.CNSHACTRAN

     select * from fcxc where cnscxc = '0100016575'

SELECT CMP00, CMP01, CMP02, CMP03, CMP04, CMP05, CMP06, CMP07, CMP08, CMP09, CMP10, 
       CMP11, CMP12, CMP13, CMP14, CMP15, CMP16, CMP17, CMP18, CMP19, CMP20, CMP21, CMP22, 
       CMP23, CMP24, CMP25, CMP26, CMP27, CMP28, CMP29, CMP30, CMP31, CMP32, CMP33, CMP34, 
       CMP35, CMP36, CMP37, CMP38, CMP39, CMP40, CMP41, CMP42, CMP43, CMP44, CMP45, CMP46, 
       CMP47, CMP48, CMP49, CMP50, CMP51, CMP52, CMP53, CMP54, CMP55, CMP56, CMP57, CMP58, 
       CMP59, CMP60, CMP61, CMP62, CMP63, CMP64, CMP65, CMP66, CMP67, CMP68, CMP69, CMP70, 
       CMP71, CMP72, CMP73, CMP74, CMP75, CMP76, CMP77, CMP78, CMP79, CMP80, CMP81, CMP82, 
       CMP83, CMP84, CMP85, CMP86, CMP87, CMP88, CMP89, CMP90, CMP91, CMP92, CMP93, CMP94, 
       CMP95, CMP96, CMP97, CMP98, CMP99 
FROM   DBO.FNK_SOAT_FURIPS1_CXC('0100016575', 'IDSGSSS', '900462447')

select * from FNK_SOAT_FURIPS1('0100006565', 'HSJM01119991', 'CODIGOPRES', '900462447')

SELECT CODIGORIPS, CODFURIPS, CODCUM, CODCUPS, * FROM SER

UPDATE SER SET CODFURIPS = CASE CODIGORIPS WHEN '01' THEN 2
                                           WHEN '02' THEN 2
                                           WHEN '03' THEN 2
                                           WHEN '04' THEN 2
                                           WHEN '05' THEN 2
                                           WHEN '06' THEN 2
                                           WHEN '07' THEN 2
                                           WHEN '08' THEN 2
                                           WHEN '09' THEN 5
                                           WHEN '10' THEN 2
                                           WHEN '11' THEN 2
                                           WHEN '12' THEN 1
                                           WHEN '13' THEN 1
                                           WHEN '14' THEN 3
                           END 

SELECT * FROM RIPS_CP

01	CONSULTAS	                     AC 2
02	PROCEDIMIENTOS DIAGNOSTICOS	   AP 2
03	PROCEDIMIENTOS TERAPEUTICO NO QX	AP 2
04	PROCEDIMIENTOS TERAP�UTICOS QX	AP 2
05	PROCEDIMIENTOS DE PYP	         AP 2
06	ESTANCIA	                        AT 2
07	HONORARIOS	                     AT 2
08	DERECHOS DE SALA	               AT 2
09	MATERIALES E INSUMOS	            AT 5
10	BANCO DE SANGRE	               AT 2
11	PR�TESIS Y �RTESIS	            AT 2
12	MEDICAMENTOS POS	               AM 1
13	MEDICAMENTOS NO POS	            AM 1
14	TRASLADO DE PACIENTES	         AT 3