USE [DW]
GO
/****** Object:  StoredProcedure [dim].[stppessoa]    Script Date: 12/07/2022 22:57:14 ******/
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
	 COD_DIRETOR    AS cd_pessoa
	,DIRETOR        AS nm_pessoa
	,ORIGEM         AS ds_origem
	,'DIRETOR'      AS ds_cargo
INTO DW.dim.temp_pessoa
FROM BI_Staging.stg.OM_SYM_COMPANY


INSERT INTO DW.dim.temp_pessoa	
SELECT DISTINCT 
	 COD_GERENTE    AS cd_pessoa
	,GERENTE        AS nm_pessoa
	,ORIGEM         AS ds_origem
	,'GERENTE'      AS ds_cargo
FROM BI_Staging.stg.OM_SYM_COMPANY



DELETE Destino
      FROM [dim].[pessoa] Destino -- TABELA DESTINO (DW - NÃO É A TABELA TEMPORÁRIA - VCS CRIARAM A PARTIR DO CREATE TABLE)
     WHERE NOT EXISTS ( SELECT 1 
                          FROM DW.dim.temp_pessoa Origem -- TABELA TEMPORARIA (Origem)
                         WHERE Origem.cd_pessoa    = Destino.cd_pessoa AND
							   Origem.ds_origem    = Destino.ds_origem AND
							   Origem.ds_cargo     = Destino.ds_cargo
							 );
								
								
	MERGE dim.pessoa		        AS Destino
    USING DW.dim.temp_pessoa	    AS Origem
    ON (Origem.cd_pessoa	       = Destino.cd_pessoa AND
        Origem.ds_origem           = Destino.ds_origem AND
	    Origem.ds_cargo            = Destino.ds_cargo )


    WHEN MATCHED THEN
	-- Verificar se existe o registro na tabela destino e se existe na tabela de origem e alterá-los;
		 UPDATE SET Destino.[nm_pessoa]					= Origem.[nm_pessoa]
				

		WHEN NOT MATCHED BY TARGET THEN
        -- Verificar se não existe o registro na tabela destino, mas existe na tabela de origem e inserí-los;
        INSERT ( [cd_pessoa]
			   , [nm_pessoa]
			   , [ds_origem]
			   , [ds_cargo])
		VALUES ( Origem.[cd_pessoa]
			   , Origem.[nm_pessoa]
			   , Origem.[ds_origem]
			   , Origem.[ds_cargo]
			   );
			


-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_pessoa') IS NOT NULL) 
		DROP TABLE DW.dim.temp_pessoa
		
END;
