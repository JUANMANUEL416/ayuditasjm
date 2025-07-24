USE [KHNSPILARN]
GO

/****** Object:  Table [dbo].[PTPTOI]    Script Date: 19/12/2023 5:42:12 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PTPTOI](
	[COMPANIA] [varchar](2) NOT NULL,
	[CONSECUTIVO] [varchar](20) NOT NULL,
	[CLASE] [varchar](10) NOT NULL,
	[RUBRO] [varchar](50) NOT NULL,
	[ANO] [decimal](7, 0) NULL,
	[SFA] [decimal](14, 2) NULL,
	[SI01] [decimal](14, 2) NULL,
	[TDB01] [decimal](14, 2) NULL,
	[TCR01] [decimal](14, 2) NULL,
	[MDB01] [decimal](14, 2) NULL,
	[MCR01] [decimal](14, 2) NULL,
	[RECO01] [decimal](14, 2) NULL,
	[RECA01] [decimal](14, 2) NULL,
	[SI02] [decimal](14, 2) NULL,
	[TDB02] [decimal](14, 2) NULL,
	[TCR02] [decimal](14, 2) NULL,
	[MDB02] [decimal](14, 2) NULL,
	[MCR02] [decimal](14, 2) NULL,
	[RECO02] [decimal](14, 2) NULL,
	[RECA02] [decimal](14, 2) NULL,
	[SI03] [decimal](14, 2) NULL,
	[TDB03] [decimal](14, 2) NULL,
	[TCR03] [decimal](14, 2) NULL,
	[MDB03] [decimal](14, 2) NULL,
	[MCR03] [decimal](14, 2) NULL,
	[RECO03] [decimal](14, 2) NULL,
	[RECA03] [decimal](14, 2) NULL,
	[SI04] [decimal](14, 2) NULL,
	[TDB04] [decimal](14, 2) NULL,
	[TCR04] [decimal](14, 2) NULL,
	[MDB04] [decimal](14, 2) NULL,
	[MCR04] [decimal](14, 2) NULL,
	[RECO04] [decimal](14, 2) NULL,
	[RECA04] [decimal](14, 2) NULL,
	[SI05] [decimal](14, 2) NULL,
	[TDB05] [decimal](14, 2) NULL,
	[TCR05] [decimal](14, 2) NULL,
	[MDB05] [decimal](14, 2) NULL,
	[MCR05] [decimal](14, 2) NULL,
	[RECO05] [decimal](14, 2) NULL,
	[RECA05] [decimal](14, 2) NULL,
	[SI06] [decimal](14, 2) NULL,
	[TDB06] [decimal](14, 2) NULL,
	[TCR06] [decimal](14, 2) NULL,
	[MDB06] [decimal](14, 2) NULL,
	[MCR06] [decimal](14, 2) NULL,
	[RECO06] [decimal](14, 2) NULL,
	[RECA06] [decimal](14, 2) NULL,
	[SI07] [decimal](14, 2) NULL,
	[TDB07] [decimal](14, 2) NULL,
	[TCR07] [decimal](14, 2) NULL,
	[MDB07] [decimal](14, 2) NULL,
	[MCR07] [decimal](14, 2) NULL,
	[RECO07] [decimal](14, 2) NULL,
	[RECA07] [decimal](14, 2) NULL,
	[SI08] [decimal](14, 2) NULL,
	[TDB08] [decimal](14, 2) NULL,
	[TCR08] [decimal](14, 2) NULL,
	[MDB08] [decimal](14, 2) NULL,
	[MCR08] [decimal](14, 2) NULL,
	[RECO08] [decimal](14, 2) NULL,
	[RECA08] [decimal](14, 2) NULL,
	[SI09] [decimal](14, 2) NULL,
	[TDB09] [decimal](14, 2) NULL,
	[TCR09] [decimal](14, 2) NULL,
	[MDB09] [decimal](14, 2) NULL,
	[MCR09] [decimal](14, 2) NULL,
	[RECO09] [decimal](14, 2) NULL,
	[RECA09] [decimal](14, 2) NULL,
	[SI10] [decimal](14, 2) NULL,
	[TDB10] [decimal](14, 2) NULL,
	[TCR10] [decimal](14, 2) NULL,
	[MDB10] [decimal](14, 2) NULL,
	[MCR10] [decimal](14, 2) NULL,
	[RECO10] [decimal](14, 2) NULL,
	[RECA10] [decimal](14, 2) NULL,
	[SI11] [decimal](14, 2) NULL,
	[TDB11] [decimal](14, 2) NULL,
	[TCR11] [decimal](14, 2) NULL,
	[MDB11] [decimal](14, 2) NULL,
	[MCR11] [decimal](14, 2) NULL,
	[RECO11] [decimal](14, 2) NULL,
	[RECA11] [decimal](14, 2) NULL,
	[SI12] [decimal](14, 2) NULL,
	[TDB12] [decimal](14, 2) NULL,
	[TCR12] [decimal](14, 2) NULL,
	[MDB12] [decimal](14, 2) NULL,
	[MCR12] [decimal](14, 2) NULL,
	[RECO12] [decimal](14, 2) NULL,
	[RECA12] [decimal](14, 2) NULL,
	[CCOSTO] [varchar](20) NOT NULL,
	[MSALDOXMES] [smallint] NULL,
	[IDTIPOMOV] [varchar](2) NULL,
	[DISRECO01] [decimal](14, 2) NULL,
	[DISRECO02] [decimal](14, 2) NULL,
	[DISRECO03] [decimal](14, 2) NULL,
	[DISRECO04] [decimal](14, 2) NULL,
	[DISRECO05] [decimal](14, 2) NULL,
	[DISRECO06] [decimal](14, 2) NULL,
	[DISRECO07] [decimal](14, 2) NULL,
	[DISRECO08] [decimal](14, 2) NULL,
	[DISRECO09] [decimal](14, 2) NULL,
	[DISRECO10] [decimal](14, 2) NULL,
	[DISRECO11] [decimal](14, 2) NULL,
	[DISRECO12] [decimal](14, 2) NULL,
	[DISRECA01] [decimal](14, 2) NULL,
	[DISRECA02] [decimal](14, 2) NULL,
	[DISRECA03] [decimal](14, 2) NULL,
	[DISRECA04] [decimal](14, 2) NULL,
	[DISRECA05] [decimal](14, 2) NULL,
	[DISRECA06] [decimal](14, 2) NULL,
	[DISRECA07] [decimal](14, 2) NULL,
	[DISRECA08] [decimal](14, 2) NULL,
	[DISRECA09] [decimal](14, 2) NULL,
	[DISRECA10] [decimal](14, 2) NULL,
	[DISRECA11] [decimal](14, 2) NULL,
	[DISRECA12] [decimal](14, 2) NULL,
	[SF01]  AS (((((([SFA]+[SI01])+[TDB01])-[TCR01])+[MDB01])-[MCR01])-[DISRECO01]),
	[SF02]  AS ((((([SI02]+[TDB02])-[TCR02])+[MDB02])-[MCR02])-[DISRECO02]),
	[SF03]  AS ((((([SI03]+[TDB03])-[TCR03])+[MDB03])-[MCR03])-[DISRECO03]),
	[SF04]  AS ((((([SI04]+[TDB04])-[TCR04])+[MDB04])-[MCR04])-[DISRECO04]),
	[SF05]  AS ((((([SI05]+[TDB05])-[TCR05])+[MDB05])-[MCR05])-[DISRECO05]),
	[SF06]  AS ((((([SI06]+[TDB06])-[TCR06])+[MDB06])-[MCR06])-[DISRECO06]),
	[SF07]  AS ((((([SI07]+[TDB07])-[TCR07])+[MDB07])-[MCR07])-[DISRECO07]),
	[SF08]  AS ((((([SI08]+[TDB08])-[TCR08])+[MDB08])-[MCR08])-[DISRECO08]),
	[SF09]  AS ((((([SI09]+[TDB09])-[TCR09])+[MDB09])-[MCR09])-[DISRECO09]),
	[SF10]  AS ((((([SI10]+[TDB10])-[TCR10])+[MDB10])-[MCR10])-[DISRECO10]),
	[SF11]  AS ((((([SI11]+[TDB11])-[TCR11])+[MDB11])-[MCR11])-[DISRECO11]),
	[SF12]  AS ((((([SI12]+[TDB12])-[TCR12])+[MDB12])-[MCR12])-[DISRECO12]),
	[RUBRO_ID] [int] NULL,
	[RECOA01] [decimal](14, 2) NULL,
	[RECOR01] [decimal](14, 2) NULL,
	[RECAA01] [decimal](14, 2) NULL,
	[RECAR01] [decimal](14, 2) NULL,
	[RECOA02] [decimal](14, 2) NULL,
	[RECOR02] [decimal](14, 2) NULL,
	[RECAA02] [decimal](14, 2) NULL,
	[RECAR02] [decimal](14, 2) NULL,
	[RECOA03] [decimal](14, 2) NULL,
	[RECOR03] [decimal](14, 2) NULL,
	[RECAA03] [decimal](14, 2) NULL,
	[RECAR03] [decimal](14, 2) NULL,
	[RECOA04] [decimal](14, 2) NULL,
	[RECOR04] [decimal](14, 2) NULL,
	[RECAA04] [decimal](14, 2) NULL,
	[RECAR04] [decimal](14, 2) NULL,
	[RECOA05] [decimal](14, 2) NULL,
	[RECOR05] [decimal](14, 2) NULL,
	[RECAA05] [decimal](14, 2) NULL,
	[RECAR05] [decimal](14, 2) NULL,
	[RECOA06] [decimal](14, 2) NULL,
	[RECOR06] [decimal](14, 2) NULL,
	[RECAA06] [decimal](14, 2) NULL,
	[RECAR06] [decimal](14, 2) NULL,
	[RECOA07] [decimal](14, 2) NULL,
	[RECOR07] [decimal](14, 2) NULL,
	[RECAA07] [decimal](14, 2) NULL,
	[RECAR07] [decimal](14, 2) NULL,
	[RECOA08] [decimal](14, 2) NULL,
	[RECOR08] [decimal](14, 2) NULL,
	[RECAA08] [decimal](14, 2) NULL,
	[RECAR08] [decimal](14, 2) NULL,
	[RECOA09] [decimal](14, 2) NULL,
	[RECOR09] [decimal](14, 2) NULL,
	[RECAA09] [decimal](14, 2) NULL,
	[RECAR09] [decimal](14, 2) NULL,
	[RECOA10] [decimal](14, 2) NULL,
	[RECOR10] [decimal](14, 2) NULL,
	[RECAA10] [decimal](14, 2) NULL,
	[RECAR10] [decimal](14, 2) NULL,
	[RECOA11] [decimal](14, 2) NULL,
	[RECOR11] [decimal](14, 2) NULL,
	[RECAA11] [decimal](14, 2) NULL,
	[RECAR11] [decimal](14, 2) NULL,
	[RECOA12] [decimal](14, 2) NULL,
	[RECOR12] [decimal](14, 2) NULL,
	[RECAA12] [decimal](14, 2) NULL,
	[RECAR12] [decimal](14, 2) NULL,
	[SFRECO]  AS (((((((((((((((((((((((((((((((((((coalesce([RECO01],(0))+coalesce([RECOA01],(0)))+coalesce([RECOR01],(0)))+coalesce([RECO02],(0)))+coalesce([RECOA02],(0)))+coalesce([RECOR02],(0)))+coalesce([RECO03],(0)))+coalesce([RECOA03],(0)))+coalesce([RECOR03],(0)))+coalesce([RECO04],(0)))+coalesce([RECOA04],(0)))+coalesce([RECOR04],(0)))+coalesce([RECO05],(0)))+coalesce([RECOA05],(0)))+coalesce([RECOR05],(0)))+coalesce([RECO06],(0)))+coalesce([RECOA06],(0)))+coalesce([RECOR06],(0)))+coalesce([RECO07],(0)))+coalesce([RECOA07],(0)))+coalesce([RECOR07],(0)))+coalesce([RECO08],(0)))+coalesce([RECOA08],(0)))+coalesce([RECOR08],(0)))+coalesce([RECO09],(0)))+coalesce([RECOA09],(0)))+coalesce([RECOR09],(0)))+coalesce([RECO10],(0)))+coalesce([RECOA10],(0)))+coalesce([RECOR10],(0)))+coalesce([RECO11],(0)))+coalesce([RECOA11],(0)))+coalesce([RECOR11],(0)))+coalesce([RECO12],(0)))+coalesce([RECOA12],(0)))+coalesce([RECOR12],(0))),
	[SFRECA]  AS (((((((((((((((((((((((((((((((((((coalesce([RECA01],(0))+coalesce([RECAA01],(0)))+coalesce([RECAR01],(0)))+coalesce([RECA02],(0)))+coalesce([RECAA02],(0)))+coalesce([RECAR02],(0)))+coalesce([RECA03],(0)))+coalesce([RECAA03],(0)))+coalesce([RECAR03],(0)))+coalesce([RECA04],(0)))+coalesce([RECAA04],(0)))+coalesce([RECAR04],(0)))+coalesce([RECA05],(0)))+coalesce([RECAA05],(0)))+coalesce([RECAR05],(0)))+coalesce([RECA06],(0)))+coalesce([RECAA06],(0)))+coalesce([RECAR06],(0)))+coalesce([RECA07],(0)))+coalesce([RECAA07],(0)))+coalesce([RECAR07],(0)))+coalesce([RECA08],(0)))+coalesce([RECAA08],(0)))+coalesce([RECAR08],(0)))+coalesce([RECA09],(0)))+coalesce([RECAA09],(0)))+coalesce([RECAR09],(0)))+coalesce([RECA10],(0)))+coalesce([RECAA10],(0)))+coalesce([RECAR10],(0)))+coalesce([RECA11],(0)))+coalesce([RECAA11],(0)))+coalesce([RECAR11],(0)))+coalesce([RECA12],(0)))+coalesce([RECAA12],(0)))+coalesce([RECAR12],(0))),
 CONSTRAINT [PTPTOICONSECUTIVO] PRIMARY KEY CLUSTERED 
(
	[CONSECUTIVO] ASC,
	[COMPANIA] ASC,
	[CLASE] ASC,
	[RUBRO] ASC,
	[CCOSTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECO01]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECO02]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECO03]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECO04]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECO05]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECO06]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECO07]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECO08]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECO09]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECO10]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECO11]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECO12]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECA01]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECA02]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECA03]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECA04]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECA05]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECA06]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECA07]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECA08]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECA09]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECA10]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECA11]
GO

ALTER TABLE [dbo].[PTPTOI] ADD  DEFAULT ((0)) FOR [DISRECA12]
GO

ALTER TABLE [dbo].[PTPTOI]  WITH NOCHECK ADD  CONSTRAINT [FK_PTPTOI_PTPTOICONSECUTIVO] FOREIGN KEY([CONSECUTIVO], [COMPANIA])
REFERENCES [dbo].[PTPTO] ([CONSECUTIVO], [COMPANIA])
ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[PTPTOI] CHECK CONSTRAINT [FK_PTPTOI_PTPTOICONSECUTIVO]
GO


