 DECLARE 
 @FECHAINI      DATETIME ='02/07/2019',
 @DIAS          INT = 15, 
 @SABADOS       SMALLINT=1, 
 @DOMINGOS      SMALLINT=0,
 @FESTIVOS      SMALLINT=0
 
 
 
   DECLARE @CONT INT  
   DECLARE @DADISFRUTAR INT  
   DECLARE @FECHA DATETIME       
   DECLARE @DIASEMANA SMALLINT
   DECLARE @DIASFINMES SMALLINT
   
   SELECT @CONT=0,@DIASFINMES=0
   SELECT @DADISFRUTAR=0  
   SELECT @FECHA=@FECHAINI  
   WHILE @CONT<=@DIAS
   BEGIN  
      PRINT 'EMPIEZO LA FUNCION '
      PRINT '@DIAS'+STR(@DIAS)+'   @CONT='+STR(@CONT)
      SELECT @DIASEMANA = DATEPART(WEEKDAY,@FECHA)
      PRINT '@DIASEMANA= '+STR(@DIASEMANA)

      IF EXISTS(SELECT * FROM FES WHERE FECHA=@FECHA)
      BEGIN
         PRINT 'ES FESTIVO '
         IF @FESTIVOS = 1
         BEGIN 
            SELECT @CONT = @CONT + 1
         END
         SELECT @DADISFRUTAR = @DADISFRUTAR + 1 
         SELECT @FECHA = @FECHA + 1
         PRINT ' ANTES DE DEVOLVERME FESTIVO  @CONT='+STR(@CONT)
         CONTINUE
      END

      IF @FECHA=DBO.FNK_DIA_DEL_MES(YEAR(@FECHA),MONTH(@FECHA),'ULTIMO')
      BEGIN
         SELECT @DIASFINMES=@DIASFINMES+(30-DAY(@FECHA))  
      END
      IF  @DIASEMANA = 7 
      BEGIN
         IF @DOMINGOS = 1 
         BEGIN
            SELECT @CONT = @CONT + 1 
         END
         ELSE
         BEGIN
            SELECT @DADISFRUTAR = @DADISFRUTAR + 1 
            SELECT @FECHA = @FECHA + 1
            PRINT ' ANTES DE DEVOLVERME DOMINGO  @CONT='+STR(@CONT)
            CONTINUE
         END
      END                 
      IF  @DIASEMANA = 6
      BEGIN
         IF @SABADOS = 1 
         BEGIN
            SELECT @CONT = @CONT + 1 
         END
         ELSE
         BEGIN
            SELECT @FECHA = @FECHA + 1
            SELECT @DADISFRUTAR = @DADISFRUTAR + 1 
            PRINT ' ANTES DE DEVOLVERME SABADO  @CONT='+STR(@CONT)
            CONTINUE
         END
      END 
      SELECT @CONT = @CONT + 1      
      SELECT @FECHA = @FECHA + 1
      SELECT @DADISFRUTAR = @DADISFRUTAR + 1  
   END  

   SELECT @FECHA+1,@DADISFRUTAR+1
