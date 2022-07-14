USE [DW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [fato].[stpfato_metas]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.fato.temp_fato_metas') IS NOT NULL) 
		DROP TABLE DW.fato.temp_fato_metas

	
-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA

SELECT 
	Data as dt_data,
	COD_CENTRO_CUSTO AS cd_centro_custo,
	CONTA_REDUZIDA as cd_conta_reduzida,
	META AS vl_meta,
	ORIGEM AS ds_origem
	INTO DW.fato.temp_fato_metas
from BI_Staging.stg.OM_METAS
	


	TRUNCATE TABLE fato.om_metas


	insert into fato.om_metas
	select * from dw.fato.temp_fato_metas


-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.fato.temp_fato_metas') IS NOT NULL) 
		DROP TABLE DW.fato.temp_fato_metas


end;



