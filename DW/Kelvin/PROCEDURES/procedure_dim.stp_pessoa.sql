USE [DW]
GO
/****** Object:  StoredProcedure [stg].[stpOM_Mesasamori]    Script Date: 08/07/2022 21:39:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dim].[stppessoa]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_pessoa') IS NOT NULL) 
		DROP TABLE DW.dim.temp_pessoa

	
-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA


SELECT DISTINCT 
	COD_DIRETOR as cd_pessoa,
	DIRETOR AS nm_pessoa,
	ORIGEM as [ds_origem],
	'DIRETOR' as ds_cargo
INTO DW.dim.temp_pessoa 
FROM BI_Staging.stg.OM_KCCDADOS


insert into dim.temp_pessoa
select distinct 
COD_GERENTE as cd_pessoa,
GERENTE as nm_pessoa,
ORIGEM as ds_origem,
'GERENTE' as ds_cargo
FROM BI_Staging.stg.OM_KCCDADOS



DELETE destino
      FROM dim.pessoa destino -- TABELA DESTINO (DW - NÃO É A TABELA TEMPORÁRIA - VCS CRIARAM A PARTIR DO CREATE TABLE)
     WHERE NOT EXISTS ( SELECT 1 
                          FROM DW.dim.temp_pessoa origem -- TABELA TEMPORARIA
                         WHERE origem.cd_pessoa		= destino.cd_pessoa AND
							  origem.ds_origem		= destino.ds_origem AND
							  origem.ds_cargo		= destino.ds_cargo
							 );
								
								
	MERGE dim.pessoa					AS Destino
    USING DW.dim.temp_pessoa			AS Origem
    ON (Destino.cd_pessoa			= Origem.cd_pessoa AND
		Destino.ds_origem			= Origem.ds_origem AND
		Destino.ds_cargo            = Origem.ds_cargo)
	

    WHEN MATCHED THEN
	-- Verificar se existe o registro na tabela destino e se existe na tabela de origem e alterá-los;
		 UPDATE SET Destino.[nm_pessoa]						= Origem.[nm_pessoa]
				

		WHEN NOT MATCHED BY TARGET THEN
        -- Verificar se não existe o registro na tabela destino, mas existe na tabela de origem e inserí-los;
        INSERT ([cd_pessoa]
			, [nm_pessoa]
			, [ds_origem]
			, [ds_cargo]
				)
		VALUES (  Origem.[cd_pessoa]
				, Origem.[nm_pessoa]
				, Origem.[ds_origem]
				, Origem.[ds_cargo]);
			

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_pessoa') IS NOT NULL) 
		DROP TABLE DW.dim.temp_pessoa
		
END;
