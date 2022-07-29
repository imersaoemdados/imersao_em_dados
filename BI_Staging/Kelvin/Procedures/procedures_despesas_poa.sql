USE [BI_Staging]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter PROCEDURE [stg].[stpdespesas_poa]
AS BEGIN

	IF(OBJECT_ID('BI_Staging.stg.temp_despesas_poa') is not null)
		drop table BI_Staging.stg.temp_despesas_poa


select
	cast (data_extracao as date) as data_extracao,
	orgao,
	nome_orgao,
	exercicio,
	mes,
	categoria,
	desc_categoria,
	natureza,
	desc_natureza,
	modalidade,
	desc_modalidade,
	elemento,
	desc_elemento,
	funcao,
	desc_funcao,
	cast(vlemp as float) as vlemp,
	cast(vlliq  as float) as vlliq,
	cast(vlpag as float) as vlpag,
	cast(vlorcini as float) as vlorcini,
	'despesas_poa_2020' as ds_origem
into bi_staging.stg.temp_despesas_poa
from prod.dbo.despesas_poa_2020


TRUNCATE TABLE [stg].[despesaspoa] 

INSERT INTO [stg].[despesaspoa]
SELECT * FROM bi_staging.stg.temp_despesas_poa

IF(OBJECT_ID('BI_Staging.stg.temp_despesas_poa') is not null)
		drop table BI_Staging.stg.temp_despesas_poa


end;