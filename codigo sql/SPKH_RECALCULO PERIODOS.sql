
--DROP PROC SPKH_RECALCULO_PERIODOS
--EXEC SPKH_RECALCULO_PERIODOS '2002',1,'2010',2

CREATE PROC [dbo].[SPKH_RECALCULO_PERIODOS]
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
--------------------------------------------------------------------------------
	UPDATE PRI SET DESALDOSINICIALES=0 WHERE DESALDOSINICIALES IS NULL

	PRINT '-- Borrado de Tablas'
	 DROP VIEW VWK_SALDOS_CONTABLES
	 DROP VIEW VWK_SXT
	 DROP TABLE SXT2004ME
	 DROP TABLE SXT2004
	 DROP TABLE SXT2005
	 DROP TABLE SXT2006
	 DROP TABLE SXT2007
	 DROP TABLE SXT2008
	 DROP TABLE SXT2008MA

	PRINT '-- A�os Anteriores al 2004'
	-- 067
	CREATE TABLE DBO.SXT2004ME (
	 COMPANIA     VARCHAR(2)  NOT NULL,
	 ANO          INT         NOT NULL CHECK (ANO < 2004),
	 CCOSTO       VARCHAR(20) NOT NULL,
	 CUENTA       VARCHAR(16) NOT NULL,
	 IDTERCERO    VARCHAR(20) NOT NULL,
	 N_FACTURA    VARCHAR(20) NOT NULL,
	 CODUNG       VARCHAR(5) NOT NULL,
	 CODPRG       VARCHAR(20) NOT NULL,
	 SI01MANUAL   INT,
	 SI01M        DECIMAL(14,2),
	 SF01AA       DECIMAL(14,2),
	 SI01         AS (CASE WHEN SI01MANUAL = 1 THEN SI01M ELSE SF01AA END),
	 DB01         DECIMAL(14,2),
	 CR01         DECIMAL(14,2),
	 SF01         DECIMAL(14,2),
	 SI02MANUAL   INT,
	 SI02M        DECIMAL(14,2),
	 SI02         AS (CASE WHEN SI02MANUAL = 1 THEN SI02M ELSE SF01 END),
	 DB02         DECIMAL(14,2),
	 CR02         DECIMAL(14,2),
	 SF02         DECIMAL(14,2),
	 SI03MANUAL   INT,
	 SI03M        DECIMAL(14,2),
	 SI03         AS (CASE WHEN SI03MANUAL = 1 THEN SI03M ELSE SF02 END),
	 DB03         DECIMAL(14,2),
	 CR03         DECIMAL(14,2),
	 SF03         DECIMAL(14,2),
	 SI04MANUAL   INT,
	 SI04M        DECIMAL(14,2),
	 SI04         AS (CASE WHEN SI04MANUAL = 1 THEN SI04M ELSE SF03 END),
	 DB04         DECIMAL(14,2),
	 CR04         DECIMAL(14,2),
	 SF04         DECIMAL(14,2),
	 SI05MANUAL   INT,
	 SI05M        DECIMAL(14,2),
	 SI05         AS (CASE WHEN SI05MANUAL = 1 THEN SI05M ELSE SF04 END),
	 DB05         DECIMAL(14,2),
	 CR05         DECIMAL(14,2),
	 SF05         DECIMAL(14,2),
	 SI06MANUAL   INT,
	 SI06M        DECIMAL(14,2),
	 SI06         AS (CASE WHEN SI06MANUAL = 1 THEN SI06M ELSE SF05 END),
	 DB06         DECIMAL(14,2),
	 CR06         DECIMAL(14,2),
	 SF06         DECIMAL(14,2),
	 SI07MANUAL   INT,
	 SI07M        DECIMAL(14,2),
	 SI07         AS (CASE WHEN SI07MANUAL = 1 THEN SI07M ELSE SF06 END),
	 DB07         DECIMAL(14,2),
	 CR07         DECIMAL(14,2),
	 SF07         DECIMAL(14,2),
	 SI08MANUAL   INT,
	 SI08M        DECIMAL(14,2),
	 SI08         AS (CASE WHEN SI08MANUAL = 1 THEN SI08M ELSE SF07 END),
	 DB08         DECIMAL(14,2),
	 CR08         DECIMAL(14,2),
	 SF08         DECIMAL(14,2),
	 SI09MANUAL   INT,
	 SI09M        DECIMAL(14,2),
	 SI09         AS (CASE WHEN SI09MANUAL = 1 THEN SI09M ELSE SF08 END),
	 DB09         DECIMAL(14,2),
	 CR09         DECIMAL(14,2),
	 SF09         DECIMAL(14,2),
	 SI10MANUAL   INT,
	 SI10M        DECIMAL(14,2),
	 SI10         AS (CASE WHEN SI10MANUAL = 1 THEN SI10M ELSE SF09 END),
	 DB10         DECIMAL(14,2),
	 CR10         DECIMAL(14,2),
	 SF10         DECIMAL(14,2),
	 SI11MANUAL   INT,
	 SI11M        DECIMAL(14,2),
	 SI11         AS (CASE WHEN SI11MANUAL = 1 THEN SI11M ELSE SF10 END),
	 DB11         DECIMAL(14,2),
	 CR11         DECIMAL(14,2),
	 SF11         DECIMAL(14,2),
	 SI12MANUAL   INT,
	 SI12M        DECIMAL(14,2),
	 SI12         AS (CASE WHEN SI12MANUAL = 1 THEN SI12M ELSE SF11 END),
	 DB12         DECIMAL(14,2),
	 CR12         DECIMAL(14,2),
	 SF12         DECIMAL(14,2))
	ALTER TABLE DBO.SXT2004ME
	ADD CONSTRAINT SXT2004ME_LLAVEPPAL
	PRIMARY KEY CLUSTERED (COMPANIA, ANO, CCOSTO, CUENTA, IDTERCERO, N_FACTURA, CODUNG, CODPRG)
    PRINT 'A�O 2004'
	CREATE TABLE DBO.SXT2004 (
	 COMPANIA     VARCHAR(2)  NOT NULL,
	 ANO          INT         NOT NULL CHECK (ANO = 2004),
	 CCOSTO       VARCHAR(20) NOT NULL,
	 CUENTA       VARCHAR(16) NOT NULL,
	 IDTERCERO    VARCHAR(20) NOT NULL,
	 N_FACTURA    VARCHAR(20) NOT NULL,
	 CODUNG       VARCHAR(5) NOT NULL,
	 CODPRG       VARCHAR(20) NOT NULL,
	 SI01MANUAL   INT,
	 SI01M        DECIMAL(14,2),
	 SF01AA       DECIMAL(14,2),
	 SI01         AS (CASE WHEN SI01MANUAL = 1 THEN SI01M ELSE SF01AA END),
	 DB01         DECIMAL(14,2),
	 CR01         DECIMAL(14,2),
	 SF01         DECIMAL(14,2),
	 SI02MANUAL   INT,
	 SI02M        DECIMAL(14,2),
	 SI02         AS (CASE WHEN SI02MANUAL = 1 THEN SI02M ELSE SF01 END),
	 DB02         DECIMAL(14,2),
	 CR02         DECIMAL(14,2),
	 SF02         DECIMAL(14,2),
	 SI03MANUAL   INT,
	 SI03M        DECIMAL(14,2),
	 SI03         AS (CASE WHEN SI03MANUAL = 1 THEN SI03M ELSE SF02 END),
	 DB03         DECIMAL(14,2),
	 CR03         DECIMAL(14,2),
	 SF03         DECIMAL(14,2),
	 SI04MANUAL   INT,
	 SI04M        DECIMAL(14,2),
	 SI04         AS (CASE WHEN SI04MANUAL = 1 THEN SI04M ELSE SF03 END),
	 DB04         DECIMAL(14,2),
	 CR04         DECIMAL(14,2),
	 SF04         DECIMAL(14,2),
	 SI05MANUAL   INT,
	 SI05M        DECIMAL(14,2),
	 SI05         AS (CASE WHEN SI05MANUAL = 1 THEN SI05M ELSE SF04 END),
	 DB05         DECIMAL(14,2),
	 CR05         DECIMAL(14,2),
	 SF05         DECIMAL(14,2),
	 SI06MANUAL   INT,
	 SI06M        DECIMAL(14,2),
	 SI06         AS (CASE WHEN SI06MANUAL = 1 THEN SI06M ELSE SF05 END),
	 DB06         DECIMAL(14,2),
	 CR06         DECIMAL(14,2),
	 SF06         DECIMAL(14,2),
	 SI07MANUAL   INT,
	 SI07M        DECIMAL(14,2),
	 SI07         AS (CASE WHEN SI07MANUAL = 1 THEN SI07M ELSE SF06 END),
	 DB07         DECIMAL(14,2),
	 CR07         DECIMAL(14,2),
	 SF07         DECIMAL(14,2),
	 SI08MANUAL   INT,
	 SI08M        DECIMAL(14,2),
	 SI08         AS (CASE WHEN SI08MANUAL = 1 THEN SI08M ELSE SF07 END),
	 DB08         DECIMAL(14,2),
	 CR08         DECIMAL(14,2),
	 SF08         DECIMAL(14,2),
	 SI09MANUAL   INT,
	 SI09M        DECIMAL(14,2),
	 SI09         AS (CASE WHEN SI09MANUAL = 1 THEN SI09M ELSE SF08 END),
	 DB09         DECIMAL(14,2),
	 CR09         DECIMAL(14,2),
	 SF09         DECIMAL(14,2),
	 SI10MANUAL   INT,
	 SI10M        DECIMAL(14,2),
	 SI10         AS (CASE WHEN SI10MANUAL = 1 THEN SI10M ELSE SF09 END),
	 DB10         DECIMAL(14,2),
	 CR10         DECIMAL(14,2),
	 SF10         DECIMAL(14,2),
	 SI11MANUAL   INT,
	 SI11M        DECIMAL(14,2),
	 SI11         AS (CASE WHEN SI11MANUAL = 1 THEN SI11M ELSE SF10 END),
	 DB11         DECIMAL(14,2),
	 CR11         DECIMAL(14,2),
	 SF11         DECIMAL(14,2),
	 SI12MANUAL   INT,
	 SI12M        DECIMAL(14,2),
	 SI12         AS (CASE WHEN SI12MANUAL = 1 THEN SI12M ELSE SF11 END),
	 DB12         DECIMAL(14,2),
	 CR12         DECIMAL(14,2),
	 SF12         DECIMAL(14,2))

	ALTER TABLE SXT2004
	ADD CONSTRAINT SXT2004_LLAVEPPAL
	PRIMARY KEY CLUSTERED (COMPANIA, ANO, CCOSTO, CUENTA, IDTERCERO, N_FACTURA, CODUNG, CODPRG)
	-- 069
	PRINT '-- A�os 2005'
	CREATE TABLE DBO.SXT2005 (
	 COMPANIA     VARCHAR(2)  NOT NULL,
	 ANO          INT         NOT NULL CHECK (ANO = 2005),
	 CCOSTO       VARCHAR(20) NOT NULL,
	 CUENTA       VARCHAR(16) NOT NULL,
	 IDTERCERO    VARCHAR(20) NOT NULL,
	 N_FACTURA    VARCHAR(20) NOT NULL,
	 CODUNG       VARCHAR(5) NOT NULL,
	 CODPRG       VARCHAR(20) NOT NULL,
	 SI01MANUAL   INT,
	 SI01M        DECIMAL(14,2),
	 SF01AA       DECIMAL(14,2),
	 SI01         AS (CASE WHEN SI01MANUAL = 1 THEN SI01M ELSE SF01AA END),
	 DB01         DECIMAL(14,2),
	 CR01         DECIMAL(14,2),
	 SF01         DECIMAL(14,2),
	 SI02MANUAL   INT,
	 SI02M        DECIMAL(14,2),
	 SI02         AS (CASE WHEN SI02MANUAL = 1 THEN SI02M ELSE SF01 END),
	 DB02         DECIMAL(14,2),
	 CR02         DECIMAL(14,2),
	 SF02         DECIMAL(14,2),
	 SI03MANUAL   INT,
	 SI03M        DECIMAL(14,2),
	 SI03         AS (CASE WHEN SI03MANUAL = 1 THEN SI03M ELSE SF02 END),
	 DB03         DECIMAL(14,2),
	 CR03         DECIMAL(14,2),
	 SF03         DECIMAL(14,2),
	 SI04MANUAL   INT,
	 SI04M        DECIMAL(14,2),
	 SI04         AS (CASE WHEN SI04MANUAL = 1 THEN SI04M ELSE SF03 END),
	 DB04         DECIMAL(14,2),
	 CR04         DECIMAL(14,2),
	 SF04         DECIMAL(14,2),
	 SI05MANUAL   INT,
	 SI05M        DECIMAL(14,2),
	 SI05         AS (CASE WHEN SI05MANUAL = 1 THEN SI05M ELSE SF04 END),
	 DB05         DECIMAL(14,2),
	 CR05         DECIMAL(14,2),
	 SF05         DECIMAL(14,2),
	 SI06MANUAL   INT,
	 SI06M        DECIMAL(14,2),
	 SI06         AS (CASE WHEN SI06MANUAL = 1 THEN SI06M ELSE SF05 END),
	 DB06         DECIMAL(14,2),
	 CR06         DECIMAL(14,2),
	 SF06         DECIMAL(14,2),
	 SI07MANUAL   INT,
	 SI07M        DECIMAL(14,2),
	 SI07         AS (CASE WHEN SI07MANUAL = 1 THEN SI07M ELSE SF06 END),
	 DB07         DECIMAL(14,2),
	 CR07         DECIMAL(14,2),
	 SF07         DECIMAL(14,2),
	 SI08MANUAL   INT,
	 SI08M        DECIMAL(14,2),
	 SI08         AS (CASE WHEN SI08MANUAL = 1 THEN SI08M ELSE SF07 END),
	 DB08         DECIMAL(14,2),
	 CR08         DECIMAL(14,2),
	 SF08         DECIMAL(14,2),
	 SI09MANUAL   INT,
	 SI09M        DECIMAL(14,2),
	 SI09         AS (CASE WHEN SI09MANUAL = 1 THEN SI09M ELSE SF08 END),
	 DB09         DECIMAL(14,2),
	 CR09         DECIMAL(14,2),
	 SF09         DECIMAL(14,2),
	 SI10MANUAL   INT,
	 SI10M        DECIMAL(14,2),
	 SI10         AS (CASE WHEN SI10MANUAL = 1 THEN SI10M ELSE SF09 END),
	 DB10         DECIMAL(14,2),
	 CR10         DECIMAL(14,2),
	 SF10         DECIMAL(14,2),
	 SI11MANUAL   INT,
	 SI11M        DECIMAL(14,2),
	 SI11         AS (CASE WHEN SI11MANUAL = 1 THEN SI11M ELSE SF10 END),
	 DB11         DECIMAL(14,2),
	 CR11         DECIMAL(14,2),
	 SF11         DECIMAL(14,2),
	 SI12MANUAL   INT,
	 SI12M        DECIMAL(14,2),
	 SI12         AS (CASE WHEN SI12MANUAL = 1 THEN SI12M ELSE SF11 END),
	 DB12         DECIMAL(14,2),
	 CR12         DECIMAL(14,2),
	 SF12         DECIMAL(14,2))
	ALTER TABLE SXT2005
	ADD CONSTRAINT SXT2005_LLAVEPPAL
	PRIMARY KEY CLUSTERED (COMPANIA, ANO, CCOSTO, CUENTA, IDTERCERO, N_FACTURA, CODUNG, CODPRG)
    PRINT 'A�O 2006'
	CREATE TABLE DBO.SXT2006 (
	 COMPANIA     VARCHAR(2)  NOT NULL,
	 ANO          INT         NOT NULL CHECK (ANO = 2006),
	 CCOSTO       VARCHAR(20) NOT NULL,
	 CUENTA       VARCHAR(16) NOT NULL,
	 IDTERCERO    VARCHAR(20) NOT NULL,
	 N_FACTURA    VARCHAR(20) NOT NULL,
	 CODUNG       VARCHAR(5) NOT NULL,
	 CODPRG       VARCHAR(20) NOT NULL,
	 SI01MANUAL   INT,
	 SI01M        DECIMAL(14,2),
	 SF01AA       DECIMAL(14,2),
	 SI01         AS (CASE WHEN SI01MANUAL = 1 THEN SI01M ELSE SF01AA END),
	 DB01         DECIMAL(14,2),
	 CR01         DECIMAL(14,2),
	 SF01         DECIMAL(14,2),
	 SI02MANUAL   INT,
	 SI02M        DECIMAL(14,2),
	 SI02         AS (CASE WHEN SI02MANUAL = 1 THEN SI02M ELSE SF01 END),
	 DB02         DECIMAL(14,2),
	 CR02         DECIMAL(14,2),
	 SF02         DECIMAL(14,2),
	 SI03MANUAL   INT,
	 SI03M        DECIMAL(14,2),
	 SI03         AS (CASE WHEN SI03MANUAL = 1 THEN SI03M ELSE SF02 END),
	 DB03         DECIMAL(14,2),
	 CR03         DECIMAL(14,2),
	 SF03         DECIMAL(14,2),
	 SI04MANUAL   INT,
	 SI04M        DECIMAL(14,2),
	 SI04         AS (CASE WHEN SI04MANUAL = 1 THEN SI04M ELSE SF03 END),
	 DB04         DECIMAL(14,2),
	 CR04         DECIMAL(14,2),
	 SF04         DECIMAL(14,2),
	 SI05MANUAL   INT,
	 SI05M        DECIMAL(14,2),
	 SI05         AS (CASE WHEN SI05MANUAL = 1 THEN SI05M ELSE SF04 END),
	 DB05         DECIMAL(14,2),
	 CR05         DECIMAL(14,2),
	 SF05         DECIMAL(14,2),
	 SI06MANUAL   INT,
	 SI06M        DECIMAL(14,2),
	 SI06         AS (CASE WHEN SI06MANUAL = 1 THEN SI06M ELSE SF05 END),
	 DB06         DECIMAL(14,2),
	 CR06         DECIMAL(14,2),
	 SF06         DECIMAL(14,2),
	 SI07MANUAL   INT,
	 SI07M        DECIMAL(14,2),
	 SI07         AS (CASE WHEN SI07MANUAL = 1 THEN SI07M ELSE SF06 END),
	 DB07         DECIMAL(14,2),
	 CR07         DECIMAL(14,2),
	 SF07         DECIMAL(14,2),
	 SI08MANUAL   INT,
	 SI08M        DECIMAL(14,2),
	 SI08         AS (CASE WHEN SI08MANUAL = 1 THEN SI08M ELSE SF07 END),
	 DB08         DECIMAL(14,2),
	 CR08         DECIMAL(14,2),
	 SF08         DECIMAL(14,2),
	 SI09MANUAL   INT,
	 SI09M        DECIMAL(14,2),
	 SI09         AS (CASE WHEN SI09MANUAL = 1 THEN SI09M ELSE SF08 END),
	 DB09         DECIMAL(14,2),
	 CR09         DECIMAL(14,2),
	 SF09         DECIMAL(14,2),
	 SI10MANUAL   INT,
	 SI10M        DECIMAL(14,2),
	 SI10         AS (CASE WHEN SI10MANUAL = 1 THEN SI10M ELSE SF09 END),
	 DB10         DECIMAL(14,2),
	 CR10         DECIMAL(14,2),
	 SF10         DECIMAL(14,2),
	 SI11MANUAL   INT,
	 SI11M        DECIMAL(14,2),
	 SI11         AS (CASE WHEN SI11MANUAL = 1 THEN SI11M ELSE SF10 END),
	 DB11         DECIMAL(14,2),
	 CR11         DECIMAL(14,2),
	 SF11         DECIMAL(14,2),
	 SI12MANUAL   INT,
	 SI12M        DECIMAL(14,2),
	 SI12         AS (CASE WHEN SI12MANUAL = 1 THEN SI12M ELSE SF11 END),
	 DB12         DECIMAL(14,2),
	 CR12         DECIMAL(14,2),
	 SF12         DECIMAL(14,2))
	ALTER TABLE SXT2006
	ADD CONSTRAINT SXT2006_LLAVEPPAL
	PRIMARY KEY CLUSTERED (COMPANIA, ANO, CCOSTO, CUENTA, IDTERCERO, N_FACTURA, CODUNG, CODPRG)
	-- 071
	PRINT '-- A�os 2007'
	CREATE TABLE DBO.SXT2007 (
	 COMPANIA     VARCHAR(2)  NOT NULL,
	 ANO          INT         NOT NULL CHECK (ANO = 2007),
	 CCOSTO       VARCHAR(20) NOT NULL,
	 CUENTA       VARCHAR(16) NOT NULL,
	 IDTERCERO    VARCHAR(20) NOT NULL,
	 N_FACTURA    VARCHAR(20) NOT NULL,
	 CODUNG       VARCHAR(5) NOT NULL,
	 CODPRG       VARCHAR(20) NOT NULL,
	 SI01MANUAL   INT,
	 SI01M        DECIMAL(14,2),
	 SF01AA       DECIMAL(14,2),
	 SI01         AS (CASE WHEN SI01MANUAL = 1 THEN SI01M ELSE SF01AA END),
	 DB01         DECIMAL(14,2),
	 CR01         DECIMAL(14,2),
	 SF01         DECIMAL(14,2),
	 SI02MANUAL   INT,
	 SI02M        DECIMAL(14,2),
	 SI02         AS (CASE WHEN SI02MANUAL = 1 THEN SI02M ELSE SF01 END),
	 DB02         DECIMAL(14,2),
	 CR02         DECIMAL(14,2),
	 SF02         DECIMAL(14,2),
	 SI03MANUAL   INT,
	 SI03M        DECIMAL(14,2),
	 SI03         AS (CASE WHEN SI03MANUAL = 1 THEN SI03M ELSE SF02 END),
	 DB03         DECIMAL(14,2),
	 CR03         DECIMAL(14,2),
	 SF03         DECIMAL(14,2),
	 SI04MANUAL   INT,
	 SI04M        DECIMAL(14,2),
	 SI04         AS (CASE WHEN SI04MANUAL = 1 THEN SI04M ELSE SF03 END),
	 DB04         DECIMAL(14,2),
	 CR04         DECIMAL(14,2),
	 SF04         DECIMAL(14,2),
	 SI05MANUAL   INT,
	 SI05M        DECIMAL(14,2),
	 SI05         AS (CASE WHEN SI05MANUAL = 1 THEN SI05M ELSE SF04 END),
	 DB05         DECIMAL(14,2),
	 CR05         DECIMAL(14,2),
	 SF05         DECIMAL(14,2),
	 SI06MANUAL   INT,
	 SI06M        DECIMAL(14,2),
	 SI06         AS (CASE WHEN SI06MANUAL = 1 THEN SI06M ELSE SF05 END),
	 DB06         DECIMAL(14,2),
	 CR06         DECIMAL(14,2),
	 SF06         DECIMAL(14,2),
	 SI07MANUAL   INT,
	 SI07M        DECIMAL(14,2),
	 SI07         AS (CASE WHEN SI07MANUAL = 1 THEN SI07M ELSE SF06 END),
	 DB07         DECIMAL(14,2),
	 CR07         DECIMAL(14,2),
	 SF07         DECIMAL(14,2),
	 SI08MANUAL   INT,
	 SI08M        DECIMAL(14,2),
	 SI08         AS (CASE WHEN SI08MANUAL = 1 THEN SI08M ELSE SF07 END),
	 DB08         DECIMAL(14,2),
	 CR08         DECIMAL(14,2),
	 SF08         DECIMAL(14,2),
	 SI09MANUAL   INT,
	 SI09M        DECIMAL(14,2),
	 SI09         AS (CASE WHEN SI09MANUAL = 1 THEN SI09M ELSE SF08 END),
	 DB09         DECIMAL(14,2),
	 CR09         DECIMAL(14,2),
	 SF09         DECIMAL(14,2),
	 SI10MANUAL   INT,
	 SI10M        DECIMAL(14,2),
	 SI10         AS (CASE WHEN SI10MANUAL = 1 THEN SI10M ELSE SF09 END),
	 DB10         DECIMAL(14,2),
	 CR10         DECIMAL(14,2),
	 SF10         DECIMAL(14,2),
	 SI11MANUAL   INT,
	 SI11M        DECIMAL(14,2),
	 SI11         AS (CASE WHEN SI11MANUAL = 1 THEN SI11M ELSE SF10 END),
	 DB11         DECIMAL(14,2),
	 CR11         DECIMAL(14,2),
	 SF11         DECIMAL(14,2),
	 SI12MANUAL   INT,
	 SI12M        DECIMAL(14,2),
	 SI12         AS (CASE WHEN SI12MANUAL = 1 THEN SI12M ELSE SF11 END),
	 DB12         DECIMAL(14,2),
	 CR12         DECIMAL(14,2),
	 SF12         DECIMAL(14,2))
	ALTER TABLE SXT2007
	ADD CONSTRAINT SXT2007_LLAVEPPAL
	PRIMARY KEY CLUSTERED (COMPANIA, ANO, CCOSTO, CUENTA, IDTERCERO, N_FACTURA, CODUNG, CODPRG)
	-- 072
	PRINT '-- A�os 2008'
	CREATE TABLE DBO.SXT2008 (
	 COMPANIA     VARCHAR(2)  NOT NULL,
	 ANO          INT         NOT NULL CHECK (ANO = 2008),
	 CCOSTO       VARCHAR(20) NOT NULL,
	 CUENTA       VARCHAR(16) NOT NULL,
	 IDTERCERO    VARCHAR(20) NOT NULL,
	 N_FACTURA    VARCHAR(20) NOT NULL,
	 CODUNG       VARCHAR(5) NOT NULL,
	 CODPRG       VARCHAR(20) NOT NULL,
	 SI01MANUAL   INT,
	 SI01M        DECIMAL(14,2),
	 SF01AA       DECIMAL(14,2),
	 SI01         AS (CASE WHEN SI01MANUAL = 1 THEN SI01M ELSE SF01AA END),
	 DB01         DECIMAL(14,2),
	 CR01         DECIMAL(14,2),
	 SF01         DECIMAL(14,2),
	 SI02MANUAL   INT,
	 SI02M        DECIMAL(14,2),
	 SI02         AS (CASE WHEN SI02MANUAL = 1 THEN SI02M ELSE SF01 END),
	 DB02         DECIMAL(14,2),
	 CR02         DECIMAL(14,2),
	 SF02         DECIMAL(14,2),
	 SI03MANUAL   INT,
	 SI03M        DECIMAL(14,2),
	 SI03         AS (CASE WHEN SI03MANUAL = 1 THEN SI03M ELSE SF02 END),
	 DB03         DECIMAL(14,2),
	 CR03         DECIMAL(14,2),
	 SF03         DECIMAL(14,2),
	 SI04MANUAL   INT,
	 SI04M        DECIMAL(14,2),
	 SI04         AS (CASE WHEN SI04MANUAL = 1 THEN SI04M ELSE SF03 END),
	 DB04         DECIMAL(14,2),
	 CR04         DECIMAL(14,2),
	 SF04         DECIMAL(14,2),
	 SI05MANUAL   INT,
	 SI05M        DECIMAL(14,2),
	 SI05         AS (CASE WHEN SI05MANUAL = 1 THEN SI05M ELSE SF04 END),
	 DB05         DECIMAL(14,2),
	 CR05         DECIMAL(14,2),
	 SF05         DECIMAL(14,2),
	 SI06MANUAL   INT,
	 SI06M        DECIMAL(14,2),
	 SI06         AS (CASE WHEN SI06MANUAL = 1 THEN SI06M ELSE SF05 END),
	 DB06         DECIMAL(14,2),
	 CR06         DECIMAL(14,2),
	 SF06         DECIMAL(14,2),
	 SI07MANUAL   INT,
	 SI07M        DECIMAL(14,2),
	 SI07         AS (CASE WHEN SI07MANUAL = 1 THEN SI07M ELSE SF06 END),
	 DB07         DECIMAL(14,2),
	 CR07         DECIMAL(14,2),
	 SF07         DECIMAL(14,2),
	 SI08MANUAL   INT,
	 SI08M        DECIMAL(14,2),
	 SI08         AS (CASE WHEN SI08MANUAL = 1 THEN SI08M ELSE SF07 END),
	 DB08         DECIMAL(14,2),
	 CR08         DECIMAL(14,2),
	 SF08         DECIMAL(14,2),
	 SI09MANUAL   INT,
	 SI09M        DECIMAL(14,2),
	 SI09         AS (CASE WHEN SI09MANUAL = 1 THEN SI09M ELSE SF08 END),
	 DB09         DECIMAL(14,2),
	 CR09         DECIMAL(14,2),
	 SF09         DECIMAL(14,2),
	 SI10MANUAL   INT,
	 SI10M        DECIMAL(14,2),
	 SI10         AS (CASE WHEN SI10MANUAL = 1 THEN SI10M ELSE SF09 END),
	 DB10         DECIMAL(14,2),
	 CR10         DECIMAL(14,2),
	 SF10         DECIMAL(14,2),
	 SI11MANUAL   INT,
	 SI11M        DECIMAL(14,2),
	 SI11         AS (CASE WHEN SI11MANUAL = 1 THEN SI11M ELSE SF10 END),
	 DB11         DECIMAL(14,2),
	 CR11         DECIMAL(14,2),
	 SF11         DECIMAL(14,2),
	 SI12MANUAL   INT,
	 SI12M        DECIMAL(14,2),
	 SI12         AS (CASE WHEN SI12MANUAL = 1 THEN SI12M ELSE SF11 END),
	 DB12         DECIMAL(14,2),
	 CR12         DECIMAL(14,2),
	 SF12         DECIMAL(14,2))
	ALTER TABLE SXT2008
	ADD CONSTRAINT SXT2008_LLAVEPPAL
	PRIMARY KEY CLUSTERED (COMPANIA, ANO, CCOSTO, CUENTA, IDTERCERO, N_FACTURA, CODUNG, CODPRG)
	-- 073
	PRINT '-- A�os 2008MA'
	CREATE TABLE DBO.SXT2008MA (
	 COMPANIA     VARCHAR(2)  NOT NULL,
	 ANO          INT         NOT NULL CHECK (ANO > 2008),
	 CCOSTO       VARCHAR(20) NOT NULL,
	 CUENTA       VARCHAR(16) NOT NULL,
	 IDTERCERO    VARCHAR(20) NOT NULL,
	 N_FACTURA    VARCHAR(20) NOT NULL,
	 CODUNG       VARCHAR(5) NOT NULL,
	 CODPRG       VARCHAR(20) NOT NULL,
	 SI01MANUAL   INT,
	 SI01M        DECIMAL(14,2),
	 SF01AA       DECIMAL(14,2),
	 SI01         AS (CASE WHEN SI01MANUAL = 1 THEN SI01M ELSE SF01AA END),
	 DB01         DECIMAL(14,2),
	 CR01         DECIMAL(14,2),
	 SF01         DECIMAL(14,2),
	 SI02MANUAL   INT,
	 SI02M        DECIMAL(14,2),
	 SI02         AS (CASE WHEN SI02MANUAL = 1 THEN SI02M ELSE SF01 END),
	 DB02         DECIMAL(14,2),
	 CR02         DECIMAL(14,2),
	 SF02         DECIMAL(14,2),
	 SI03MANUAL   INT,
	 SI03M        DECIMAL(14,2),
	 SI03         AS (CASE WHEN SI03MANUAL = 1 THEN SI03M ELSE SF02 END),
	 DB03         DECIMAL(14,2),
	 CR03         DECIMAL(14,2),
	 SF03         DECIMAL(14,2),
	 SI04MANUAL   INT,
	 SI04M        DECIMAL(14,2),
	 SI04         AS (CASE WHEN SI04MANUAL = 1 THEN SI04M ELSE SF03 END),
	 DB04         DECIMAL(14,2),
	 CR04         DECIMAL(14,2),
	 SF04         DECIMAL(14,2),
	 SI05MANUAL   INT,
	 SI05M        DECIMAL(14,2),
	 SI05         AS (CASE WHEN SI05MANUAL = 1 THEN SI05M ELSE SF04 END),
	 DB05         DECIMAL(14,2),
	 CR05         DECIMAL(14,2),
	 SF05         DECIMAL(14,2),
	 SI06MANUAL   INT,
	 SI06M        DECIMAL(14,2),
	 SI06         AS (CASE WHEN SI06MANUAL = 1 THEN SI06M ELSE SF05 END),
	 DB06         DECIMAL(14,2),
	 CR06         DECIMAL(14,2),
	 SF06         DECIMAL(14,2),
	 SI07MANUAL   INT,
	 SI07M        DECIMAL(14,2),
	 SI07         AS (CASE WHEN SI07MANUAL = 1 THEN SI07M ELSE SF06 END),
	 DB07         DECIMAL(14,2),
	 CR07         DECIMAL(14,2),
	 SF07         DECIMAL(14,2),
	 SI08MANUAL   INT,
	 SI08M        DECIMAL(14,2),
	 SI08         AS (CASE WHEN SI08MANUAL = 1 THEN SI08M ELSE SF07 END),
	 DB08         DECIMAL(14,2),
	 CR08         DECIMAL(14,2),
	 SF08         DECIMAL(14,2),
	 SI09MANUAL   INT,
	 SI09M        DECIMAL(14,2),
	 SI09         AS (CASE WHEN SI09MANUAL = 1 THEN SI09M ELSE SF08 END),
	 DB09         DECIMAL(14,2),
	 CR09         DECIMAL(14,2),
	 SF09         DECIMAL(14,2),
	 SI10MANUAL   INT,
	 SI10M        DECIMAL(14,2),
	 SI10         AS (CASE WHEN SI10MANUAL = 1 THEN SI10M ELSE SF09 END),
	 DB10         DECIMAL(14,2),
	 CR10         DECIMAL(14,2),
	 SF10         DECIMAL(14,2),
	 SI11MANUAL   INT,
	 SI11M        DECIMAL(14,2),
	 SI11         AS (CASE WHEN SI11MANUAL = 1 THEN SI11M ELSE SF10 END),
	 DB11         DECIMAL(14,2),
	 CR11         DECIMAL(14,2),
	 SF11         DECIMAL(14,2),
	 SI12MANUAL   INT,
	 SI12M        DECIMAL(14,2),
	 SI12         AS (CASE WHEN SI12MANUAL = 1 THEN SI12M ELSE SF11 END),
	 DB12         DECIMAL(14,2),
	 CR12         DECIMAL(14,2),
	 SF12         DECIMAL(14,2))
	ALTER TABLE SXT2008MA
	ADD CONSTRAINT SXT2008MA_LLAVEPPAL
	PRIMARY KEY CLUSTERED (COMPANIA, ANO, CCOSTO, CUENTA, IDTERCERO, N_FACTURA, CODUNG, CODPRG)
    PRINT 'CREA VWK_SXT'
	EXEC ('
	CREATE VIEW DBO.VWK_SXT WITH SCHEMABINDING
	AS
	 SELECT COMPANIA,ANO,CCOSTO,CUENTA,IDTERCERO,N_FACTURA,SI01MANUAL,SI01M,SF01AA,SI01,DB01,CR01,SF01,SI02MANUAL,SI02M,SI02,DB02,CR02,SF02,SI03MANUAL,
			SI03M,SI03,DB03,CR03,SF03,SI04MANUAL,SI04M,SI04,DB04,CR04,SF04,SI05MANUAL,SI05M,SI05,DB05,CR05,SF05,SI06MANUAL,SI06M,SI06,DB06,CR06,SF06,
			SI07MANUAL,SI07M,SI07,DB07,CR07,SF07,SI08MANUAL,SI08M,SI08,DB08,CR08,SF08,SI09MANUAL,SI09M,SI09,DB09,CR09,SF09,SI10MANUAL,SI10M,SI10,DB10,
			CR10,SF10,SI11MANUAL,SI11M,SI11,DB11,CR11,SF11,SI12MANUAL,SI12M,SI12,DB12,CR12,SF12,CODUNG,CODPRG
	 FROM DBO.SXT2004ME 
	 UNION ALL
	 SELECT COMPANIA,ANO,CCOSTO,CUENTA,IDTERCERO,N_FACTURA,SI01MANUAL,SI01M,SF01AA,SI01,DB01,CR01,SF01,SI02MANUAL,SI02M,SI02,DB02,CR02,SF02,SI03MANUAL,
			SI03M,SI03,DB03,CR03,SF03,SI04MANUAL,SI04M,SI04,DB04,CR04,SF04,SI05MANUAL,SI05M,SI05,DB05,CR05,SF05,SI06MANUAL,SI06M,SI06,DB06,CR06,SF06,
			SI07MANUAL,SI07M,SI07,DB07,CR07,SF07,SI08MANUAL,SI08M,SI08,DB08,CR08,SF08,SI09MANUAL,SI09M,SI09,DB09,CR09,SF09,SI10MANUAL,SI10M,SI10,DB10,
			CR10,SF10,SI11MANUAL,SI11M,SI11,DB11,CR11,SF11,SI12MANUAL,SI12M,SI12,DB12,CR12,SF12,CODUNG,CODPRG
	 FROM DBO.SXT2004 
	 UNION ALL
	 SELECT COMPANIA,ANO,CCOSTO,CUENTA,IDTERCERO,N_FACTURA,SI01MANUAL,SI01M,SF01AA,SI01,DB01,CR01,SF01,SI02MANUAL,SI02M,SI02,DB02,CR02,SF02,SI03MANUAL,
			SI03M,SI03,DB03,CR03,SF03,SI04MANUAL,SI04M,SI04,DB04,CR04,SF04,SI05MANUAL,SI05M,SI05,DB05,CR05,SF05,SI06MANUAL,SI06M,SI06,DB06,CR06,SF06,
			SI07MANUAL,SI07M,SI07,DB07,CR07,SF07,SI08MANUAL,SI08M,SI08,DB08,CR08,SF08,SI09MANUAL,SI09M,SI09,DB09,CR09,SF09,SI10MANUAL,SI10M,SI10,DB10,
			CR10,SF10,SI11MANUAL,SI11M,SI11,DB11,CR11,SF11,SI12MANUAL,SI12M,SI12,DB12,CR12,SF12,CODUNG,CODPRG
	 FROM DBO.SXT2005 
	 UNION ALL
	 SELECT COMPANIA,ANO,CCOSTO,CUENTA,IDTERCERO,N_FACTURA,SI01MANUAL,SI01M,SF01AA,SI01,DB01,CR01,SF01,SI02MANUAL,SI02M,SI02,DB02,CR02,SF02,SI03MANUAL,
			SI03M,SI03,DB03,CR03,SF03,SI04MANUAL,SI04M,SI04,DB04,CR04,SF04,SI05MANUAL,SI05M,SI05,DB05,CR05,SF05,SI06MANUAL,SI06M,SI06,DB06,CR06,SF06,
			SI07MANUAL,SI07M,SI07,DB07,CR07,SF07,SI08MANUAL,SI08M,SI08,DB08,CR08,SF08,SI09MANUAL,SI09M,SI09,DB09,CR09,SF09,SI10MANUAL,SI10M,SI10,DB10,
			CR10,SF10,SI11MANUAL,SI11M,SI11,DB11,CR11,SF11,SI12MANUAL,SI12M,SI12,DB12,CR12,SF12,CODUNG,CODPRG
	 FROM DBO.SXT2006   
	 UNION ALL
	 SELECT COMPANIA,ANO,CCOSTO,CUENTA,IDTERCERO,N_FACTURA,SI01MANUAL,SI01M,SF01AA,SI01,DB01,CR01,SF01,SI02MANUAL,SI02M,SI02,DB02,CR02,SF02,SI03MANUAL,
			SI03M,SI03,DB03,CR03,SF03,SI04MANUAL,SI04M,SI04,DB04,CR04,SF04,SI05MANUAL,SI05M,SI05,DB05,CR05,SF05,SI06MANUAL,SI06M,SI06,DB06,CR06,SF06,
			SI07MANUAL,SI07M,SI07,DB07,CR07,SF07,SI08MANUAL,SI08M,SI08,DB08,CR08,SF08,SI09MANUAL,SI09M,SI09,DB09,CR09,SF09,SI10MANUAL,SI10M,SI10,DB10,
			CR10,SF10,SI11MANUAL,SI11M,SI11,DB11,CR11,SF11,SI12MANUAL,SI12M,SI12,DB12,CR12,SF12,CODUNG,CODPRG
	 FROM DBO.SXT2007 
	 UNION ALL
	 SELECT COMPANIA,ANO,CCOSTO,CUENTA,IDTERCERO,N_FACTURA,SI01MANUAL,SI01M,SF01AA,SI01,DB01,CR01,SF01,SI02MANUAL,SI02M,SI02,DB02,CR02,SF02,SI03MANUAL,
			SI03M,SI03,DB03,CR03,SF03,SI04MANUAL,SI04M,SI04,DB04,CR04,SF04,SI05MANUAL,SI05M,SI05,DB05,CR05,SF05,SI06MANUAL,SI06M,SI06,DB06,CR06,SF06,
			SI07MANUAL,SI07M,SI07,DB07,CR07,SF07,SI08MANUAL,SI08M,SI08,DB08,CR08,SF08,SI09MANUAL,SI09M,SI09,DB09,CR09,SF09,SI10MANUAL,SI10M,SI10,DB10,
			CR10,SF10,SI11MANUAL,SI11M,SI11,DB11,CR11,SF11,SI12MANUAL,SI12M,SI12,DB12,CR12,SF12,CODUNG,CODPRG
	 FROM DBO.SXT2008 
	 UNION ALL
	 SELECT COMPANIA,ANO,CCOSTO,CUENTA,IDTERCERO,N_FACTURA,SI01MANUAL,SI01M,SF01AA,SI01,DB01,CR01,SF01,SI02MANUAL,SI02M,SI02,DB02,CR02,SF02,SI03MANUAL,
			SI03M,SI03,DB03,CR03,SF03,SI04MANUAL,SI04M,SI04,DB04,CR04,SF04,SI05MANUAL,SI05M,SI05,DB05,CR05,SF05,SI06MANUAL,SI06M,SI06,DB06,CR06,SF06,
			SI07MANUAL,SI07M,SI07,DB07,CR07,SF07,SI08MANUAL,SI08M,SI08,DB08,CR08,SF08,SI09MANUAL,SI09M,SI09,DB09,CR09,SF09,SI10MANUAL,SI10M,SI10,DB10,
			CR10,SF10,SI11MANUAL,SI11M,SI11,DB11,CR11,SF11,SI12MANUAL,SI12M,SI12,DB12,CR12,SF12,CODUNG,CODPRG
	 FROM DBO.SXT2008MA')

    PRINT 'CREA VWK_SALDOS_CONTABLES'
	EXEC ('
	CREATE VIEW DBO.VWK_SALDOS_CONTABLES WITH SCHEMABINDING
	AS  
	  SELECT A.COMPANIA, A.ANO, MES = 1, A.CCOSTO, A.CUENTA, CUE.NOMCUENTA, A.IDTERCERO, TER.RAZONSOCIAL, A.N_FACTURA, A.CODUNG, A.CODPRG, 
			 SI = A.SI01,  
			 DB = A.DB01,  
			 CR = A.CR01,  
			 SF = A.SF01           
	  FROM DBO.VWK_SXT A WITH(UPDLOCK) LEFT JOIN   
		   DBO.TER ON A.IDTERCERO=TER.IDTERCERO LEFT JOIN
		   DBO.CUE ON A.COMPANIA=CUE.COMPANIA AND A.CUENTA=CUE.CUENTA
	  UNION ALL
	  SELECT A.COMPANIA, A.ANO, MES = 2, A.CCOSTO, A.CUENTA, CUE.NOMCUENTA, A.IDTERCERO, TER.RAZONSOCIAL, A.N_FACTURA, A.CODUNG, A.CODPRG, 
			 A.SI02,  
			 A.DB02,  
			 A.CR02,  
			 A.SF02           
	  FROM DBO.VWK_SXT A WITH(UPDLOCK) LEFT JOIN   
		   DBO.TER ON A.IDTERCERO=TER.IDTERCERO LEFT JOIN
		   DBO.CUE ON A.COMPANIA=CUE.COMPANIA AND A.CUENTA=CUE.CUENTA
	  UNION ALL
	  SELECT A.COMPANIA, A.ANO, MES = 3, A.CCOSTO, A.CUENTA, CUE.NOMCUENTA, A.IDTERCERO, TER.RAZONSOCIAL, A.N_FACTURA, A.CODUNG, A.CODPRG, 
			 A.SI03,  
			 A.DB03,  
			 A.CR03,  
			 A.SF03           
	  FROM DBO.VWK_SXT A WITH(UPDLOCK) LEFT JOIN   
		   DBO.TER ON A.IDTERCERO=TER.IDTERCERO LEFT JOIN
		   DBO.CUE ON A.COMPANIA=CUE.COMPANIA AND A.CUENTA=CUE.CUENTA
	  UNION ALL
	  SELECT A.COMPANIA, A.ANO, MES = 4, A.CCOSTO, A.CUENTA, CUE.NOMCUENTA, A.IDTERCERO, TER.RAZONSOCIAL, A.N_FACTURA, A.CODUNG, A.CODPRG, 
			 A.SI04,  
			 A.DB04,  
			 A.CR04,  
			 A.SF04           
	  FROM DBO.VWK_SXT A WITH(UPDLOCK) LEFT JOIN   
		   DBO.TER ON A.IDTERCERO=TER.IDTERCERO LEFT JOIN
		   DBO.CUE ON A.COMPANIA=CUE.COMPANIA AND A.CUENTA=CUE.CUENTA
	  UNION ALL
	  SELECT A.COMPANIA, A.ANO, MES = 5, A.CCOSTO, A.CUENTA, CUE.NOMCUENTA, A.IDTERCERO, TER.RAZONSOCIAL, A.N_FACTURA, A.CODUNG, A.CODPRG, 
			 A.SI05,  
			 A.DB05,  
			 A.CR05,  
			 A.SF05           
	  FROM DBO.VWK_SXT A WITH(UPDLOCK) LEFT JOIN   
		   DBO.TER ON A.IDTERCERO=TER.IDTERCERO LEFT JOIN
		   DBO.CUE ON A.COMPANIA=CUE.COMPANIA AND A.CUENTA=CUE.CUENTA
	  UNION ALL
	  SELECT A.COMPANIA, A.ANO, MES = 6, A.CCOSTO, A.CUENTA, CUE.NOMCUENTA, A.IDTERCERO, TER.RAZONSOCIAL, A.N_FACTURA, A.CODUNG, A.CODPRG, 
			 A.SI06,  
			 A.DB06,  
			 A.CR06,  
			 A.SF06           
	  FROM DBO.VWK_SXT A WITH(UPDLOCK) LEFT JOIN   
		   DBO.TER ON A.IDTERCERO=TER.IDTERCERO LEFT JOIN
		   DBO.CUE ON A.COMPANIA=CUE.COMPANIA AND A.CUENTA=CUE.CUENTA
	  UNION ALL
	  SELECT A.COMPANIA, A.ANO, MES = 7, A.CCOSTO, A.CUENTA, CUE.NOMCUENTA, A.IDTERCERO, TER.RAZONSOCIAL, A.N_FACTURA, A.CODUNG, A.CODPRG, 
			 A.SI07,  
			 A.DB07,  
			 A.CR07,  
			 A.SF07           
	  FROM DBO.VWK_SXT A WITH(UPDLOCK) LEFT JOIN   
		   DBO.TER ON A.IDTERCERO=TER.IDTERCERO LEFT JOIN
		   DBO.CUE ON A.COMPANIA=CUE.COMPANIA AND A.CUENTA=CUE.CUENTA
	  UNION ALL
	  SELECT A.COMPANIA, A.ANO, MES = 8, A.CCOSTO, A.CUENTA, CUE.NOMCUENTA, A.IDTERCERO, TER.RAZONSOCIAL, A.N_FACTURA, A.CODUNG, A.CODPRG, 
			 A.SI08,  
			 A.DB08,  
			 A.CR08,  
			 A.SF08           
	  FROM DBO.VWK_SXT A WITH(UPDLOCK) LEFT JOIN   
		   DBO.TER ON A.IDTERCERO=TER.IDTERCERO LEFT JOIN
		   DBO.CUE ON A.COMPANIA=CUE.COMPANIA AND A.CUENTA=CUE.CUENTA
	  UNION ALL
	  SELECT A.COMPANIA, A.ANO, MES = 9, A.CCOSTO, A.CUENTA, CUE.NOMCUENTA, A.IDTERCERO, TER.RAZONSOCIAL, A.N_FACTURA, A.CODUNG, A.CODPRG, 
			 A.SI09,  
			 A.DB09,  
			 A.CR09,  
			 A.SF09           
	  FROM DBO.VWK_SXT A WITH(UPDLOCK) LEFT JOIN   
		   DBO.TER ON A.IDTERCERO=TER.IDTERCERO LEFT JOIN
		   DBO.CUE ON A.COMPANIA=CUE.COMPANIA AND A.CUENTA=CUE.CUENTA
	  UNION ALL
	  SELECT A.COMPANIA, A.ANO, MES = 10, A.CCOSTO, A.CUENTA, CUE.NOMCUENTA, A.IDTERCERO, TER.RAZONSOCIAL, A.N_FACTURA, A.CODUNG, A.CODPRG, 
			 A.SI10,  
			 A.DB10,  
			 A.CR10,  
			 A.SF10           
	  FROM DBO.VWK_SXT A WITH(UPDLOCK) LEFT JOIN   
		   DBO.TER ON A.IDTERCERO=TER.IDTERCERO LEFT JOIN
		   DBO.CUE ON A.COMPANIA=CUE.COMPANIA AND A.CUENTA=CUE.CUENTA
	  UNION ALL
	  SELECT A.COMPANIA, A.ANO, MES = 11, A.CCOSTO, A.CUENTA, CUE.NOMCUENTA, A.IDTERCERO, TER.RAZONSOCIAL, A.N_FACTURA, A.CODUNG, A.CODPRG, 
			 A.SI11,  
			 A.DB11,  
			 A.CR11,  
			 A.SF11           
	  FROM DBO.VWK_SXT A WITH(UPDLOCK) LEFT JOIN   
		   DBO.TER ON A.IDTERCERO=TER.IDTERCERO LEFT JOIN
		   DBO.CUE ON A.COMPANIA=CUE.COMPANIA AND A.CUENTA=CUE.CUENTA
	  UNION ALL
	  SELECT A.COMPANIA, A.ANO, MES = 12, A.CCOSTO, A.CUENTA, CUE.NOMCUENTA, A.IDTERCERO, TER.RAZONSOCIAL, A.N_FACTURA, A.CODUNG, A.CODPRG, 
			 A.SI12,  
			 A.DB12,  
			 A.CR12,  
			 A.SF12           
	  FROM DBO.VWK_SXT A WITH(UPDLOCK) LEFT JOIN   
		   DBO.TER ON A.IDTERCERO=TER.IDTERCERO LEFT JOIN
		   DBO.CUE ON A.COMPANIA=CUE.COMPANIA AND A.CUENTA=CUE.CUENTA')
--------------------------------------------------------------------------------
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

GO

