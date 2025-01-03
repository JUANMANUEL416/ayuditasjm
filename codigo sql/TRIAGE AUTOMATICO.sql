

SELECT  * FROM HTRIAGE INNER JOIN HADM ON HTRIAGE.IDAFILIADO=HADM.IDAFILIADO AND DBO.FNK_FECHA(HTRIAGE.FECHA)=DBO.FNK_FECHA(HADM.FECHA)
WHERE COALESCE(HADM.TTRIAGE,0)=0
AND COALESCE(HADM.CNSTRIAGE,'')=''
AND DBO.FNK_FECHA(HADM.FECHA)=DBO.FNK_FECHA(GETDATE())


UPDATE HADM SET TTRIAGE=1, CNSTRIAGE=HTRIAGE.CNSTRIAGE
FROM HTRIAGE INNER JOIN HADM ON HTRIAGE.IDAFILIADO=HADM.IDAFILIADO AND DBO.FNK_FECHA(HTRIAGE.FECHA)=DBO.FNK_FECHA(HADM.FECHA)
WHERE COALESCE(HADM.TTRIAGE,0)=0
AND COALESCE(HADM.CNSTRIAGE,'')=''
AND DBO.FNK_FECHA(HADM.FECHA)=DBO.FNK_FECHA(GETDATE())


UPDATE HTRIAGE SET ATENDIDO=1
FROM HTRIAGE INNER JOIN HADM ON HTRIAGE.CNSTRIAGE=HADM.CNSTRIAGE
WHERE HTRIAGE.ATENDIDO=2
AND HADM.TTRIAGE=1



