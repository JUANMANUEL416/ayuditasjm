IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOFTR' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOFTR
GO 
CREATE TRIGGER DBO.TK1_PROCESOFTR
ON FTR
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOHADM' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOHADM
GO 
CREATE TRIGGER DBO.TK1_PROCESOHADM
ON HADM
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION

END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOHPRE' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOHPRE
GO 
CREATE TRIGGER DBO.TK1_PROCESOHPRE
ON HPRE
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION

END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOHPRED' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOHPRED
GO 
CREATE TRIGGER DBO.TK1_PROCESOHPRED
ON HPRED
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION

END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOAUT' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOAUT
GO 
CREATE TRIGGER DBO.TK1_PROCESOAUT
ON AUT
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION

END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOAUTD' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOAUTD
GO 
CREATE TRIGGER DBO.TK1_PROCESOAUTD
ON AUTD
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION

END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOMCP' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOMCP
GO 
CREATE TRIGGER DBO.TK1_PROCESOMCP
ON MCP
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION

END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOMCH' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOMCH
GO 
CREATE TRIGGER DBO.TK1_PROCESOMCH
ON MCH
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION

END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOHCA' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOHCA
GO 
CREATE TRIGGER DBO.TK1_PROCESOHCA
ON HCA
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION

END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOHCAD' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOHCAD
GO 
CREATE TRIGGER DBO.TK1_PROCESOHCAD
ON HCAD
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION

END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOLING' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOLING
GO 
CREATE TRIGGER DBO.TK1_PROCESOLING
ON LING
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOLORD' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOLORD
GO 
CREATE TRIGGER DBO.TK1_PROCESOLORD
ON LORD
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOLORDD' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOLORDD
GO 
CREATE TRIGGER DBO.TK1_PROCESOLORDD
ON LORDD
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOFTRD' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOFTRD
GO 
CREATE TRIGGER DBO.TK1_PROCESOFTRD
ON FTRD
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOFCJ' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOFCJ
GO 
CREATE TRIGGER DBO.TK1_PROCESOFCJ
ON FCJ
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOFCJD' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOFCJD
GO 
CREATE TRIGGER DBO.TK1_PROCESOFCJD
ON FCJD
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOPCJ' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOPCJ
GO 
CREATE TRIGGER DBO.TK1_PROCESOPCJ
ON PCJ
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOFCXP' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOFCXP
GO 
CREATE TRIGGER DBO.TK1_PROCESOFCXP
ON FCXP
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOFCXPD' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOFCXPD
GO 
CREATE TRIGGER DBO.TK1_PROCESOFCXPD
ON FCXPD
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOIMOV' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOIMOV
GO 
CREATE TRIGGER DBO.TK1_PROCESOIMOV
ON IMOV
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOUSUSU' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOUSUSU
GO 
--CREATE TRIGGER DBO.TK1_PROCESOUSUSU
--ON USUSU
--WITH ENCRYPTION
--FOR INSERT, UPDATE, DELETE
--AS
--DECLARE @FECHA AS DATETIME
--SELECT @FECHA = GETDATE()
--IF @FECHA > '20251226 15:00:00'
--BEGIN
--   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
--   ROLLBACK TRANSACTION
--END
--GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOIMOVH' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOIMOVH
GO 
CREATE TRIGGER DBO.TK1_PROCESOIMOVH
ON IMOVH
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOITRA' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOITRA
GO 
CREATE TRIGGER DBO.TK1_PROCESOITRA
ON ITRA
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOITRAH' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOITRAH
GO 
CREATE TRIGGER DBO.TK1_PROCESOITRAH
ON ITRAH
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOSER' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOSER
GO 
CREATE TRIGGER DBO.TK1_PROCESOSER
ON SER
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOTAR' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOTAR
GO 
CREATE TRIGGER DBO.TK1_PROCESOTAR
ON TAR
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOTARD' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOTARD
GO 
CREATE TRIGGER DBO.TK1_PROCESOTARD
ON TARD
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOTARDV' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOTARDV
GO 
CREATE TRIGGER DBO.TK1_PROCESOTARDV
ON TARDV
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOTER' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOTER
GO 
CREATE TRIGGER DBO.TK1_PROCESOTER
ON TER
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOTEXCA' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOTEXCA
GO 
CREATE TRIGGER DBO.TK1_PROCESOTEXCA
ON TEXCA
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOCUE' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOCUE
GO 
CREATE TRIGGER DBO.TK1_PROCESOCUE
ON CUE
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOKMCOM' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOKMCOM
GO 
CREATE TRIGGER DBO.TK1_PROCESOKMCOM
ON KMCOM
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOCPPAF' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOCPPAF
GO 
CREATE TRIGGER DBO.TK1_PROCESOCPPAF
ON CPPAF
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOCIT' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOCIT
GO 
CREATE TRIGGER DBO.TK1_PROCESOCIT
ON CIT
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_AFI_IDAFILIADO' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_AFI_IDAFILIADO
GO 
CREATE TRIGGER DBO.TK1_AFI_IDAFILIADO
ON AFI
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO  

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOAFI' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOAFI
GO 
CREATE TRIGGER DBO.TK1_PROCESOAFI
ON AFI
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO
------------------------------
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOFNOT' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOFNOT
GO 
CREATE TRIGGER DBO.TK1_PROCESOFNOT
ON FNOT
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO 
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK_PROCESOFNOT' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK_PROCESOFNOT
GO 
CREATE TRIGGER DBO.TK_PROCESOFNOT
ON FNOT
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO 
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOFNOTD' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOFNOTD
GO 
CREATE TRIGGER DBO.TK1_PROCESOFNOTD
ON FNOTD
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK_PROCESOFNOTD' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK_PROCESOFNOTD
GO 
CREATE TRIGGER DBO.TK_PROCESOFNOTD
ON FNOTD
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOFCXC' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOFCXC
GO 
CREATE TRIGGER DBO.TK1_PROCESOFCXC
ON FCXC
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOFCXCD' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOFCXCD
GO 
CREATE TRIGGER DBO.TK1_PROCESOFCXCD
ON FCXCD
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOFCXCDV' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOFCXCDV
GO 
CREATE TRIGGER DBO.TK1_PROCESOFCXCDV
ON FCXCDV
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOFGLO' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOFGLO
GO 
CREATE TRIGGER DBO.TK1_PROCESOFGLO
ON FGLO
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOFPAG' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOFPAG
GO 
CREATE TRIGGER DBO.TK1_PROCESOFPAG
ON FPAG
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOHADMAD' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOHADMAD
GO 
CREATE TRIGGER DBO.TK1_PROCESOHADMAD
ON HADMAD
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = 'TK1_PROCESOHADMDX' AND TYPE = 'TR')
   DROP TRIGGER DBO.TK1_PROCESOHADMDX
GO 
CREATE TRIGGER DBO.TK1_PROCESOHADMDX
ON HADMDX
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
DECLARE @FECHA AS DATETIME
SELECT @FECHA = GETDATE()
IF @FECHA > '20251226 15:00:00'
BEGIN
   RAISERROR ('INTENTO DE VIOLACION DE LICENCIA KRYSTALOS', 16, 1)
   ROLLBACK TRANSACTION
END
GO