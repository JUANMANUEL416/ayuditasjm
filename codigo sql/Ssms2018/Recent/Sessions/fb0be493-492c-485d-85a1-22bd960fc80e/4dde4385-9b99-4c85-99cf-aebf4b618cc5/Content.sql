use KSUMUY

SELECT ITMO.TIPO,IMOV.IDTIPOMOV,ITMO.DESCRIPCION,IMOV.FECHAMOV,IMOV.FECHACONF,
IMOVH.* FROM IMOV INNER JOIN IMOVH  ON IMOV.CNSMOV=IMOVH.CNSMOV
            INNER JOIN ITMO   ON IMOV.IDTIPOMOV=ITMO.IDTIPOMOV  
WHERE IDARTICULO='R03BA02-1'
AND MONTH(FECHAMOV)=10
AND YEAR(FECHAMOV)=2024
AND IDBODEGA='11'
AND IMOV.ESTADO=1

