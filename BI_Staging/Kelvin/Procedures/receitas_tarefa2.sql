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
[CÓDIGO_ÓRGÃO_SUPERIOR]
      ,[NOME_ÓRGÃO_SUPERIOR]
      ,[CÓDIGO_ÓRGÃO]
      ,[NOME_ÓRGÃO]
      ,[CÓDIGO_UNIDADE_GESTORA]
      ,[NOME_UNIDADE_GESTORA]
      ,[CATEGORIA_ECONÔMICA]
      ,[ORIGEM_RECEITA]
      ,[ESPÉCIE_RECEITA]
      ,[DETALHAMENTO]
      ,[VALOR_PREVISTO_ATUALIZADO]
      ,[VALOR_LANÇADO]
      ,[VALOR_REALIZADO]
      ,[PERCENTUAL_REALIZADO]
      ,[DATA_LANÇAMENTO]
      ,[ANO_EXERCÍCIO]
into BI_Staging.stg.temp_receitas
from prod.dbo.[2020_Receitas]


IF(OBJECT_ID('BI_Staging.stg.temp_receitas_2') is not null)
		drop table BI_Staging.stg.temp_receitas_2

---select * from [prod].[dbo].[_receitas]

select
[CÓDIGO_ÓRGÃO_SUPERIOR]
      ,[NOME_ÓRGÃO_SUPERIOR]
      ,[CÓDIGO_ÓRGÃO]
      ,[NOME_ÓRGÃO]
      ,[CÓDIGO_UNIDADE_GESTORA]
      ,[NOME_UNIDADE_GESTORA]
      ,[CATEGORIA_ECONÔMICA]
      ,[ORIGEM_RECEITA]
      ,[ESPÉCIE_RECEITA]
      ,[DETALHAMENTO]
      ,[VALOR_PREVISTO_ATUALIZADO]
      ,[VALOR_LANÇADO]
      ,[VALOR_REALIZADO]
      ,[PERCENTUAL_REALIZADO]
      ,[DATA_LANÇAMENTO]
      ,[ANO_EXERCÍCIO]
into  BI_Staging.stg.temp_receitas_2
from prod.dbo.[2021_Receitas]





IF(OBJECT_ID('BI_Staging.stg.temp_receitas_3') is not null)
		drop table BI_Staging.stg.temp_receitas_3

---select * from [prod].[dbo].[_receitas]

select
[CÓDIGO_ÓRGÃO_SUPERIOR]
      ,[NOME_ÓRGÃO_SUPERIOR]
      ,[CÓDIGO_ÓRGÃO]
      ,[NOME_ÓRGÃO]
      ,[CÓDIGO_UNIDADE_GESTORA]
      ,[NOME_UNIDADE_GESTORA]
      ,[CATEGORIA_ECONÔMICA]
      ,[ORIGEM_RECEITA]
      ,[ESPÉCIE_RECEITA]
      ,[DETALHAMENTO]
      ,[VALOR_PREVISTO_ATUALIZADO]
      ,[VALOR_LANÇADO]
      ,[VALOR_REALIZADO]
      ,[PERCENTUAL_REALIZADO]
      ,[DATA_LANÇAMENTO]
      ,[ANO_EXERCÍCIO]
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

