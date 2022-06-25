USE [PROD]
GO

/****** Object:  Table [dbo].[OM_KCCDADOS]    Script Date: 24/06/2022 17:23:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[OM_KCCDADOS](
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
	ORIGEM [VARCHAR] (50)
)


