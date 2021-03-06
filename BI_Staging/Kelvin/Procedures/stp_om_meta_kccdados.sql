USE [BI_Staging]
GO
/****** Object:  StoredProcedure [stg].[stpOM_Mesasamori]    Script Date: 18/06/2022 20:55:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [stg].[stpOM_metas_kccdados]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('BI_Staging.stg.temp_OM_metas') IS NOT NULL) 
		DROP TABLE BI_Staging.stg.temp_OM_metas


-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODU??O E COLOCA-OS EM UMA TABELA TEMPOR?RIA
SELECT 
	DATA,
	COD_CENTRO_CUSTO,
	CONTA_REDUZIDA,
	META,
	'kccdados' as ORIGEM
INTO BI_Staging.stg.temp_OM_metas
FROM PROD.dbo.OM_METAS$

-- GARANTE QUE A TABELA DESTINO NO BI_STAGING ESTEJA LIMPA
TRUNCATE TABLE [stg].[OM_METAS]

-- GARANTINDO QUE EST? LIMPO, INSERIMOS TODOS OS DADOS NOVAMENTE, A PARTIR DA TABELA TEMPORARIA
INSERT INTO [stg].[OM_METAS]
SELECT * FROM BI_Staging.stg.temp_OM_metas


-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('BI_Staging.stg.temp_OM_metas') IS NOT NULL) 
		DROP TABLE BI_Staging.stg.temp_OM_metas


END;
