DROP PROC SPKH_RECALCULO_PERIODOS
go
CREATE PROC SPKH_RECALCULO_PERIODOS
@ANOINI VARCHAR (4),
@MESINI INT,
@ANOFIN VARCHAR (4),
@MESFIN INT 
AS  
DECLARE @RECALCULO VARCHAR (200)
DECLARE @ANOAUX      VARCHAR (4)
DECLARE @MESAUX      INT
DECLARE @CONTROL    INT 
BEGIN 
   PRINT 'INICIA RECALCULO'
   SELECT @ANOAUX=@ANOINI,@MESAUX=@MESINI
   SELECT @CONTROL = 0
   WHILE  @CONTROL = 0 
   BEGIN
      SELECT @RECALCULO = 'SPK_RECALCULO_DETALLES_MCH ''01'','''+@ANOAUX+''','+CAST  (@MESAUX AS VARCHAR (2))
      PRINT '@RECALCULO='+@RECALCULO          
      EXEC (@RECALCULO) 
      SELECT @MESAUX = @MESAUX+1
      IF @MESAUX =13
      BEGIN
         SELECT @MESAUX = 1
         SELECT @ANOAUX = @ANOAUX+1 
      END
      IF  @ANOAUX > @ANOFIN
      BEGIN 
         SELECT @CONTROL = 1      
      END 
      ELSE 
      BEGIN 
         IF @ANOAUX = @ANOFIN
         BEGIN 
            IF @MESAUX > @MESFIN
            BEGIN
               SELECT @CONTROL = 1 
            END 
         END      
      END
   END
END



EXEC SPKH_RECALCULO_PERIODOS '2010', 10, '2011',2