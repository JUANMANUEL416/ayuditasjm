  RAISERROR ('No tiene configurado Departamento de Cartera',16,1)
  https://docs.google.com/spreadsheets/d/1_RHApSmDM7iYDfm98tS7me3xOSsng5tVkxdDGcBBgFs/edit#gid=0  --licencias nod32
   --CREAR VARIABLE
IF NOT EXISTS(SELECT * FROM USVGS WHERE IDVARIABLE='')
BEGIN   
   INSERT INTO USVGS (IDVARIABLE,DESCRIPCION,TP_VARIABLE,DATO)
   SELECT 'IDTERCONTABLETERC','Tipo de Tercero contable para Terceros Contratantes','Alfanumerica',''
END
IF NOT EXISTS ( SELECT O.object_id, C.column_id, C.NAME FROM  SYS.OBJECTS O INNER JOIN SYS.columns C ON O.object_id = C.object_id  WHERE O.NAME = 'FDIAN'  AND   C.NAME = 'LONGFTR')
BEGIN
   ALTER TABLE FDIAN  ADD LONGFTR 
END
8PBSZSKH
8pbszskh
IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME='SERTHOM' AND XTYPE='U')
BEGIN
CLAVE=HASHBYTES('SHA2_512','JUAN11')
Carlosmario
END
SELECT STUFF((
        SELECT DISTINCT ', '+ CONCAT(CONVERT(VARCHAR,ALR.IDALERTA,10),' ',TALR.DESCALTERTA,' ',CONVERT(VARCHAR,ALR.FECHAALERTA,103),' ',ALR.OBS) FROM ALR INNER JOIN TALR ON ALR.IDALERTA=TALR.IDALERTA
         WHERE IDAFILIADO='0100002039'
        FOR XML PATH('')
    ),1,1,'')

jU4N316m4NU3L3R1C4
XX 317 583 3194
https://eltiosam2021upload.blogspot.com/
http://hotpackspormega.blogspot.com/
https://packsvip2019.blogspot.com/2019/03/pack-teen-dark-universe-pack-29-fotos-2.html
http://www.mediafire.com/file/91m5hdiqhxf009t/American_Truck_Simulator_v.1.35.1.27.rar/file
ja17286569
--ALTER TABLE NEMP NOCHECK CONSTRAINT FK_NEMP_NEMPNUMDOC
IF NOT EXISTS(SELECT * FROM SYS.indexes A INNER JOIN SYS.index_columns B ON A.object_id=B.object_id AND A.index_id=B.index_id
                                      INNER JOIN SYS.columns C ON B.column_id=C.column_id
                                      INNER JOIN SYS.OBJECTS O ON O.object_id = C.object_id
           WHERE O.name='FCXCR'
           AND A.name='FCXCRN_FACTURA'  
           AND A.type_desc='NONCLUSTERED'
           AND C.name='CNSCXC'
           )
BEGIN 
   DROP INDEX FCXCR.FCXCRN_FACTURA

   CREATE UNIQUE INDEX FCXCRN_FACTURA ON FCXCR (N_FACTURA,CNSCXC)
END 
--ANA919870
cmt HACTRAND,x,i,'KRYFAS..HACTRAND'
--COLAS OJO MUY BUENO	
GET(Qclientes,CHOICE(?List2))
IF NOT ERRORCODE()
    MESSAGE('Estas Seleccionando a '&CLIP(QC:NOMBRES)&', '&QC:APELLIDO,'INFORMACION!!!',ICON:EXCLAMATION)
ELSE
    MESSAGE('No se ha Efectuado Seleccion en el Queue','INFORMACION!!!',ICON:EXCLAMATION)
