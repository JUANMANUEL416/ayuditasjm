

SELECT A.COMPANIA, A.CONSECUTIVO,A.CDP,A.PTRP,A.PTCXP,A.ITEM,A.PROCEDENCIA, 
            A.ESTADO,A.VALOR,A.CLASE,A.RUBRO,B.NOMRUBRO,A.VALOR, 
            A.OBJETIVO
FROM PTCDPDR A INNER JOIN PTRUB B ON A.CONSECUTIVO=B.CONSECUTIVO AND A.RUBRO=B.RUBRO
WHERE A.CONSECUTIVO='2023'