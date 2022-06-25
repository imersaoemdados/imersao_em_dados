USE [BI_Staging]
GO
/****** Object:  StoredProcedure [stg].[stpOM_kccdados]    Script Date: 24/06/2022 21:14:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [stg].[stpOM_kccdados]
AS BEGIN

	IF(OBJECT_ID('BI_Staging.stg.temp_OM') is not null)
		drop table BI_Staging.stg.temp_OM

select 
Data,
CONTA_REDUZIDA,
COD_AREA,
COD_PACOTE,
COD_CENTRO_CUSTO,
DEBITO_CREDITO,
VALOR_LANCTO,
DESC_CONTA,
DESC_AREA,
DESC_PACOTE,
DESC_CC,
GERENTE,
DIRETOR,
'kccdados' as ORIGEM
into stg.temp_OM 
from PROD.dbo.OM_KCCDADOS

TRUNCATE TABLE [stg].[OM_kccdados]

INSERT INTO [stg].[OM_kccdados]
SELECT * FROM stg.temp_OM

IF(OBJECT_ID('BI_Staging.stg.temp_OM') is not null)
	drop table BI_Staging.stg.temp_OM


end;
