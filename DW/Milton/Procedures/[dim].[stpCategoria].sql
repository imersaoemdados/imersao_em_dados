USE [DW]
GO
/****** Object:  StoredProcedure [dim].[stpCategoria]    Script Date: 31/07/2022 23:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dim].[stpCategoria]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_Categoria') IS NOT NULL) 
		DROP TABLE DW.dim.temp_Categoria

	
-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA


SELECT DISTINCT
	categoria as cd_categoria,
	desc_categoria as ds_categoria,
	ds_origem
into DW.dim.temp_Categoria
from BI_Staging.STG.DesepasPOA


---------------------------------------

DELETE DESTINO
      FROM dim.categoria DESTINO -- TABELA DESTINO (DW - NÃO É A TABELA TEMPORÁRIA - VCS CRIARAM A PARTIR DO CREATE TABLE)
     WHERE NOT EXISTS ( SELECT 1 
                          FROM dim.temp_Categoria ORIGEM -- TABELA TEMPORARIA
                         WHERE ORIGEM.cd_categoria		= DESTINO.cd_categoria AND
							   ORIGEM.ds_origem		= DESTINO.ds_origem);
								

								
	MERGE dim.categoria			AS Destino
    USING dim.temp_Categoria			AS Origem
    ON (Destino.cd_categoria			= Origem.cd_categoria AND
		Destino.ds_origem			= Origem.ds_origem )
	


    WHEN MATCHED THEN
	-- Verificar se existe o registro na tabela destino e se existe na tabela de origem e alterá-los;
		 UPDATE SET Destino.ds_categoria						= Origem.ds_categoria
				
			

		WHEN NOT MATCHED BY TARGET THEN
        -- Verificar se não existe o registro na tabela destino, mas existe na tabela de origem e inserí-los;
        INSERT (  cd_categoria
				, ds_categoria
				, [ds_origem]
				)
		VALUES (  Origem.cd_categoria
				, Origem.ds_categoria
				, Origem.[ds_origem]
				);
			

-- DELETO A MINHA TABELA TEMPORARIA
IF(OBJECT_ID('DW.dim.temp_Categoria') IS NOT NULL) 
		DROP TABLE DW.dim.temp_Categoria

		
END;