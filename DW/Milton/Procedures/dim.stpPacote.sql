USE [DW]
GO
/****** Object:  StoredProcedure [stg].[stpOM_Mesasamori]    Script Date: 08/07/2022 21:39:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dim].[stpPacote]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_Pacote') IS NOT NULL) 
		DROP TABLE DW.dim.temp_Pacote

	
-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA


SELECT DISTINCT 
	COD_PACOTE AS [cd_pacote],
	DESC_PACOTE as [ds_pacote],
	ORIGEM as [ds_origem]
INTO DW.dim.temp_Pacote  
FROM BI_Staging.stg.OM_Mesasamori

DELETE A
      FROM dim.pacote A -- TABELA DESTINO (DW - NÃO É A TABELA TEMPORÁRIA - VCS CRIARAM A PARTIR DO CREATE TABLE)
     WHERE NOT EXISTS ( SELECT 1 
                          FROM DW.dim.temp_Pacote B -- TABELA TEMPORARIA
                         WHERE B.cd_pacote		= A.cd_pacote AND
							   B.ds_origem		= A.ds_origem 
							 );
								
								
	MERGE dim.pacote					AS Destino
    USING DW.dim.temp_Pacote			AS Origem
    ON (Destino.cd_pacote			= Origem.cd_pacote AND
		Destino.ds_origem			= Origem.ds_origem )
	

    WHEN MATCHED THEN
	-- Verificar se existe o registro na tabela destino e se existe na tabela de origem e alterá-los;
		 UPDATE SET Destino.[ds_pacote]						= Origem.[ds_pacote]
				
			

		WHEN NOT MATCHED BY TARGET THEN
        -- Verificar se não existe o registro na tabela destino, mas existe na tabela de origem e inserí-los;
        INSERT ([cd_pacote]
			, [ds_pacote]
			, [ds_origem])
		VALUES (  Origem.[cd_pacote]
				, Origem.[ds_pacote]
				, Origem.[ds_origem]);
			

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_Pacote') IS NOT NULL) 
		DROP TABLE DW.dim.temp_Pacote
		
END;