DBCC INDEXDEFRAG (KCIELD, "DBO.HCA", HCA21)                  
DBCC INDEXDEFRAG (KCIELD, "DBO.HCA",HCACLASENOADMISION)      
DBCC INDEXDEFRAG (KCIELD, "DBO.HCA",HCACLASEPLANTILLA)       
DBCC INDEXDEFRAG (KCIELD, "DBO.HCA",HCACONSECUTIVO)          --ok
DBCC INDEXDEFRAG (KCIELD, "DBO.HCA",HCAIDAFILIADO)
DBCC INDEXDEFRAG (KCIELD, "DBO.HCA",HCAIDAFILIADOCON)
DBCC INDEXDEFRAG (KCIELD, "DBO.HCA",HCAIDAFILIADOFECHA)
DBCC INDEXDEFRAG (KCIELD, "DBO.HCA",HCAIDDX)
DBCC INDEXDEFRAG (KCIELD, "DBO.HCA",HCAIDMEDICOFECHA)
DBCC INDEXDEFRAG (KCIELD, "DBO.HCA",HCANOADMISION)
DBCC INDEXDEFRAG (KCIELD, "DBO.HCA",HCANOADMISIONCONSECUTIVO)
DBCC INDEXDEFRAG (KCIELD, "DBO.HCA",HCANOADMISIONPROCEDENCIA)
DBCC INDEXDEFRAG (KCIELD, "DBO.HCA",HCANOADMISIONPROCEDENCIACLASEFECHA)
DBCC INDEXDEFRAG (KCIELD, "DBO.HCA",HCAPROCEDENCIA)
DBCC INDEXDEFRAG (KCIELD, "DBO.HCA",HCAPROCEDENCIAIDAFILIADO)  --OK

DBCC INDEXDEFRAG (KCIELD, "DBO.HCAD", HCADCONSECUTIVO)
DBCC INDEXDEFRAG (KCIELD, "DBO.HCAD", HCADCLASEPLANTILLA)

DBCC INDEXDEFRAG (KCIELD, "DBO.HCADL")
DBCC INDEXDEFRAG (KCIELD, "DBO.HTX")

DBCC INDEXDEFRAG (KCIELD, "DBO.FTR", FTRCODPRG)
DBCC INDEXDEFRAG (KCIELD, "DBO.FTR", FTRCODUNG)
DBCC INDEXDEFRAG (KCIELD, "DBO.FTR", FTRF_FACTURA)
DBCC INDEXDEFRAG (KCIELD, "DBO.FTR", FTRIDTERCERO)
DBCC INDEXDEFRAG (KCIELD, "DBO.FTR", FTRLLAVE)
DBCC INDEXDEFRAG (KCIELD, "DBO.FTR", FTRLLAVE0)
DBCC INDEXDEFRAG (KCIELD, "DBO.FTR", FTRLLAVE1)
DBCC INDEXDEFRAG (KCIELD, "DBO.FTR", FTRN_FACTURA)
DBCC INDEXDEFRAG (KCIELD, "DBO.FTR", FTRNOREFERENCIA)

dbcc dbreindex(@nombre ,'',80)