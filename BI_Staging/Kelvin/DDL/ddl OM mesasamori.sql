USE [BI_Staging]
GO

/****** Object:  Table [stg].[OM_Mesasamori]    Script Date: 18/06/2022 21:02:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[OM_Mesasamori](
	[Data] [datetime] NULL,
	[CONTA_REDUZIDA] [float] NULL,
	[COD_AREA] [float] NULL,
	[COD_PACOTE] [float] NULL,
	[COD_CENTRO_CUSTO] [float] NULL,
	[DEBITO_CREDITO] [nvarchar](255) NULL,
	[VALOR_LANCTO] [float] NULL,
	[DESC_CONTA] [nvarchar](255) NULL,
	[DESC_AREA] [nvarchar](255) NULL,
	[DESC_PACOTE] [nvarchar](255) NULL,
	[DESC_CC] [nvarchar](255) NULL,
	[GERENTE] [nvarchar](255) NULL,
	[DIRETOR] [nvarchar](255) NULL,
	[ORIGEM] [varchar](50) NULL
) ON [PRIMARY]
GO


