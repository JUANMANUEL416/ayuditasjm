SELECT ANO, MES, COUNT(*)
FROM   SALDOMESTERFAC
GROUP BY ANO, MES
ORDER BY ANO, MES

UPDATE SALDOMESTERFAC SET SALDOMESTERFAC.SI_DB = X.SI_DB, 
                          SALDOMESTERFAC.SI_CR = X.SI_CR, 
                          SALDOMESTERFAC.SF_DB = X.SF_DB, 
                          SALDOMESTERFAC.SF_CR = X.SF_CR
FROM   SALDOMESTERFAC INNER JOIN KCIELD1011..SALDOMESTERFAC X ON SALDOMESTERFAC.ANO COLLATE DATABASE_DEFAULT = X.ANO COLLATE DATABASE_DEFAULT
                                                             AND SALDOMESTERFAC.MES = X.MES
                                                             AND SALDOMESTERFAC.CUENTA COLLATE DATABASE_DEFAULT = X.CUENTA COLLATE DATABASE_DEFAULT
                                                             AND COALESCE(SALDOMESTERFAC.IDTERCERO,'') COLLATE DATABASE_DEFAULT = COALESCE(X.IDTERCERO,'') COLLATE DATABASE_DEFAULT
                                                             AND COALESCE(SALDOMESTERFAC.CCOSTO,'') COLLATE DATABASE_DEFAULT = COALESCE(X.CCOSTO,'') COLLATE DATABASE_DEFAULT
                                                             AND COALESCE(SALDOMESTERFAC.N_FACTURA,'') COLLATE DATABASE_DEFAULT = COALESCE(X.N_FACTURA,'') COLLATE DATABASE_DEFAULT
WHERE  SALDOMESTERFAC.ANO = '2012'
AND    SALDOMESTERFAC.MES = 12
AND    X.ANO = '2012'
AND    X.MES = 12

UPDATE SALDOMESTERFAC SET SI_DB = 0, SI_CR = 0, SF_DB = 0, SF_CR = 0
WHERE  ANO = '2010'
AND    MES = 8

UPDATE SALDOMESTERFAC SET SF_DB = CASE NTZ.TIPO WHEN 'DB' 
                                                THEN CASE WHEN (COALESCE(SALDOMESTERFAC.SI_DB,0) - COALESCE(SALDOMESTERFAC.SI_CR,0) + SALDOMESTERFAC.DB - SALDOMESTERFAC.CR) >= 0 
                                                          THEN  COALESCE(SALDOMESTERFAC.SI_DB,0) - COALESCE(SALDOMESTERFAC.SI_CR,0) + SALDOMESTERFAC.DB - SALDOMESTERFAC.CR
                                                          ELSE 0
                                                     END  
                                                ELSE CASE WHEN (COALESCE(SALDOMESTERFAC.SI_CR,0) - COALESCE(SALDOMESTERFAC.SI_DB,0) + SALDOMESTERFAC.CR - SALDOMESTERFAC.DB) >= 0 
                                                          THEN 0
                                                          ELSE ABS(COALESCE(SALDOMESTERFAC.SI_CR,0) - COALESCE(SALDOMESTERFAC.SI_DB,0) + SALDOMESTERFAC.CR - SALDOMESTERFAC.DB)
                                                     END
                                  END,
                          SF_CR = CASE NTZ.TIPO WHEN 'CR' 
                                                THEN CASE WHEN (COALESCE(SALDOMESTERFAC.SI_CR,0) - COALESCE(SALDOMESTERFAC.SI_DB,0) + SALDOMESTERFAC.CR - SALDOMESTERFAC.DB) >= 0 
                                                          THEN COALESCE(SALDOMESTERFAC.SI_CR,0) - COALESCE(SALDOMESTERFAC.SI_DB,0) + SALDOMESTERFAC.CR - SALDOMESTERFAC.DB
                                                          ELSE 0
                                                     END
                                                ELSE CASE WHEN (COALESCE(SALDOMESTERFAC.SI_DB,0) - COALESCE(SALDOMESTERFAC.SI_CR,0) + SALDOMESTERFAC.DB - SALDOMESTERFAC.CR) >= 0 
                                                          THEN  0
                                                          ELSE ABS(COALESCE(SALDOMESTERFAC.SI_DB,0) - COALESCE(SALDOMESTERFAC.SI_CR,0) + SALDOMESTERFAC.DB - SALDOMESTERFAC.CR)
                                                     END   
                                  END
FROM   SALDOMESTERFAC INNER JOIN NTZ ON LEFT(SALDOMESTERFAC.CUENTA,1) = NTZ.N_INICIAL
WHERE  ANO = '2014'
AND    MES = 6


UPDATE SALDOMESTERFAC SET SI_DB = X.SF_DB, SI_CR = X.SF_CR
FROM   SALDOMESTERFAC INNER JOIN SALDOMESTERFAC X ON SALDOMESTERFAC.CUENTA                  = X.CUENTA 
                                                 AND COALESCE(SALDOMESTERFAC.IDTERCERO,'')  = COALESCE(X.IDTERCERO,'') 
                                                 AND COALESCE(SALDOMESTERFAC.CCOSTO,'')     = COALESCE(X.CCOSTO,'')
                                                 AND COALESCE(SALDOMESTERFAC.N_FACTURA,'')  = COALESCE(X.N_FACTURA,'')
                                                 AND    X.ANO = '2014'
                                                 AND    X.MES = 5
WHERE  SALDOMESTERFAC.ANO = '2014'
AND    SALDOMESTERFAC.MES = 6



SELECT * FROM SALDOMESTERFAC