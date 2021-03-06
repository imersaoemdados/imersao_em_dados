USE [DW]
GO
/****** Object:  StoredProcedure [fato].[stporcamento_matricial]    Script Date: 15/07/2022 16:51:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [fato].[stporcamento_matricial]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.fato.temp_orcamento_matricial') IS NOT NULL) 
		DROP TABLE DW.fato.temp_orcamento_matricial

	
-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA


SELECT 
	Data as dt_data,
	CONTA_REDUZIDA as cd_conta_reduzida,
	COD_AREA AS cd_area,
	COD_PACOTE AS cd_pacote,
	COD_CENTRO_CUSTO AS cd_centro_custo,
	DEBITO_CREDITO AS ds_debito_credito,
	VALOR_LANCTO as vl_lancamento,
	ORIGEM AS ds_origem,
	COD_DIRETOR as cd_diretor,
	COD_GERENTE as cd_gerente
	INTO DW.fato.temp_orcamento_matricial
from BI_Staging.stg.OM_KCCDADOS
	


	TRUNCATE TABLE fato.orcamento_matricial


	insert into fato.orcamento_matricial
	select * from dw.fato.temp_orcamento_matricial


-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.fato.temp_orcamento_matricial') IS NOT NULL) 
		DROP TABLE DW.fato.temp_orcamento_matricial


end;