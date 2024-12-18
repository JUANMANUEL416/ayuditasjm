SELECT 'PTPTOG', RUBRO, CDP01,CDP02,CDP03,CDP04,CDP05,CDP06,CDP07,CDP08,CDP09,CDP10,CDP11,CDP12,SFCDP 
FROM PTPTOG 
WHERE  RUBRO=@RUBRO 
AND CONSECUTIVO=@CONSECUTIVO 
UNION ALL
SELECT 'PTCDP', B.RUBRO,
SUM(CASE WHEN  MONTH(A.FECHAEXPEDICION)=1 THEN  B.VALOR ELSE 0 END) '01',
SUM(CASE WHEN  MONTH(A.FECHAEXPEDICION)=2 THEN  B.VALOR ELSE 0 END) '02',
SUM(CASE WHEN  MONTH(A.FECHAEXPEDICION)=3 THEN  B.VALOR ELSE 0 END) '03',
SUM(CASE WHEN  MONTH(A.FECHAEXPEDICION)=4 THEN  B.VALOR ELSE 0 END) '04',
SUM(CASE WHEN  MONTH(A.FECHAEXPEDICION)=5 THEN  B.VALOR ELSE 0 END) '05',
SUM(CASE WHEN  MONTH(A.FECHAEXPEDICION)=6 THEN  B.VALOR ELSE 0 END) '06',
SUM(CASE WHEN  MONTH(A.FECHAEXPEDICION)=7 THEN  B.VALOR ELSE 0 END) '07',
SUM(CASE WHEN  MONTH(A.FECHAEXPEDICION)=8 THEN  B.VALOR ELSE 0 END) '08',
SUM(CASE WHEN  MONTH(A.FECHAEXPEDICION)=9 THEN  B.VALOR ELSE 0 END) '09',
SUM(CASE WHEN  MONTH(A.FECHAEXPEDICION)=10 THEN  B.VALOR ELSE 0 END) '10',
SUM(CASE WHEN  MONTH(A.FECHAEXPEDICION)=11 THEN  B.VALOR ELSE 0 END) '11',
SUM(CASE WHEN  MONTH(A.FECHAEXPEDICION)=12 THEN  B.VALOR ELSE 0 END) '12',
SUM(B.VALOR)
FROM PTCDP A INNER JOIN PTCDPD B ON A.CONSECUTIVO=B.CONSECUTIVO AND A.CDP=B.CDP 
WHERE A.ESTADO='Confirmado'
AND B.RUBRO=@RUBRO 
AND B.CONSECUTIVO=@CONSECUTIVO 
GROUP BY RUBRO
UNION ALL
SELECT 'LIBERA CDP', RUBRO,CDPR01,CDPR02,CDPR03,CDPR04,CDPR05,CDPR06,CDPR07,CDPR08,CDPR09,CDPR10,CDPR11,CDPR12,SFCDPR 
FROM PTPTOG WHERE CONSECUTIVO=@CONSECUTIVO  AND RUBRO=@RUBRO  
UNION ALL
SELECT 'PTPTOG', RUBRO, RP01,RP02,RP03,RP04,RP05,RP06,RP07,RP08,RP09,RP10,RP11,RP12,SFRP
FROM PTPTOG WHERE CONSECUTIVO=@CONSECUTIVO  AND RUBRO=@RUBRO 
UNION ALL
SELECT 'PTRP',B.RUBRO,
SUM(CASE WHEN  MONTH(A.FECHARP)=1 THEN  B.VALOR ELSE 0 END) '01',
SUM(CASE WHEN  MONTH(A.FECHARP)=2 THEN  B.VALOR ELSE 0 END) '02',
SUM(CASE WHEN  MONTH(A.FECHARP)=3 THEN  B.VALOR ELSE 0 END) '03',
SUM(CASE WHEN  MONTH(A.FECHARP)=4 THEN  B.VALOR ELSE 0 END) '04',
SUM(CASE WHEN  MONTH(A.FECHARP)=5 THEN  B.VALOR ELSE 0 END) '05',
SUM(CASE WHEN  MONTH(A.FECHARP)=6 THEN  B.VALOR ELSE 0 END) '06',
SUM(CASE WHEN  MONTH(A.FECHARP)=7 THEN  B.VALOR ELSE 0 END) '07',
SUM(CASE WHEN  MONTH(A.FECHARP)=8 THEN  B.VALOR ELSE 0 END) '08',
SUM(CASE WHEN  MONTH(A.FECHARP)=9 THEN  B.VALOR ELSE 0 END) '09',
SUM(CASE WHEN  MONTH(A.FECHARP)=10 THEN  B.VALOR ELSE 0 END) '10',
SUM(CASE WHEN  MONTH(A.FECHARP)=11 THEN  B.VALOR ELSE 0 END) '11',
SUM(CASE WHEN  MONTH(A.FECHARP)=12 THEN  B.VALOR ELSE 0 END) '12',
SUM(B.VALOR)
FROM PTRP A INNER JOIN PTRPD B ON A.CONSECUTIVO=B.CONSECUTIVO AND A.CDP=B.CDP AND A.RP=B.RP
WHERE A.ESTADO='Confirmado'
AND B.RUBRO=@RUBRO 
AND B.CONSECUTIVO=@CONSECUTIVO 
GROUP BY RUBRO 
UNION ALL
SELECT 'LIBERA RP', RUBRO,PTRES01,PTRES02,PTRES03,PTRES04,PTRES05,PTRES06,PTRES07,PTRES08,PTRES09,PTRES10,PTRES11,PTRES12,SFPTRES 
FROM PTPTOG WHERE CONSECUTIVO=@CONSECUTIVO 
AND RUBRO=@RUBRO 
UNION ALL
SELECT 'PTRP REST',A.RUBRO,
SUM(CASE WHEN  MONTH(A.FECHA)=1 THEN  A.VALOR ELSE 0 END) '01',
SUM(CASE WHEN  MONTH(A.FECHA)=2 THEN  A.VALOR ELSE 0 END) '02',
SUM(CASE WHEN  MONTH(A.FECHA)=3 THEN  A.VALOR ELSE 0 END) '03',
SUM(CASE WHEN  MONTH(A.FECHA)=4 THEN  A.VALOR ELSE 0 END) '04',
SUM(CASE WHEN  MONTH(A.FECHA)=5 THEN  A.VALOR ELSE 0 END) '05',
SUM(CASE WHEN  MONTH(A.FECHA)=6 THEN  A.VALOR ELSE 0 END) '06',
SUM(CASE WHEN  MONTH(A.FECHA)=7 THEN  A.VALOR ELSE 0 END) '07',
SUM(CASE WHEN  MONTH(A.FECHA)=8 THEN  A.VALOR ELSE 0 END) '08',
SUM(CASE WHEN  MONTH(A.FECHA)=9 THEN  A.VALOR ELSE 0 END) '09',
SUM(CASE WHEN  MONTH(A.FECHA)=10 THEN  A.VALOR ELSE 0 END) '10',
SUM(CASE WHEN  MONTH(A.FECHA)=11 THEN  A.VALOR ELSE 0 END) '11',
SUM(CASE WHEN  MONTH(A.FECHA)=12 THEN  A.VALOR ELSE 0 END) '12',
SUM(A.VALOR)
FROM PTCDPDR A
WHERE 
A.RUBRO=@RUBRO 
AND A.CONSECUTIVO=@CONSECUTIVO 
AND A.PROCEDENCIA='PTRP'
GROUP BY RUBRO
UNION ALL
SELECT 'LIBERA CDP', RUBRO,CDPR01,CDPR02,CDPR03,CDPR04,CDPR05,CDPR06,CDPR07,CDPR08,CDPR09,CDPR10,CDPR11,CDPR12,SFCDPR 
FROM PTPTOG WHERE CONSECUTIVO=@CONSECUTIVO  AND RUBRO=@RUBRO  
UNION ALL
SELECT 'PTRP',B.RUBRO,
SUM(CASE WHEN  MONTH(A.FECHARP)=1 THEN  B.VALOR ELSE 0 END) '01',
SUM(CASE WHEN  MONTH(A.FECHARP)=2 THEN  B.VALOR ELSE 0 END) '02',
SUM(CASE WHEN  MONTH(A.FECHARP)=3 THEN  B.VALOR ELSE 0 END) '03',
SUM(CASE WHEN  MONTH(A.FECHARP)=4 THEN  B.VALOR ELSE 0 END) '04',
SUM(CASE WHEN  MONTH(A.FECHARP)=5 THEN  B.VALOR ELSE 0 END) '05',
SUM(CASE WHEN  MONTH(A.FECHARP)=6 THEN  B.VALOR ELSE 0 END) '06',
SUM(CASE WHEN  MONTH(A.FECHARP)=7 THEN  B.VALOR ELSE 0 END) '07',
SUM(CASE WHEN  MONTH(A.FECHARP)=8 THEN  B.VALOR ELSE 0 END) '08',
SUM(CASE WHEN  MONTH(A.FECHARP)=9 THEN  B.VALOR ELSE 0 END) '09',
SUM(CASE WHEN  MONTH(A.FECHARP)=10 THEN  B.VALOR ELSE 0 END) '10',
SUM(CASE WHEN  MONTH(A.FECHARP)=11 THEN  B.VALOR ELSE 0 END) '11',
SUM(CASE WHEN  MONTH(A.FECHARP)=12 THEN  B.VALOR ELSE 0 END) '12',
SUM(B.VALOR)
FROM PTRP A INNER JOIN PTRPD B ON A.CONSECUTIVO=B.CONSECUTIVO AND A.CDP=B.CDP AND A.RP=B.RP
WHERE A.ESTADO='Confirmado'
AND B.RUBRO=@RUBRO 
AND B.CONSECUTIVO=@CONSECUTIVO 
GROUP BY RUBRO