USE [DW]
GO
/****** Object:  StoredProcedure [fato].[stpOrcamentoMatricial]    Script Date: 01/08/2022 21:39:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [fato].[stpOrcamentoMatricial]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.fato.temp_orcamento_matricial') IS NOT NULL) 
		DROP TABLE DW.fato.temp_orcamento_matricial

	
-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA

--select top 100 * from [fato].[orcamento_matricial]
SELECT 
		cast(CONCAT(YEAR(CAST(Data AS date)),'-', MONTH(CAST(Data AS date)),'-', '01') as date)      AS dt_data
		,CONTA_REDUZIDA       AS cd_conta_contabil
		,COD_AREA             AS cd_area
		,COD_PACOTE           AS cd_pacote
		,COD_CENTRO_CUSTO     AS cd_centro_custo
		,DEBITO_CREDITO       AS ds_debito_credito
		,CASE 
			WHEN DEBITO_CREDITO = 'D' THEN SUM(VALOR_LANCTO)
			WHEN DEBITO_CREDITO = 'C' THEN SUM(VALOR_LANCTO) * -1
		 END AS vl_valor_lancto
		,ORIGEM               AS ds_origem
		,COD_DIRETOR          AS cd_diretor
		,COD_GERENTE          AS cd_gerente
INTO DW.fato.temp_orcamento_matricial 
FROM BI_Staging.[stg].[OM_Mesasamori]
GROUP BY 
		 YEAR(CAST(Data AS date))
		,MONTH(CAST(Data AS date))
		,CONTA_REDUZIDA   
		,COD_AREA         
		,COD_PACOTE       
		,COD_CENTRO_CUSTO 
		,DEBITO_CREDITO   
		,ORIGEM           
		,COD_DIRETOR      
		,COD_GERENTE    

TRUNCATE TABLE fato.orcamento_matricial

INSERT INTO fato.orcamento_matricial
SELECT * FROM DW.fato.temp_orcamento_matricial 

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.fato.temp_orcamento_matricial') IS NOT NULL) 
		DROP TABLE DW.fato.temp_orcamento_matricial
END;
