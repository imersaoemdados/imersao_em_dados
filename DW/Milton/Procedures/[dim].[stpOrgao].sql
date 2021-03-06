USE [DW]
GO
/****** Object:  StoredProcedure [dim].[stpOrgao]    Script Date: 31/07/2022 23:48:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dim].[stpOrgao]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_Orgao') IS NOT NULL) 
		DROP TABLE DW.dim.temp_Orgao

	
-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA

SELECT DISTINCT 
		orgao		as cd_orgao,
		nome_orgao	as nm_orgao,
		ds_origem
INTO DW.dim.temp_Orgao
FROM BI_Staging.stg.DesepasPOA
order by cd_orgao

---------------------------------------

DELETE DESTINO
      FROM dim.orgao DESTINO -- TABELA DESTINO (DW - NÃO É A TABELA TEMPORÁRIA - VCS CRIARAM A PARTIR DO CREATE TABLE)
     WHERE NOT EXISTS ( SELECT 1 
                          FROM dim.temp_Orgao ORIGEM -- TABELA TEMPORARIA
                         WHERE ORIGEM.cd_orgao		= DESTINO.cd_orgao AND
							   ORIGEM.ds_origem		= DESTINO.ds_origem);
								

								
	MERGE dim.orgao					AS Destino
    USING dim.temp_Orgao			AS Origem
    ON (Destino.cd_orgao			= Origem.cd_orgao AND
		Destino.ds_origem			= Origem.ds_origem )
	


    WHEN MATCHED THEN
	-- Verificar se existe o registro na tabela destino e se existe na tabela de origem e alterá-los;
		 UPDATE SET Destino.nm_orgao						= Origem.nm_orgao
				
			

		WHEN NOT MATCHED BY TARGET THEN
        -- Verificar se não existe o registro na tabela destino, mas existe na tabela de origem e inserí-los;
        INSERT (  cd_orgao
				, nm_orgao
				, [ds_origem]
				)
		VALUES (  Origem.cd_orgao
				, Origem.nm_orgao
				, Origem.[ds_origem]
				);
			

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_Orgao') IS NOT NULL) 
		DROP TABLE DW.dim.temp_Orgao
		
END;