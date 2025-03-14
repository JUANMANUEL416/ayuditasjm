

SELECT  * FROM CIT WHERE IDTERCEROCA='0100000007' AND COALESCE(IDAFILIADO,'')<>'' AND CUMPLIDA=1

UPDATE CIT SET VALORTOTAL=12500 WHERE IDTERCEROCA='0100000007' AND COALESCE(IDAFILIADO,'')<>'' AND CUMPLIDA=1

SELECT * FROM CIT A WHERE  0=(SELECT CAPITADO FROM PPT WHERE IDPLAN=A.IDPLAN AND IDTERCERO=A.IDTERCEROCA)   AND A.IDTERCEROCA ='0100000007'
AND ISNULL(A.ESTADO,'') <> 'Anulada' AND A.IDAFILIADO IS NOT NULL AND A.CUMPLIDA=1 AND A.IDSEDE='01' AND A.IDPLAN = 'SAT01C' AND COALESCE(VALORTOTAL,0)>0 AND COALESCE(FACTURABLE,0)=1  AND A.FECHA >= ' 1/10/2022' AND A.FECHA <' 1/12/2022' AND ISNULL(A.FACTURADA,0) IN (0,2) AND ISNULL(FACTURADA,0) IN (0,2)


SELECT  * FROM FMAS

SELECT  DBO.FNK_COLUMNAS_TABLAS('FMASD')

SELECT DISTINCT TIPOCOPAGO FROM CIT
SELECT DISTINCT AQUIENCOBRO FROM CIT

UPDATE CIT SET TIPOCOPAGO ='C' WHERE COALESCE(TIPOCOPAGO,'')=''

UPDATE CIT SET FECHAATENCION=DBO.FNK_FECHA_SIN_MLS(FECHAATENCION) WHERE DATEPART(MILLISECOND,FECHAATENCION)>0 --AND IDMEDICO<>'43972233'

SELECT  * FROM CIT WHERE IDMEDICO='43972233' AND FECHA>='11/11/2022' AND FECHA<'12/11/2022'

SELECT * FROM CIT WHERE DATEPART(MILLISECOND,FECHALLEGA)>0

SELECT  FECHA, * FROM CIT WHERE DATEPART(MILLISECOND,FECHA)>0 AND IDMEDICO='43972233' AND FECHA>='11/11/2022' AND FECHA<'12/11/2022'

SELECT CNSFINAL, CONVERT(VARCHAR(10),FECHAVEN,111), CNSRESOL,DATEDIFF(DAY,GETDATE(),FECHAVEN) FROM FDIAN WHERE IDENTIFICADOR = '01' AND CNSINICIAL<=1 AND CNSFINAL+1>1  AND VENCIDA = '0' AND PROCEDENCIA = 'FTR'

SELECT CNSFINAL, CONVERT(VARCHAR(10),FECHAVEN,111), CNSRESOL,DATEDIFF(DAY,GETDATE(),FECHAVEN) FROM FDIAN WHERE IDENTIFICADOR = '01' AND CNSINICIAL<=1 AND CNSFINAL+1>1  AND VENCIDA = '0' AND PROCEDENCIA = 'FTR'

BEGIN TRAN
EXEC SPK_FACTURACI_ESCIP_MASI '0100011731','JJIMENEZ','01','01','JJIMENEZ','0100000007','SAT02S', '','14/11/2022', '8903850002', 90000
ROLLBACK

SELECT  * FROM FTRD 

ROLLBACK

   SELECT DISTINCT(CIT.IDAFILIADO), AFI.NOMBREAFI
   FROM CIT
   LEFT JOIN TER ON CIT.IDTERCEROCA=TER.IDTERCERO
   INNER JOIN AFI ON AFI.IDAFILIADO=CIT.IDAFILIADO
   WHERE CIT.IDTERCEROCA = @IDTERCEROCA1 AND (CIT.FACTURADA = 0 OR CIT.FACTURADA IS NULL) AND CIT.MARCAFAC = 1 AND CIT.CNSFACT = @CNSRPDX
   AND   COALESCE(FACTURABLE,0)=1 
   AND   COALESCE(CIT.DESCUENTO,0)<CASE WHEN CIT.TIPODTO='P' THEN 100 ELSE CIT.VALORTOTAL END
   AND   (TER.IDTERCERO = (CASE WHEN @IDTERCEROCA1='' THEN TER.IDTERCERO ELSE @IDTERCEROCA1 END) OR
          (TER.IDTERCERO IS NULL AND @IDTERCEROCA1<>''))
   ORDER BY AFI.NOMBREAFI


   -- CAMPOS DE CIT QUE ESTAN QUEDANDO CON MILISEGUNDOS
   -- FECHA, FECHALLEGA,FECHAATENCION,FECHASOL
   -- POR FAVOR REALIZAR LOS CAMBIOS NECESARIOS, YA POR PARTE DE SOPORTE FUERON CORREGIDOS.

   UPDATE CIT SET FECHA=DBO.FNK_FECHA_SIN_MLS(FECHA) WHERE DATEPART(MILLISECOND,FECHA)>0
   UPDATE CIT SET FECHALLEGA=DBO.FNK_FECHA_SIN_MLS(FECHALLEGA) WHERE DATEPART(MILLISECOND,FECHALLEGA)>0
   UPDATE CIT SET FECHAATENCION=DBO.FNK_FECHA_SIN_MLS(FECHAATENCION) WHERE DATEPART(MILLISECOND,FECHAATENCION)>0
   UPDATE CIT SET FECHASOL=DBO.FNK_FECHA_SIN_MLS(FECHASOL) WHERE DATEPART(MILLISECOND,FECHASOL)>0

   UPDATE CIT SET TIPOCOPAGO ='C' WHERE COALESCE(TIPOCOPAGO,'')=''
   UPDATE CIT SET AQUIENCOBRO ='N' WHERE COALESCE(AQUIENCOBRO,'')=''
