-- A query abaixo muda o nome da coluna:
-- EXEC sp_rename 'nomedatabela.nomedacoluna', 'novonome', 'COLUMN'

-- A query abaixo modifica o nome da coluna ds_meta da fato.orcamento_matricial para vl_meta
EXEC sp_rename '[fato].[om_metas].ds_meta', 'vl_meta', 'COLUMN'