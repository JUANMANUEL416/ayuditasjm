SELECT SCHEMA_NAME(OBJECTPROPERTY(OBJECT_ID,'SchemaId')) AS SchemaName,
       OBJECT_NAME(OBJECT_ID) AS TableName,
       name AS ColumnName,'DBCC CHECKIDENT ('+OBJECT_NAME(OBJECT_ID)+', RESEED,0)'
FROM  SYS.COLUMNS
WHERE is_identity = 1
ORDER BY SchemaName, TableName, ColumnName


DBCC CHECKIDENT (AFIALERT, RESEED,0)
DBCC CHECKIDENT (AFIBDEX, RESEED,0)
DBCC CHECKIDENT (ARCHIVOS, RESEED,0)
DBCC CHECKIDENT (BRICNF, RESEED,0)
DBCC CHECKIDENT (BRIPAR, RESEED,0)
DBCC CHECKIDENT (BRIPD, RESEED,0)
DBCC CHECKIDENT (BRIPE, RESEED,0)
DBCC CHECKIDENT (BRIPED, RESEED,0)
DBCC CHECKIDENT (BRIPL, RESEED,0)
DBCC CHECKIDENT (COTI, RESEED,0)
DBCC CHECKIDENT (COTID, RESEED,0)
DBCC CHECKIDENT (COTIDL, RESEED,0)
DBCC CHECKIDENT (CT_SXT, RESEED,0)
DBCC CHECKIDENT (CUEC, RESEED,0)
DBCC CHECKIDENT (CUENIIF, RESEED,0)
DBCC CHECKIDENT (CXPS, RESEED,0)
DBCC CHECKIDENT (dtproperties, RESEED,0)
DBCC CHECKIDENT (EFTR, RESEED,0)
DBCC CHECKIDENT (ENCDF, RESEED,0)
DBCC CHECKIDENT (ENCU, RESEED,0)
DBCC CHECKIDENT (ENCUD, RESEED,0)
DBCC CHECKIDENT (ENCUDL, RESEED,0)
DBCC CHECKIDENT (EXOFGEN, RESEED,0)
DBCC CHECKIDENT (FCJPCXC, RESEED,0)
DBCC CHECKIDENT (FCJTD, RESEED,0)
DBCC CHECKIDENT (FCTZD, RESEED,0)
DBCC CHECKIDENT (FCXCDV, RESEED,0)
DBCC CHECKIDENT (FNK_CALCULO_VALORCONCEPTO_NOM, RESEED,0)
DBCC CHECKIDENT (FNK_MOVXTERCERO, RESEED,0)
DBCC CHECKIDENT (FNK_NFU_AUTILIQ_ANTIGUA, RESEED,0)
DBCC CHECKIDENT (FNK_NFU_REG_T10, RESEED,0)
DBCC CHECKIDENT (FNK_NFU_REG_T2, RESEED,0)
DBCC CHECKIDENT (FNK_NFU_REG_T3, RESEED,0)
DBCC CHECKIDENT (FNK_NFU_REG_T4, RESEED,0)
DBCC CHECKIDENT (FNK_NFU_REG_T5, RESEED,0)
DBCC CHECKIDENT (FNK_NFU_REG_T6, RESEED,0)
DBCC CHECKIDENT (FNK_NFU_REG_T7, RESEED,0)
DBCC CHECKIDENT (FNK_NFU_REG_T8, RESEED,0)
DBCC CHECKIDENT (FNK_NFU_REG_T9, RESEED,0)
DBCC CHECKIDENT (FNK_ORD_EVOL, RESEED,0)
DBCC CHECKIDENT (FNK_VALORCONCEPTO_NEMPFD_RUN, RESEED,0)
DBCC CHECKIDENT (FNK_VALORCONCEPTO_NEMPFD_RUN_RET, RESEED,0)
DBCC CHECKIDENT (FTRNOPOS, RESEED,0)
DBCC CHECKIDENT (HACTRANCE, RESEED,0)
DBCC CHECKIDENT (HACTRANFURT, RESEED,0)
DBCC CHECKIDENT (HACTRANR, RESEED,0)
DBCC CHECKIDENT (HADM_S, RESEED,0)
DBCC CHECKIDENT (HCAAPD, RESEED,0)
DBCC CHECKIDENT (HCASER, RESEED,0)
DBCC CHECKIDENT (HCAV, RESEED,0)
DBCC CHECKIDENT (HCEN, RESEED,0)
DBCC CHECKIDENT (HEVEN, RESEED,0)
DBCC CHECKIDENT (KCHARTSD, RESEED,0)
DBCC CHECKIDENT (KCRYREPORTP, RESEED,0)
DBCC CHECKIDENT (KCRYREPORTU, RESEED,0)
DBCC CHECKIDENT (KLOG, RESEED,0)
DBCC CHECKIDENT (KLOG_NOMINA, RESEED,0)
DBCC CHECKIDENT (labo_imagen_winsislab, RESEED,0)
DBCC CHECKIDENT (LABO_INTER_WINSISLAB, RESEED,0)
DBCC CHECKIDENT (LABO_WINSISLAB, RESEED,0)
DBCC CHECKIDENT (MCH, RESEED,0)
DBCC CHECKIDENT (MCHE, RESEED,0)
DBCC CHECKIDENT (MCHNIIF, RESEED,0)
DBCC CHECKIDENT (MENUAPLI, RESEED,0)
DBCC CHECKIDENT (MPLDRES, RESEED,0)
DBCC CHECKIDENT (NCONDC, RESEED,0)
DBCC CHECKIDENT (NCONDD, RESEED,0)
DBCC CHECKIDENT (NCONDS, RESEED,0)
DBCC CHECKIDENT (NEDIA, RESEED,0)
DBCC CHECKIDENT (NEMPCK, RESEED,0)
DBCC CHECKIDENT (NEMPFD_RUN, RESEED,0)
DBCC CHECKIDENT (NEMPHIS, RESEED,0)
DBCC CHECKIDENT (NESIGVIT, RESEED,0)
DBCC CHECKIDENT (NIEPED, RESEED,0)
DBCC CHECKIDENT (NPERC, RESEED,0)
DBCC CHECKIDENT (NVACD, RESEED,0)
DBCC CHECKIDENT (PTEH, RESEED,0)
DBCC CHECKIDENT (RECEP, RESEED,0)
DBCC CHECKIDENT (RECEPD, RESEED,0)
DBCC CHECKIDENT (RESAFI4505, RESEED,0)
DBCC CHECKIDENT (RESCAMPOS, RESEED,0)
DBCC CHECKIDENT (RPAD, RESEED,0)
DBCC CHECKIDENT (RPDX, RESEED,0)
DBCC CHECKIDENT (RPDX2, RESEED,0)
DBCC CHECKIDENT (RPDX3, RESEED,0)
DBCC CHECKIDENT (RPEN, RESEED,0)
DBCC CHECKIDENT (RPHC, RESEED,0)
DBCC CHECKIDENT (RRIPS_AC, RESEED,0)
DBCC CHECKIDENT (RRIPS_AH, RESEED,0)
DBCC CHECKIDENT (RRIPS_AM, RESEED,0)
DBCC CHECKIDENT (RRIPS_AP, RESEED,0)
DBCC CHECKIDENT (RRIPS_AT, RESEED,0)
DBCC CHECKIDENT (RRIPS_AU, RESEED,0)
DBCC CHECKIDENT (RRIPS_CC, RESEED,0)
DBCC CHECKIDENT (RVRES, RESEED,0)
DBCC CHECKIDENT (sysdiagrams, RESEED,0)
DBCC CHECKIDENT (TLAB, RESEED,0)
DBCC CHECKIDENT (TUTE, RESEED,0)
DBCC CHECKIDENT (TUTEL, RESEED,0)
DBCC CHECKIDENT (TUTELD, RESEED,0)
DBCC CHECKIDENT (TUTELDO, RESEED,0)
DBCC CHECKIDENT (TUTELN, RESEED,0)
DBCC CHECKIDENT (queue_messages_1770358713, RESEED,0)
DBCC CHECKIDENT (queue_messages_1802358827, RESEED,0)
DBCC CHECKIDENT (queue_messages_1834358941, RESEED,0)
DBCC CHECKIDENT (sqlagent_job_history, RESEED,0)
DBCC CHECKIDENT (sqlagent_jobsteps_logs, RESEED,0)