-- A query abaixo muda o nome da coluna:
-- EXEC sp_rename 'nomedatabela.nomedacoluna', 'novonome', 'COLUMN'

-- A query abaixo modifica o nome da coluna cod_gerente da fato.orcamento_matricial para cd_gerente
EXEC sp_rename 'fato.orcamento_matricial.cod_gerente', 'cd_gerente', 'COLUMN'