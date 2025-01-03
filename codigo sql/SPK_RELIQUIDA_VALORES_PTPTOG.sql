IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'SPK_RELIQUIDA_VALORES_PTPTOG' AND TYPE = 'P')
BEGIN
   DROP PROCEDURE SPK_RELIQUIDA_VALORES_PTPTOG
END
GO
CREATE PROCEDURE DBO.SPK_RELIQUIDA_VALORES_PTPTOG 
@CONSECUTIVO  VARCHAR(20),  
@FECHAINICIAL DATETIME
WITH ENCRYPTION
AS  
DECLARE @EXISTE INT
BEGIN  
   ALTER TABLE PTPTOG DISABLE TRIGGER ALL

   ALTER TABLE PTCDPD DISABLE TRIGGER ALL
   UPDATE PTCDPD SET  RUBRO_ID=PTRUB.RUBRO_ID
   FROM PTCDPD INNER JOIN PTRUB ON PTCDPD.RUBRO=PTRUB.RUBRO AND PTCDPD.CLASE=PTRUB.CLASE AND PTCDPD.CONSECUTIVO=PTRUB.CONSECUTIVO
   WHERE COALESCE(PTCDPD.RUBRO_ID,0)<>PTRUB.RUBRO_ID
   ALTER TABLE PTCDPD ENABLE TRIGGER ALL

   ALTER TABLE PTRPD DISABLE TRIGGER ALL
   UPDATE PTRPD SET  RUBRO_ID=PTRUB.RUBRO_ID
   FROM PTRPD INNER JOIN PTRUB ON PTRPD.RUBRO=PTRUB.RUBRO AND PTRPD.CLASE=PTRUB.CLASE AND PTRPD.CONSECUTIVO=PTRUB.CONSECUTIVO
   WHERE COALESCE(PTRPD.RUBRO_ID,0)<>PTRUB.RUBRO_ID

   --UPDATE PTRPD SET ITEMCDPD=PTCDPD.ITEM
   --FROM PTRPD INNER JOIN PTCDPD ON PTRPD.CONSECUTIVO=PTCDPD.CONSECUTIVO
   --AND PTRPD.CDP=PTCDPD.CDP
   --AND PTCDPD.RUBRO=PTRPD.RUBRO
   --AND PTCDPD.RUBRO_ID=PTRPD.RUBRO_ID
   --WHERE PTRPD.CONSECUTIVO=@CONSECUTIVO
   --AND COALESCE(PTRPD.ITEMCDPD,0)=0
   --ALTER TABLE PTRPD ENABLE TRIGGER ALL

   ALTER TABLE PTCXPD DISABLE TRIGGER ALL
   UPDATE PTCXPD SET  RUBRO_ID=PTRUB.RUBRO_ID
   FROM PTCXPD INNER JOIN PTRUB ON PTCXPD.RUBRO=PTRUB.RUBRO AND PTCXPD.CLASE=PTRUB.CLASE AND PTCXPD.CONSECUTIVO=PTRUB.CONSECUTIVO
   WHERE COALESCE(PTCXPD.RUBRO_ID,0)<>PTRUB.RUBRO_ID

   UPDATE PTCXPD SET ITEMCDPD=PTRPD.ITEMCDPD
   FROM PTCXPD INNER JOIN PTRPD ON PTCXPD.CONSECUTIVO=PTRPD.CONSECUTIVO
   AND PTCXPD.CDP=PTRPD.CDP
   AND PTCXPD.RUBRO=PTRPD.RUBRO
   AND PTCXPD.RUBRO_ID=PTRPD.RUBRO_ID
   AND PTRPD.VALOR=PTCXPD.VALOR
   WHERE PTCXPD.CONSECUTIVO=@CONSECUTIVO
   AND PTRPD.ITEMCDPD<>PTCXPD.ITEMCDPD

   ALTER TABLE PTCXPD ENABLE TRIGGER ALL

   ALTER TABLE PTPAGD DISABLE TRIGGER ALL
   UPDATE PTPAGD SET  RUBRO_ID=PTRUB.RUBRO_ID
   FROM PTPAGD INNER JOIN PTRUB ON PTPAGD.RUBRO=PTRUB.RUBRO AND PTPAGD.CLASE=PTRUB.CLASE AND PTPAGD.CONSECUTIVO=PTRUB.CONSECUTIVO
   WHERE COALESCE(PTPAGD.RUBRO_ID,0)<>PTRUB.RUBRO_ID


   UPDATE PTPAGD SET ITEMCDPD=PTCXPD.ITEMCDPD
   FROM PTPAGD INNER JOIN PTCXPD ON PTPAGD.CONSECUTIVO=PTCXPD.CONSECUTIVO
   AND PTPAGD.CDP=PTCXPD.CDP
   AND PTPAGD.RUBRO=PTCXPD.RUBRO
   AND PTPAGD.RUBRO_ID=PTCXPD.RUBRO_ID
   AND PTPAGD.VALOR=PTCXPD.VALOR
   WHERE PTPAGD.CONSECUTIVO=@CONSECUTIVO
   AND PTPAGD.ITEMCDPD<>PTCXPD.ITEMCDPD


   ALTER TABLE PTPAGD ENABLE TRIGGER ALL


   UPDATE PTPTOG SET RUBRO_ID=PTRUB.RUBRO_ID
   FROM PTPTOG INNER JOIN PTRUB ON PTPTOG.RUBRO=PTRUB.RUBRO AND PTPTOG.CLASE=PTRUB.CLASE AND  PTPTOG.CONSECUTIVO=PTRUB.CONSECUTIVO
   WHERE COALESCE(PTPTOG.RUBRO_ID,0)<>PTRUB.RUBRO_ID


   SELECT RUBRO,
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=1  AND COALESCE(VIGENCIA,'Actual')='Actual'  THEN B.VALOR ELSE 0 END) CDP01,  
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=1  AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CDPA01,  
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=2  AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CDP02,  
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=2  AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CDPA02,  
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=3  AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CDP03,  
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=3  AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CDPA03,  
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=4  AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CDP04,  
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=4  AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CDPA04,  
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=5  AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CDP05,  
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=5  AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CDPA05,  
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=6  AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CDP06, 
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=6  AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CDPA06, 
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=7  AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CDP07, 
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=7  AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CDPA07, 
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=8  AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CDP08, 
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=8  AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CDPA08, 
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=9  AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CDP09, 
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=9  AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CDPA09, 
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=10 AND COALESCE(VIGENCIA,'Actual')='Actual'  THEN B.VALOR ELSE 0 END) CDP10, 
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=10 AND COALESCE(VIGENCIA,'Actual')='Anterior'  THEN B.VALOR ELSE 0 END) CDPA10, 
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=11 AND COALESCE(VIGENCIA,'Actual')='Actual'  THEN B.VALOR ELSE 0 END) CDP11, 
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=11 AND COALESCE(VIGENCIA,'Actual')='Anterior'  THEN B.VALOR ELSE 0 END) CDPA11, 
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=12 AND COALESCE(VIGENCIA,'Actual')='Actual'  THEN B.VALOR ELSE 0 END) CDP12, 
   SUM(CASE WHEN MONTH(A.FECHAEXPEDICION)=12 AND COALESCE(VIGENCIA,'Actual')='Anterior'  THEN B.VALOR ELSE 0 END) CDPA12 
   INTO #F
   FROM PTCDP A INNER JOIN PTCDPD B ON  A.CONSECUTIVO=B.CONSECUTIVO AND A.CDP=B.CDP 
   WHERE  A.CONSECUTIVO=@CONSECUTIVO AND A.ESTADO='Confirmado' AND  FECHAEXPEDICION>=@FECHAINICIAL
   GROUP BY RUBRO

   UPDATE PTPTOG SET 
   CDP01=COALESCE(A.CDP01,0),
   CDPA01=COALESCE(A.CDPA01,0),
   CDP02=COALESCE(A.CDP02,0),
   CDPA02=COALESCE(A.CDPA02,0),
   CDP03=COALESCE(A.CDP03,0),
   CDPA03=COALESCE(A.CDPA03,0),
   CDP04=COALESCE(A.CDP04,0),
   CDPA04=COALESCE(A.CDPA04,0),
   CDP05=COALESCE(A.CDP05,0),
   CDPA05=COALESCE(A.CDPA05,0),
   CDP06=COALESCE(A.CDP06,0),
   CDPA06=COALESCE(A.CDPA06,0),
   CDP07=COALESCE(A.CDP07,0),
   CDPA07=COALESCE(A.CDPA07,0),
   CDP08=COALESCE(A.CDP08,0),
   CDPA08=COALESCE(A.CDPA08,0),
   CDP09=COALESCE(A.CDP09,0),
   CDPA09=COALESCE(A.CDPA09,0),
   CDP10=COALESCE(A.CDP10,0),
   CDPA10=COALESCE(A.CDPA10,0),
   CDP11=COALESCE(A.CDP11,0),
   CDPA11=COALESCE(A.CDPA11,0),
   CDP12=COALESCE(A.CDP12,0),
   CDPA12=COALESCE(A.CDPA12,0)
   FROM PTPTOG LEFT JOIN #F  A ON PTPTOG.RUBRO=A.RUBRO
   WHERE PTPTOG.CONSECUTIVO=@CONSECUTIVO

   SELECT B.RUBRO,
   SUM(CASE WHEN MONTH(A.FECHARP)=1 AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) RP01,  
   SUM(CASE WHEN MONTH(A.FECHARP)=1 AND COALESCE(VIGENCIA,'Actual')='Anterior'THEN B.VALOR ELSE 0 END) RPA01,  
   SUM(CASE WHEN MONTH(A.FECHARP)=2 AND COALESCE(VIGENCIA,'Actual')='Actual'THEN B.VALOR ELSE 0 END) RP02,  
   SUM(CASE WHEN MONTH(A.FECHARP)=2 AND COALESCE(VIGENCIA,'Actual')='Anterior'THEN B.VALOR ELSE 0 END) RPA02,  
   SUM(CASE WHEN MONTH(A.FECHARP)=3 AND COALESCE(VIGENCIA,'Actual')='Actual'THEN B.VALOR ELSE 0 END) RP03,  
   SUM(CASE WHEN MONTH(A.FECHARP)=3 AND COALESCE(VIGENCIA,'Actual')='Anterior'THEN B.VALOR ELSE 0 END) RPA03,  
   SUM(CASE WHEN MONTH(A.FECHARP)=4 AND COALESCE(VIGENCIA,'Actual')='Actual'THEN B.VALOR ELSE 0 END) RP04,  
   SUM(CASE WHEN MONTH(A.FECHARP)=4 AND COALESCE(VIGENCIA,'Actual')='Anterior'THEN B.VALOR ELSE 0 END) RPA04,  
   SUM(CASE WHEN MONTH(A.FECHARP)=5 AND COALESCE(VIGENCIA,'Actual')='Actual'THEN B.VALOR ELSE 0 END) RP05,  
   SUM(CASE WHEN MONTH(A.FECHARP)=5 AND COALESCE(VIGENCIA,'Actual')='Anterior'THEN B.VALOR ELSE 0 END) RPA05,  
   SUM(CASE WHEN MONTH(A.FECHARP)=6 AND COALESCE(VIGENCIA,'Actual')='Actual'THEN B.VALOR ELSE 0 END) RP06, 
   SUM(CASE WHEN MONTH(A.FECHARP)=6 AND COALESCE(VIGENCIA,'Actual')='Anterior'THEN B.VALOR ELSE 0 END) RPA06, 
   SUM(CASE WHEN MONTH(A.FECHARP)=7 AND COALESCE(VIGENCIA,'Actual')='Actual'THEN B.VALOR ELSE 0 END) RP07, 
   SUM(CASE WHEN MONTH(A.FECHARP)=7 AND COALESCE(VIGENCIA,'Actual')='Anterior'THEN B.VALOR ELSE 0 END) RPA07, 
   SUM(CASE WHEN MONTH(A.FECHARP)=8 AND COALESCE(VIGENCIA,'Actual')='Actual'THEN B.VALOR ELSE 0 END) RP08, 
   SUM(CASE WHEN MONTH(A.FECHARP)=8 AND COALESCE(VIGENCIA,'Actual')='Anterior'THEN B.VALOR ELSE 0 END) RPA08, 
   SUM(CASE WHEN MONTH(A.FECHARP)=9 AND COALESCE(VIGENCIA,'Actual')='Actual'THEN B.VALOR ELSE 0 END) RP09, 
   SUM(CASE WHEN MONTH(A.FECHARP)=9 AND COALESCE(VIGENCIA,'Actual')='Anterior'THEN B.VALOR ELSE 0 END) RPA09, 
   SUM(CASE WHEN MONTH(A.FECHARP)=10 AND COALESCE(VIGENCIA,'Actual')='Actual'THEN B.VALOR ELSE 0 END) RP10, 
   SUM(CASE WHEN MONTH(A.FECHARP)=10 AND COALESCE(VIGENCIA,'Actual')='Anterior'THEN B.VALOR ELSE 0 END) RPA10, 
   SUM(CASE WHEN MONTH(A.FECHARP)=11 AND COALESCE(VIGENCIA,'Actual')='Actual'THEN B.VALOR ELSE 0 END) RP11, 
   SUM(CASE WHEN MONTH(A.FECHARP)=11 AND COALESCE(VIGENCIA,'Actual')='Anterior'THEN B.VALOR ELSE 0 END) RPA11, 
   SUM(CASE WHEN MONTH(A.FECHARP)=12 AND COALESCE(VIGENCIA,'Actual')='Actual'THEN B.VALOR ELSE 0 END) RP12, 
   SUM(CASE WHEN MONTH(A.FECHARP)=12 AND COALESCE(VIGENCIA,'Actual')='Anterior'THEN B.VALOR ELSE 0 END) RPA12 
   INTO #G
   FROM PTRP A INNER JOIN PTRPD B  ON A.CONSECUTIVO=B.CONSECUTIVO AND A.CDP=B.CDP AND A.RP=B.RP
               LEFT JOIN PTCDPD C ON B.CONSECUTIVO=C.CONSECUTIVO AND B.CDP=C.CDP AND B.RUBRO=C.RUBRO AND B.ITEMCDPD=C.ITEM AND B.RUBRO_ID=C.RUBRO_ID
   WHERE  A.CONSECUTIVO=@CONSECUTIVO AND A.ESTADO='Confirmado' AND  FECHARP>=@FECHAINICIAL
   GROUP BY B.RUBRO

   UPDATE PTPTOG
   SET 
   RP01=COALESCE(A.RP01,0),
   RPA01=COALESCE(A.RPA01,0),
   RP02=COALESCE(A.RP02,0),
   RPA02=COALESCE(A.RPA02,0),
   RP03=COALESCE(A.RP03,0),
   RPA03=COALESCE(A.RPA03,0),
   RP04=COALESCE(A.RP04,0),
   RPA04=COALESCE(A.RPA04,0),
   RP05=COALESCE(A.RP05,0),
   RPA05=COALESCE(A.RPA05,0),
   RP06=COALESCE(A.RP06,0),
   RPA06=COALESCE(A.RPA06,0),
   RP07=COALESCE(A.RP07,0),
   RPA07=COALESCE(A.RPA07,0),
   RP08=COALESCE(A.RP08,0),
   RPA08=COALESCE(A.RPA08,0),
   RP09=COALESCE(A.RP09,0),
   RPA09=COALESCE(A.RPA09,0),
   RP10=COALESCE(A.RP10,0),
   RPA10=COALESCE(A.RPA10,0),
   RP11=COALESCE(A.RP11,0),
   RPA11=COALESCE(A.RPA11,0),
   RP12=COALESCE(A.RP12,0),
   RPA12=COALESCE(A.RPA12,0)
   FROM PTPTOG LEFT JOIN #G  A ON PTPTOG.RUBRO=A.RUBRO
   WHERE PTPTOG.CONSECUTIVO=@CONSECUTIVO


   SELECT B.RUBRO,
   SUM(CASE WHEN MONTH(A.FECHA)=1 AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CXP01,  
   SUM(CASE WHEN MONTH(A.FECHA)=1 AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CXPA01,  
   SUM(CASE WHEN MONTH(A.FECHA)=2 AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CXP02,  
   SUM(CASE WHEN MONTH(A.FECHA)=2 AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CXPA02,  
   SUM(CASE WHEN MONTH(A.FECHA)=3 AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CXP03,  
   SUM(CASE WHEN MONTH(A.FECHA)=3 AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CXPA03,  
   SUM(CASE WHEN MONTH(A.FECHA)=4 AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CXP04,  
   SUM(CASE WHEN MONTH(A.FECHA)=4 AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CXPA04,  
   SUM(CASE WHEN MONTH(A.FECHA)=5 AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CXP05,  
   SUM(CASE WHEN MONTH(A.FECHA)=5 AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CXPA05,  
   SUM(CASE WHEN MONTH(A.FECHA)=6 AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CXP06, 
   SUM(CASE WHEN MONTH(A.FECHA)=6 AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CXPA06, 
   SUM(CASE WHEN MONTH(A.FECHA)=7 AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CXP07, 
   SUM(CASE WHEN MONTH(A.FECHA)=7 AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CXPA07, 
   SUM(CASE WHEN MONTH(A.FECHA)=8 AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CXP08, 
   SUM(CASE WHEN MONTH(A.FECHA)=8 AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CXPA08, 
   SUM(CASE WHEN MONTH(A.FECHA)=9 AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CXP09, 
   SUM(CASE WHEN MONTH(A.FECHA)=9 AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CXPA09, 
   SUM(CASE WHEN MONTH(A.FECHA)=10 AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CXP10, 
   SUM(CASE WHEN MONTH(A.FECHA)=10 AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CXPA10, 
   SUM(CASE WHEN MONTH(A.FECHA)=11 AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CXP11, 
   SUM(CASE WHEN MONTH(A.FECHA)=11 AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CXPA11, 
   SUM(CASE WHEN MONTH(A.FECHA)=12 AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) CXP12,
   SUM(CASE WHEN MONTH(A.FECHA)=12 AND COALESCE(VIGENCIA,'Actual')='Anterior' THEN B.VALOR ELSE 0 END) CXPA12
   INTO #H
   FROM PTCXP A INNER JOIN PTCXPD B ON  A.CONSECUTIVO=B.CONSECUTIVO AND A.CDP=B.CDP  AND A.RP=B.RP AND A.CNSCXP=B.CNSCXP
                LEFT JOIN PTCDPD C ON B.CONSECUTIVO=C.CONSECUTIVO AND B.CDP=C.CDP AND B.RUBRO=C.RUBRO AND B.ITEMCDPD=C.ITEM AND B.RUBRO_ID=C.RUBRO_ID
   WHERE  A.CONSECUTIVO=@CONSECUTIVO AND A.ESTADO='Confirmado' AND  FECHA>=@CONSECUTIVO
   GROUP BY B.RUBRO

   UPDATE PTPTOG
   SET 
   CXP01=COALESCE(A.CXP01,0),
   CXPA01=COALESCE(A.CXPA01,0),
   CXP02=COALESCE(A.CXP02,0),
   CXPA02=COALESCE(A.CXPA02,0),
   CXP03=COALESCE(A.CXP03,0),
   CXPA03=COALESCE(A.CXPA03,0),
   CXP04=COALESCE(A.CXP04,0),
   CXPA04=COALESCE(A.CXPA04,0),
   CXP05=COALESCE(A.CXP05,0),
   CXPA05=COALESCE(A.CXPA05,0),
   CXP06=COALESCE(A.CXP06,0),
   CXPA06=COALESCE(A.CXPA06,0),
   CXP07=COALESCE(A.CXP07,0),
   CXPA07=COALESCE(A.CXPA07,0),
   CXP08=COALESCE(A.CXP08,0),
   CXPA08=COALESCE(A.CXPA08,0),
   CXP09=COALESCE(A.CXP09,0),
   CXPA09=COALESCE(A.CXPA09,0),
   CXP10=COALESCE(A.CXP10,0),
   CXPA10=COALESCE(A.CXPA10,0),
   CXP11=COALESCE(A.CXP11,0),
   CXPA11=COALESCE(A.CXPA11,0),
   CXP12=COALESCE(A.CXP12,0),
   CXPA12=COALESCE(A.CXPA12,0)
   FROM PTPTOG LEFT JOIN #H  A ON PTPTOG.RUBRO=A.RUBRO
   WHERE PTPTOG.CONSECUTIVO=@CONSECUTIVO

   SELECT B.RUBRO,
   SUM(CASE WHEN MONTH(A.FECHA)=1 AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) PAG01,  
   SUM(CASE WHEN MONTH(A.FECHA)=1 AND COALESCE(VIGENCIA,'Actual')='Anterior'  THEN B.VALOR ELSE 0 END) PAGA01,  
   SUM(CASE WHEN MONTH(A.FECHA)=2 AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) PAG02,  
   SUM(CASE WHEN MONTH(A.FECHA)=2 AND COALESCE(VIGENCIA,'Actual')='Anterior'  THEN B.VALOR ELSE 0 END) PAGA02,  
   SUM(CASE WHEN MONTH(A.FECHA)=3 AND COALESCE(VIGENCIA,'Actual')='Actual' THEN B.VALOR ELSE 0 END) PAG03,  
   SUM(CASE WHEN MONTH(A.FECHA)=3 AND COALESCE(VIGENCIA,'Actual')='Anterior'  THEN B.VALOR ELSE 0 END) PAGA03,  
   SUM(CASE WHEN MONTH(A.FECHA)=4 AND COALESCE(VIGENCIA,'Actual')='Actual'  THEN B.VALOR ELSE 0 END) PAG04,  
   SUM(CASE WHEN MONTH(A.FECHA)=4 AND COALESCE(VIGENCIA,'Actual')='Anterior'  THEN B.VALOR ELSE 0 END) PAGA04,  
   SUM(CASE WHEN MONTH(A.FECHA)=5 AND COALESCE(VIGENCIA,'Actual')='Actual'  THEN B.VALOR ELSE 0 END) PAG05,  
   SUM(CASE WHEN MONTH(A.FECHA)=5 AND COALESCE(VIGENCIA,'Actual')='Anterior'  THEN B.VALOR ELSE 0 END) PAGA05,  
   SUM(CASE WHEN MONTH(A.FECHA)=6 AND COALESCE(VIGENCIA,'Actual')='Actual'  THEN B.VALOR ELSE 0 END) PAG06, 
   SUM(CASE WHEN MONTH(A.FECHA)=6 AND COALESCE(VIGENCIA,'Actual')='Anterior'  THEN B.VALOR ELSE 0 END) PAGA06, 
   SUM(CASE WHEN MONTH(A.FECHA)=7 AND COALESCE(VIGENCIA,'Actual')='Actual'  THEN B.VALOR ELSE 0 END) PAG07, 
   SUM(CASE WHEN MONTH(A.FECHA)=7 AND COALESCE(VIGENCIA,'Actual')='Anterior'  THEN B.VALOR ELSE 0 END) PAGA07, 
   SUM(CASE WHEN MONTH(A.FECHA)=8 AND COALESCE(VIGENCIA,'Actual')='Actual'  THEN B.VALOR ELSE 0 END) PAG08, 
   SUM(CASE WHEN MONTH(A.FECHA)=8 AND COALESCE(VIGENCIA,'Actual')='Anterior'  THEN B.VALOR ELSE 0 END) PAGA08, 
   SUM(CASE WHEN MONTH(A.FECHA)=9 AND COALESCE(VIGENCIA,'Actual')='Actual'  THEN B.VALOR ELSE 0 END) PAG09, 
   SUM(CASE WHEN MONTH(A.FECHA)=9 AND COALESCE(VIGENCIA,'Actual')='Anterior'  THEN B.VALOR ELSE 0 END) PAGA09, 
   SUM(CASE WHEN MONTH(A.FECHA)=10 AND COALESCE(VIGENCIA,'Actual')='Actual'  THEN B.VALOR ELSE 0 END) PAG10, 
   SUM(CASE WHEN MONTH(A.FECHA)=10 AND COALESCE(VIGENCIA,'Actual')='Anterior'  THEN B.VALOR ELSE 0 END) PAGA10, 
   SUM(CASE WHEN MONTH(A.FECHA)=11 AND COALESCE(VIGENCIA,'Actual')='Actual'  THEN B.VALOR ELSE 0 END) PAG11, 
   SUM(CASE WHEN MONTH(A.FECHA)=11 AND COALESCE(VIGENCIA,'Actual')='Anterior'  THEN B.VALOR ELSE 0 END) PAGA11,  
   SUM(CASE WHEN MONTH(A.FECHA)=12 AND COALESCE(VIGENCIA,'Actual')='Actual'  THEN B.VALOR ELSE 0 END) PAG12,
   SUM(CASE WHEN MONTH(A.FECHA)=12 AND COALESCE(VIGENCIA,'Actual')='Anterior'  THEN B.VALOR ELSE 0 END) PAGA12
   INTO #J
   FROM PTPAG A INNER JOIN PTPAGD B ON  A.CONSECUTIVO=B.CONSECUTIVO AND A.CDP=B.CDP  AND A.RP=B.RP AND A.CNSCXP=B.CNSCXP AND A.CNSPAGO=B.CNSPAGO
                LEFT JOIN PTCDPD C ON B.CONSECUTIVO=C.CONSECUTIVO AND B.CDP=C.CDP AND B.RUBRO=C.RUBRO AND B.ITEMCDPD=C.ITEM AND B.RUBRO_ID=C.RUBRO_ID
   WHERE  A.CONSECUTIVO=@CONSECUTIVO AND A.ESTADO='Confirmado' AND  FECHA>=@CONSECUTIVO
   GROUP BY B.RUBRO

   UPDATE PTPTOG
   SET 
   PAG01=COALESCE(A.PAG01,0),
   PAGA01=COALESCE(A.PAGA01,0),
   PAG02=COALESCE(A.PAG02,0),
   PAGA02=COALESCE(A.PAGA02,0),
   PAG03=COALESCE(A.PAG03,0),
   PAGA03=COALESCE(A.PAGA03,0),
   PAG04=COALESCE(A.PAG04,0),
   PAGA04=COALESCE(A.PAGA04,0),
   PAG05=COALESCE(A.PAG05,0),
   PAGA05=COALESCE(A.PAGA05,0),
   PAG06=COALESCE(A.PAG06,0),
   PAGA06=COALESCE(A.PAGA06,0),
   PAG07=COALESCE(A.PAG07,0),
   PAGA07=COALESCE(A.PAGA07,0),
   PAG08=COALESCE(A.PAG08,0),
   PAGA08=COALESCE(A.PAGA08,0),
   PAG09=COALESCE(A.PAG09,0),
   PAGA09=COALESCE(A.PAGA09,0),
   PAG10=COALESCE(A.PAG10,0),
   PAGA10=COALESCE(A.PAGA10,0),
   PAG11=COALESCE(A.PAG11,0),
   PAGA11=COALESCE(A.PAGA11,0),
   PAG12=COALESCE(A.PAG12,0),
   PAGA12=COALESCE(A.PAGA12,0)
   FROM PTPTOG LEFT JOIN #J  A ON PTPTOG.RUBRO=A.RUBRO
   WHERE PTPTOG.CONSECUTIVO=@CONSECUTIVO

   SELECT RUBRO,
   SUM(CASE WHEN MONTH(A.FECHA)=1 THEN A.VALOR ELSE 0 END) CDPR01,  
   SUM(CASE WHEN MONTH(A.FECHA)=2 THEN A.VALOR ELSE 0 END) CDPR02,  
   SUM(CASE WHEN MONTH(A.FECHA)=3 THEN A.VALOR ELSE 0 END) CDPR03,  
   SUM(CASE WHEN MONTH(A.FECHA)=4 THEN A.VALOR ELSE 0 END) CDPR04,  
   SUM(CASE WHEN MONTH(A.FECHA)=5 THEN A.VALOR ELSE 0 END) CDPR05,  
   SUM(CASE WHEN MONTH(A.FECHA)=6 THEN A.VALOR ELSE 0 END) CDPR06, 
   SUM(CASE WHEN MONTH(A.FECHA)=7 THEN A.VALOR ELSE 0 END) CDPR07, 
   SUM(CASE WHEN MONTH(A.FECHA)=8 THEN A.VALOR ELSE 0 END) CDPR08,
   SUM(CASE WHEN MONTH(A.FECHA)=9 THEN A.VALOR ELSE 0 END) CDPR09,
   SUM(CASE WHEN MONTH(A.FECHA)=10 THEN A.VALOR ELSE 0 END) CDPR10,
   SUM(CASE WHEN MONTH(A.FECHA)=11 THEN A.VALOR ELSE 0 END) CDPR11,
   SUM(CASE WHEN MONTH(A.FECHA)=12 THEN A.VALOR ELSE 0 END) CDPR12,
   SUM(CASE WHEN MONTH(A.FECHA)=1 AND PROCEDENCIA='PTRP' THEN A.VALOR ELSE 0 END) PTRES01,  
   SUM(CASE WHEN MONTH(A.FECHA)=2 AND PROCEDENCIA='PTRP' THEN A.VALOR ELSE 0 END) PTRES02,  
   SUM(CASE WHEN MONTH(A.FECHA)=3 AND PROCEDENCIA='PTRP' THEN A.VALOR ELSE 0 END) PTRES03,  
   SUM(CASE WHEN MONTH(A.FECHA)=4 AND PROCEDENCIA='PTRP' THEN A.VALOR ELSE 0 END) PTRES04,  
   SUM(CASE WHEN MONTH(A.FECHA)=5 AND PROCEDENCIA='PTRP' THEN A.VALOR ELSE 0 END) PTRES05,  
   SUM(CASE WHEN MONTH(A.FECHA)=6 AND PROCEDENCIA='PTRP' THEN A.VALOR ELSE 0 END) PTRES06, 
   SUM(CASE WHEN MONTH(A.FECHA)=7 AND PROCEDENCIA='PTRP' THEN A.VALOR ELSE 0 END) PTRES07, 
   SUM(CASE WHEN MONTH(A.FECHA)=8 AND PROCEDENCIA='PTRP' THEN A.VALOR ELSE 0 END) PTRES08,
   SUM(CASE WHEN MONTH(A.FECHA)=9 AND PROCEDENCIA='PTRP' THEN A.VALOR ELSE 0 END) PTRES09,
   SUM(CASE WHEN MONTH(A.FECHA)=10 AND PROCEDENCIA='PTRP' THEN A.VALOR ELSE 0 END) PTRES10,
   SUM(CASE WHEN MONTH(A.FECHA)=11 AND PROCEDENCIA='PTRP' THEN A.VALOR ELSE 0 END) PTRES11,
   SUM(CASE WHEN MONTH(A.FECHA)=12 AND PROCEDENCIA='PTRP' THEN A.VALOR ELSE 0 END) PTRES12
   INTO #I
   FROM PTCDPDR A
   WHERE CONSECUTIVO=@CONSECUTIVO
   GROUP BY RUBRO

   UPDATE PTPTOG
   SET 
   CDPR01=COALESCE(A.CDPR01,0),
   CDPR02=COALESCE(A.CDPR02,0),
   CDPR03=COALESCE(A.CDPR03,0),
   CDPR04=COALESCE(A.CDPR04,0),
   CDPR05=COALESCE(A.CDPR05,0),
   CDPR06=COALESCE(A.CDPR06,0),
   CDPR07=COALESCE(A.CDPR07,0),
   CDPR08=COALESCE(A.CDPR08,0),
   CDPR09=COALESCE(A.CDPR09,0),
   CDPR10=COALESCE(A.CDPR10,0),
   CDPR11=COALESCE(A.CDPR11,0),
   CDPR12=COALESCE(A.CDPR12,0),
   PTRES01=COALESCE(A.PTRES01,0),
   PTRES02=COALESCE(A.PTRES02,0),
   PTRES03=COALESCE(A.PTRES03,0),
   PTRES04=COALESCE(A.PTRES04,0),
   PTRES05=COALESCE(A.PTRES05,0),
   PTRES06=COALESCE(A.PTRES06,0),
   PTRES07=COALESCE(A.PTRES07,0),
   PTRES08=COALESCE(A.PTRES08,0),
   PTRES09=COALESCE(A.PTRES09,0),
   PTRES10=COALESCE(A.PTRES10,0),
   PTRES11=COALESCE(A.PTRES11,0),
   PTRES12=COALESCE(A.PTRES12,0)
   FROM PTPTOG LEFT JOIN #I  A ON PTPTOG.RUBRO=A.RUBRO
   WHERE PTPTOG.CONSECUTIVO=@CONSECUTIVO


   DROP TABLE #F
   DROP TABLE #G
   DROP TABLE #H
   DROP TABLE #I
   DROP TABLE #J

   ALTER TABLE PTCDP ENABLE TRIGGER ALL
   ALTER TABLE PTCDPD ENABLE TRIGGER ALL
   ALTER TABLE PTCDPDR ENABLE TRIGGER ALL
   ALTER TABLE PTCRP ENABLE TRIGGER ALL
   ALTER TABLE PTCRPD ENABLE TRIGGER ALL
   ALTER TABLE PTCXP ENABLE TRIGGER ALL
   ALTER TABLE PTCXPD ENABLE TRIGGER ALL
   ALTER TABLE PTPAG ENABLE TRIGGER ALL
   ALTER TABLE PTPAGD ENABLE TRIGGER ALL


   ALTER TABLE PTPTOG ENABLE TRIGGER ALL

END
