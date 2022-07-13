USE [BI_Staging]
GO
/****** Object:  StoredProcedure [stg].[stpOM_SYM_COMPANY]    Script Date: 12/07/2022 21:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [stg].[stpOM_SYM_COMPANY]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('BI_Staging.stg.temp_OM') IS NOT NULL) 
		DROP TABLE BI_Staging.stg.temp_OM

-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA
SELECT 
	 Data
	,CONTA_REDUZIDA
	,COD_AREA
	,COD_PACOTE
	,COD_CENTRO_CUSTO
	,DEBITO_CREDITO
	,VALOR_LANCTO
	,DESC_CONTA
	,DESC_AREA
	,DESC_PACOTE
	,DESC_CC
	,GERENTE
	,DIRETOR
	,'SYM_COMPANY' AS ORIGEM
	,COD_DIRETOR
	,COD_GERENTE
INTO stg.temp_OM
FROM PROD.dbo.OM_SYM_COMPANY

-- GARANTE QUE A TABELA DESTINO NO BI_STAGING ESTEJA LIMPA
TRUNCATE TABLE [stg].[OM_SYM_COMPANY]

-- GARANTINDO QUE ESTÁ LIMPO, INSERIMOS TODOS OS DADOS NOVAMENTE, A PARTIR DA TABELA TEMPORARIA
INSERT INTO [stg].[OM_SYM_COMPANY]
SELECT * FROM stg.temp_OM

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('BI_Staging.stg.temp_OM') IS NOT NULL) 
		DROP TABLE BI_Staging.stg.temp_OM

END;
