USE [DW]
GO
/****** Object:  StoredProcedure [dim].[stpPessoa]    Script Date: 31/07/2022 23:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dim].[stpPessoa]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_Pessoa') IS NOT NULL) 
		DROP TABLE DW.dim.temp_Pessoa

	
-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA


SELECT DISTINCT 
	COD_DIRETOR AS cd_pessoa,
	DIRETOR AS nm_pessoa,
	ORIGEM as [ds_origem],
	'DIRETOR' AS ds_cargo
INTO DW.dim.temp_Pessoa  
FROM BI_Staging.stg.OM_Mesasamori

-------------------------------------
INSERT INTO DW.dim.temp_Pessoa  
SELECT DISTINCT 
	COD_GERENTE AS cd_gerente,
	GERENTE AS nm_gerente,
	ORIGEM as ds_origem,
	'GERENTE' AS ds_cargo
FROM BI_Staging.stg.OM_Mesasamori


---------------------------------------

DELETE DESTINO
      FROM dim.pessoa DESTINO -- TABELA DESTINO (DW - NÃO É A TABELA TEMPORÁRIA - VCS CRIARAM A PARTIR DO CREATE TABLE)
     WHERE NOT EXISTS ( SELECT 1 
                          FROM DW.dim.temp_Pessoa ORIGEM -- TABELA TEMPORARIA
                         WHERE ORIGEM.cd_pessoa		= DESTINO.cd_pessoa AND
							   ORIGEM.ds_origem		= DESTINO.ds_origem AND
							   ORIGEM.ds_cargo		= DESTINO.ds_cargo);
								

								
	MERGE dim.pessoa					AS Destino
    USING DW.dim.temp_Pessoa			AS Origem
    ON (Destino.cd_pessoa			= Origem.cd_pessoa AND
		Destino.ds_origem			= Origem.ds_origem AND
		Destino.ds_cargo			= Origem.ds_cargo)
	


    WHEN MATCHED THEN
	-- Verificar se existe o registro na tabela destino e se existe na tabela de origem e alterá-los;
		 UPDATE SET Destino.[nm_pessoa]						= Origem.[nm_pessoa]
				
			

		WHEN NOT MATCHED BY TARGET THEN
        -- Verificar se não existe o registro na tabela destino, mas existe na tabela de origem e inserí-los;
        INSERT (cd_pessoa
			, nm_pessoa
			, [ds_origem]
			, ds_cargo)
		VALUES (  Origem.cd_pessoa
				, Origem.nm_pessoa
				, Origem.[ds_origem]
				, Origem.ds_cargo);
			

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_Pessoa') IS NOT NULL) 
		DROP TABLE DW.dim.temp_Pessoa
		
END;