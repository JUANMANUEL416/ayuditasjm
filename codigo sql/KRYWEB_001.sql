CREATE TABLE [dbo].[WUSUSU](
	[USUARIO] [varchar](12) NOT NULL,
	[CLAVE] [varbinary](46) NULL,
	[NOMBRE] [varchar](40) NULL,
	[IDTERCERO] [varchar](20) NULL,
 CONSTRAINT [WEBUSUARIO] PRIMARY KEY CLUSTERED 
(
	[USUARIO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[WLOG](
	[FECHA] [datetime] NULL,
	[USUARIO] [varchar](12) NULL,
	[NOMBRE] [varchar](40) NULL,
	[IDTERCERO] [varchar](20) NULL,
	[RAZONSOCIAL] [varchar](150) NULL,
	[NOADMISION] [varchar](12) NULL,
	[N_PACIENTE] [varchar](40) NULL
) ON [PRIMARY]

GO