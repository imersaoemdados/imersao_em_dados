USE [BI_Staging]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [stg].[stp_receitas]
AS BEGIN

	IF(OBJECT_ID('BI_Staging.stg.temp_receitas') is not null)
		drop table BI_Staging.stg.temp_receitas

---select * from [prod].[dbo].[_receitas]

select
[C�DIGO_�RG�O_SUPERIOR]
      ,[NOME_�RG�O_SUPERIOR]
      ,[C�DIGO_�RG�O]
      ,[NOME_�RG�O]
      ,[C�DIGO_UNIDADE_GESTORA]
      ,[NOME_UNIDADE_GESTORA]
      ,[CATEGORIA_ECON�MICA]
      ,[ORIGEM_RECEITA]
      ,[ESP�CIE_RECEITA]
      ,[DETALHAMENTO]
      ,[VALOR_PREVISTO_ATUALIZADO]
      ,[VALOR_LAN�ADO]
      ,[VALOR_REALIZADO]
      ,[PERCENTUAL_REALIZADO]
      ,[DATA_LAN�AMENTO]
      ,[ANO_EXERC�CIO]
into BI_Staging.stg.temp_receitas
from prod.dbo.[2020_Receitas]


IF(OBJECT_ID('BI_Staging.stg.temp_receitas_2') is not null)
		drop table BI_Staging.stg.temp_receitas_2

---select * from [prod].[dbo].[_receitas]

select
[C�DIGO_�RG�O_SUPERIOR]
      ,[NOME_�RG�O_SUPERIOR]
      ,[C�DIGO_�RG�O]
      ,[NOME_�RG�O]
      ,[C�DIGO_UNIDADE_GESTORA]
      ,[NOME_UNIDADE_GESTORA]
      ,[CATEGORIA_ECON�MICA]
      ,[ORIGEM_RECEITA]
      ,[ESP�CIE_RECEITA]
      ,[DETALHAMENTO]
      ,[VALOR_PREVISTO_ATUALIZADO]
      ,[VALOR_LAN�ADO]
      ,[VALOR_REALIZADO]
      ,[PERCENTUAL_REALIZADO]
      ,[DATA_LAN�AMENTO]
      ,[ANO_EXERC�CIO]
into  BI_Staging.stg.temp_receitas_2
from prod.dbo.[2021_Receitas]





IF(OBJECT_ID('BI_Staging.stg.temp_receitas_3') is not null)
		drop table BI_Staging.stg.temp_receitas_3

---select * from [prod].[dbo].[_receitas]

select
[C�DIGO_�RG�O_SUPERIOR]
      ,[NOME_�RG�O_SUPERIOR]
      ,[C�DIGO_�RG�O]
      ,[NOME_�RG�O]
      ,[C�DIGO_UNIDADE_GESTORA]
      ,[NOME_UNIDADE_GESTORA]
      ,[CATEGORIA_ECON�MICA]
      ,[ORIGEM_RECEITA]
      ,[ESP�CIE_RECEITA]
      ,[DETALHAMENTO]
      ,[VALOR_PREVISTO_ATUALIZADO]
      ,[VALOR_LAN�ADO]
      ,[VALOR_REALIZADO]
      ,[PERCENTUAL_REALIZADO]
      ,[DATA_LAN�AMENTO]
      ,[ANO_EXERC�CIO]
into BI_Staging.stg.temp_receitas_3
from prod.dbo.[2022_Receitas]


--select * from   prod.dbo.[2020_Receitas]

TRUNCATE TABLE [stg].[receitas] 

INSERT INTO [stg].[receitas]
SELECT * FROM BI_Staging.stg.temp_receitas


INSERT INTO [stg].[receitas]
SELECT * FROM BI_Staging.stg.temp_receitas_2


INSERT INTO [stg].[receitas]
SELECT * FROM BI_Staging.stg.temp_receitas_3

IF(OBJECT_ID('BI_Staging.stg.temp_receitas') is not null)
		drop table BI_Staging.stg.temp_receitas

		IF(OBJECT_ID('BI_Staging.stg.temp_receitas_2') is not null)
		drop table BI_Staging.stg.temp_receitas_2

		IF(OBJECT_ID('BI_Staging.stg.temp_receitas_3') is not null)
		drop table BI_Staging.stg.temp_receitas_3

end;

