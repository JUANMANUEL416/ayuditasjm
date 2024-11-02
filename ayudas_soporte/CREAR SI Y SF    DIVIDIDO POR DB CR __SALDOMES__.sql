--001
UPDATE SALDOMES SET SI_DB = 0, SI_CR = 0, SF_DB = 0, SF_CR = 0
UPDATE SALDOMESTERFAC SET SI_DB = 0, SI_CR = 0, SF_DB = 0, SF_CR = 0
--002
UPDATE SALDOMES SET SF_DB = CASE NTZ.TIPO WHEN 'DB' 
                                                THEN CASE WHEN (COALESCE(SALDOMES.SI_DB,0) - COALESCE(SALDOMES.SI_CR,0) + SALDOMES.DB - SALDOMES.CR) >= 0 
                                                          THEN  COALESCE(SALDOMES.SI_DB,0) - COALESCE(SALDOMES.SI_CR,0) + SALDOMES.DB - SALDOMES.CR
                                                          ELSE 0
                                                     END  
                                                ELSE CASE WHEN (COALESCE(SALDOMES.SI_CR,0) - COALESCE(SALDOMES.SI_DB,0) + SALDOMES.CR - SALDOMES.DB) >= 0 
                                                          THEN 0
                                                          ELSE ABS(COALESCE(SALDOMES.SI_CR,0) - COALESCE(SALDOMES.SI_DB,0) + SALDOMES.CR - SALDOMES.DB)
                                                     END
                                  END,
                          SF_CR = CASE NTZ.TIPO WHEN 'CR' 
                                                THEN CASE WHEN (COALESCE(SALDOMES.SI_CR,0) - COALESCE(SALDOMES.SI_DB,0) + SALDOMES.CR - SALDOMES.DB) >= 0 
                                                          THEN COALESCE(SALDOMES.SI_CR,0) - COALESCE(SALDOMES.SI_DB,0) + SALDOMES.CR - SALDOMES.DB
                                                          ELSE 0
                                                     END
                                                ELSE CASE WHEN (COALESCE(SALDOMES.SI_DB,0) - COALESCE(SALDOMES.SI_CR,0) + SALDOMES.DB - SALDOMES.CR) >= 0 
                                                          THEN  0
                                                          ELSE ABS(COALESCE(SALDOMES.SI_DB,0) - COALESCE(SALDOMES.SI_CR,0) + SALDOMES.DB - SALDOMES.CR)
                                                     END   
                                  END
FROM   SALDOMES INNER JOIN NTZ ON LEFT(SALDOMES.CUENTA,1) = NTZ.N_INICIAL
WHERE  ANO = '2008'
AND    MES = 12
--
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
WHERE  ANO = '2008'
AND    MES = 12
--003
UPDATE SALDOMES SET SI_DB = X.SF_DB, SI_CR = X.SF_CR
FROM   SALDOMES INNER JOIN SALDOMES X ON SALDOMES.CUENTA  = X.CUENTA 
                                                 AND    X.ANO = '2008'
                                                 AND    X.MES = 12
WHERE  SALDOMES.ANO = '2009'
AND    SALDOMES.MES = 1

UPDATE SALDOMESTERFAC SET SI_DB = X.SF_DB, SI_CR = X.SF_CR
FROM   SALDOMESTERFAC INNER JOIN SALDOMESTERFAC X ON SALDOMESTERFAC.CUENTA                  = X.CUENTA 
                                                 AND COALESCE(SALDOMESTERFAC.IDTERCERO,'')  = COALESCE(X.IDTERCERO,'') 
                                                 AND COALESCE(SALDOMESTERFAC.CCOSTO,'')     = COALESCE(X.CCOSTO,'')
                                                 AND COALESCE(SALDOMESTERFAC.N_FACTURA,'')  = COALESCE(X.N_FACTURA,'')
                                                 AND    X.ANO = '2008'
                                                 AND    X.MES = 12
WHERE  SALDOMESTERFAC.ANO = '2009'
AND    SALDOMESTERFAC.MES = 1
