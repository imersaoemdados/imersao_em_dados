USE [DW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




ALTER PROCEDURE [dim].[stppacote]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_pacote') IS NOT NULL) 
		DROP TABLE DW.dim.temp_pacote

	
-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA

SELECT DISTINCT 
COD_PACOTE  AS cd_pacote,
DESC_PACOTE AS ds_pacote,
ORIGEM      AS ds_origem
	INTO DW.dim.temp_pacote  
	FROM BI_Staging.[stg].[OM_KCCDADOS]


DELETE Destino
      FROM dim.pacote Destino -- TABELA DESTINO (DW - NÃO É A TABELA TEMPORÁRIA - VCS CRIARAM A PARTIR DO CREATE TABLE)
     WHERE NOT EXISTS ( SELECT 1 
                          FROM DW.dim.temp_pacote Origem -- TABELA TEMPORARIA (Origem)
                         WHERE Origem.cd_pacote	   = Destino.cd_pacote AND
							   Origem.ds_origem    = Destino.ds_origem 
							 );
								
								
	MERGE dim.pacote		        AS Destino
    USING DW.dim.temp_pacote	    AS Origem
    ON (Origem.cd_pacote	       = Destino.cd_pacote AND
        Origem.ds_origem           = Destino.ds_origem )
	


    WHEN MATCHED THEN
	-- Verificar se existe o registro na tabela destino e se existe na tabela de origem e alterá-los;
		 UPDATE SET Destino.[ds_pacote]						= Origem.[ds_pacote]
				

		WHEN NOT MATCHED BY TARGET THEN
        -- Verificar se não existe o registro na tabela destino, mas existe na tabela de origem e inserí-los;
        INSERT 
		( [cd_pacote],
		[ds_pacote],
		[ds_origem])
		VALUES
		( Origem.[cd_pacote],
		Origem.[ds_pacote],
		Origem.[ds_origem]);
			

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_pacote') IS NOT NULL) 
		DROP TABLE DW.dim.temp_pacote
		
END;