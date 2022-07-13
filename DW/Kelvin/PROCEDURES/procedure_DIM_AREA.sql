USE [DW]
GO
/****** Object:  StoredProcedure [dim].[stparea]    Script Date: 11/07/2022 21:56:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dim].[stparea]
AS BEGIN

-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_area') IS NOT NULL) 
		DROP TABLE DW.dim.temp_area

	
-- AQUI ELE PEGA OS DADOS DA BASE DE DADOS EM PRODUÇÃO E COLOCA-OS EM UMA TABELA TEMPORÁRIA


SELECT DISTINCT 
	COD_AREA     AS cd_area,
	DESC_AREA    AS ds_area,
	ORIGEM       AS [ds_origem]
INTO DW.dim.temp_area  
FROM BI_Staging.[stg].[OM_KCCDADOS]



DELETE Destino
 FROM [dim].[area] Destino -- TABELA DESTINO (DW - NÃO É A TABELA TEMPORÁRIA - VCS CRIARAM A PARTIR DO CREATE TABLE)
 WHERE NOT EXISTS ( SELECT 1 
						FROM DW.dim.temp_area Origem -- TABELA TEMPORARIA (Origem)
                         WHERE Origem.cd_area	   = Destino.cd_area AND
							   Origem.ds_origem    = Destino.ds_origem 
							 );
								
								
	MERGE dim.area		        AS Destino
    USING DW.dim.temp_area	    AS Origem
    ON (Origem.cd_area	       = Destino.cd_area AND
        Origem.ds_origem       = Destino.ds_origem )
	


    WHEN MATCHED THEN
	-- Verificar se existe o registro na tabela destino e se existe na tabela de origem e alterá-los;
		 UPDATE SET Destino.[ds_area]						= Origem.[ds_area]
				

	WHEN NOT MATCHED BY TARGET THEN
     -- Verificar se não existe o registro na tabela destino, mas existe na tabela de origem e inserí-los;
     INSERT ( [cd_area],
			   [ds_area],
			   [ds_origem])
	VALUES ( Origem.[cd_area],
			   Origem.[ds_area],
			   Origem.[ds_origem]);
			


-- DELETO A MINHA TABELA TEMPORARIA
	IF(OBJECT_ID('DW.dim.temp_area') IS NOT NULL) 
		DROP TABLE DW.dim.temp_area
		
END;