END
 IF KEYCODE()=MouseLeft2 OR KEYCODE()=SpaceKey
     p# = ?List2{PROP:Selected}

     GET(QUEUE:RECIBOS,p#)
     IF NOT ERRORCODE()
     
--JSON
ALTER DATABASE DatabaseName SET COMPATIBILITY_LEVEL = 130

-CONSECUTIVOS 262396
SELECT REPLACE(SPACE(8-LEN(1))+'1',SPACE(1),0)
--KRYSTALOS--3077077
      SET @CNSFCXP=SPACE(20)
      EXEC SPK_GENCONSECUTIVO @COMPANIA,@SEDE,'@FCXPNM',@CNSFCXP OUTPUT   
      SELECT @CNSFCXP = @SEDE + 'NM'+REPLACE(SPACE(6 - LEN(@CNSFCXP))+LTRIM(RTRIM(@CNSFCXP)),SPACE(1),0)

ALTER SEQUENCE  RESTART WITH 
-- CUENTA ROW
-- EN LISTA
ROW_NUMBER() OVER(ORDER  BY IDAFILIADO  DESC)

-- EN GRUPO
ROW_NUMBER() OVER(PARTITION BY IDAFILIADO ORDER BY IDAFILIADO DESC)NRO
--ERROR EN SQL
      RAISERROR('No tiene configurado Departamento de Cartera',16,1)
      RETURN
	  
--QUITAR ENTER
REPLACE(REPLACE(IDENTIFICADOR,CHAR(10),''),CHAR(13),'') 
-- CREAR FUNCIONES
----- FUNCIONES CON UN SOLO DATO
/***************************************************************************************/
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME='FNK_DESALDOSINICIALES' AND XTYPE='FN')
BEGIN
   DROP FUNCTION FNK_DESALDOSINICIALES
END
GO
/***************************************************************************************/
CREATE FUNCTION DBO.FNK_DESALDOSINICIALES(@COMPANIA VARCHAR(2), @ANO INT , @MES INT)
RETURNS SMALLINT
AS
BEGIN

END
--- FUNCIONES TIPO TABLA

/***************************************************************************************/
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME='FNK_RIPS_LISTA' AND XTYPE='TF')
BEGIN
   DROP FUNCTION FNK_RIPS_LISTA
END
GO
/***************************************************************************************/
CREATE FUNCTION DBO.FNK_RIPS_LISTA(@IDTERCERO VARCHAR(20), @IDPLAN VARCHAR(6), @FECHAINI DATETIME, @FECHAFIN DATETIME)  
RETURNS @RESULTADOS
TABLE 
AS  
BEGIN
 INSERT INTO @RESULTADOS
 END
--- SPK
/***************************************************************************************/
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'SPK_' AND TYPE = 'P')
BEGIN
   DROP PROCEDURE SPK_
END
GO
/***************************************************************************************/
CREATE PROCEDURE DBO.SPK_ 
@COMPANIA  VARCHAR(2),  
WITH ENCRYPTION
AS  
DECLARE @EXISTE INT
BEGIN  

END   
V3NUS2020*
/***************************************************************************************/
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME= 'VWK_TEXCA' AND TYPE='V')
BEGIN
 DROP VIEW VWK_TEXCA
END
GO
/***************************************************************************************/

   LOC:SQL='SELECT CASE WHEN '''&FORMAT(HPRE:FECHA_DATE,@D06)&' '&FORMAT(HPRE:FECHA_TIME,@T01)&''' >GETDATE() THEN ''ER'' ELSE ''OK'' END'
   CLEAR(WDUM:RECORD)
   WDUM{PROP:SQL}=LOC:SQL
   ACCESS:WDUM.NEXT()
   IF WDUM:C1='ER'
      MESSAGE('La Fecha de la Prestacion No Puede ser Mayor a la Actual','Prestaciones',ICON:HAND)
      HPRE:FECHA_DATE = WDF:C1_DATE
      HPRE:FECHA_TIME = WDF:C1_TIME
      DISPLAY
   END
   
   3166197661
   CURSO DE C#
   Clave
|
|
|
|
|
|
|
|
|
|
|
\/
cosasgratis

yaneth.ortiz@jaramillortiz.com