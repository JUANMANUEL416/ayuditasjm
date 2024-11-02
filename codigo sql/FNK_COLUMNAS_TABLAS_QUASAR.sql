IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME='FNK_COLUMNAS_TABLAS_QUASAR' AND XTYPE='FN')
BEGIN
   DROP FUNCTION FNK_COLUMNAS_TABLAS_QUASAR
END
GO
CREATE FUNCTION DBO.FNK_COLUMNAS_TABLAS_QUASAR(@TABLA VARCHAR(20), @ACCION SMALLINT)
RETURNS VARCHAR(MAX)
AS
BEGIN
   DECLARE @CANT INT
   DECLARE @COLUMNA VARCHAR(200)
   DECLARE @I    INT
   DECLARE @TEXT VARCHAR(MAX)
   DECLARE @LEN  INT
   DECLARE @BANDERA INT
   DECLARE @NTIPO VARCHAR(20)
   DECLARE @LARGO INT
   DECLARE @XPRE  INT
   DECLARE @XSCA  INT

   SELECT @I =1, @BANDERA=1
   
   SELECT @CANT= COUNT(*)
   FROM sysobjects A INNER JOIN syscolumns B ON A.id=B.id
   WHERE A.name=@TABLA
   
   DECLARE PG_CURSOR CURSOR FOR 
   SELECT B.NAME,C.name,B.length,B.xprec,B.xscale
   FROM sysobjects A INNER JOIN syscolumns B ON A.id=B.id
                     INNER JOIN SYS.systypes C ON B.usertype=C.usertype
   WHERE A.name=@TABLA      
   ORDER BY B.colorder
   OPEN PG_CURSOR    
   FETCH NEXT FROM PG_CURSOR    
   INTO @COLUMNA,@NTIPO,@LARGO,@XPRE,@XSCA
   WHILE @@FETCH_STATUS = 0    
   BEGIN 
      --CREAR VARIABLES
      IF @ACCION=1
      BEGIN
         SELECT @TEXT=COALESCE(@TEXT,'')+LOWER(@COLUMNA)+': null'
      END
      --INSERTAR
      IF @ACCION=2
      BEGIN
         SELECT @TEXT=COALESCE(@TEXT,'')+UPPER(@COLUMNA)+': this.'+LOWER(@COLUMNA)
      END
      --UPDATE
      IF @ACCION=3
      BEGIN
         SELECT @TEXT=COALESCE(@TEXT,'' )+'this.'+LOWER(@COLUMNA)+'=datos[0].'+UPPER(@COLUMNA)
      END
      --FORMULARIO
      IF @ACCION=4
      BEGIN
         SELECT @TEXT=COALESCE(@TEXT,'')+'     <div class="col-6 q-px-xs"> '+CHAR(13)
         SELECT @TEXT=COALESCE(@TEXT,'')+'          <q-input outlined v-model="'+LOWER(@COLUMNA)+'" type="text" label="'+LOWER(@COLUMNA)+'" dense/> '+CHAR(13)
         SELECT @TEXT=COALESCE(@TEXT,'')+'     </div> '+CHAR(13)
      END
      --PARAMETROS JSON
      IF @ACCION=5
      BEGIN
         SELECT @TEXT=COALESCE(@TEXT,'')+UPPER(@COLUMNA)+' '+UPPER(@NTIPO)
         IF @NTIPO='Varchar'
         BEGIN
             SELECT @TEXT=COALESCE(@TEXT,'')+'('+LTRIM(RTRIM(STR(@LARGO)))+')'
         END
         ELSE
         BEGIN
            IF @NTIPO='Decimal' OR @NTIPO='Numeric'
            BEGIN
               SELECT @TEXT=COALESCE(@TEXT,'')+'('+LTRIM(RTRIM(STR(@XPRE)))+','++LTRIM(RTRIM(STR(@XSCA)))+')'
            END
         END
         SELECT @TEXT=COALESCE(@TEXT,'')+'''$.'+UPPER(@COLUMNA)+''''
         IF @I<@CANT
         BEGIN
            SELECT @TEXT=COALESCE(@TEXT,'')+', '+CHAR(13)
         END
      END
      --UPDATE 
      IF @ACCION=6
      BEGIN
         SELECT @TEXT=COALESCE(@TEXT,'')+UPPER(@COLUMNA)+' = JS.'+UPPER(@COLUMNA)
         IF @I<@CANT
         BEGIN
            SELECT @TEXT=COALESCE(@TEXT,'')+', '
         END
      END

      IF @I<@CANT AND @ACCION<4
      BEGIN
         SELECT @TEXT=COALESCE(@TEXT,'')+', '
         SELECT @TEXT=COALESCE(@TEXT,'')+CHAR(13)
      END
      SELECT @I=@I+1         
   FETCH NEXT FROM PG_CURSOR    
   INTO @COLUMNA,@NTIPO,@LARGO,@XPRE,@XSCA
   END
   CLOSE PG_CURSOR
   DEALLOCATE PG_CURSOR
   RETURN @TEXT
END 
   
   




