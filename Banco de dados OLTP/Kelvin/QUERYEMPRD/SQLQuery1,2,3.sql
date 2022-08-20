select * from fato.aplicacoes
select * from dim.pessoa
select * from dim.profissao
select * from dim.investimentos
select * from dim.emocao
select * from dim.cor_preferida
select * from dim.calendario

select 
CONCAT (B.nm_nome,' ',B.nm_sobrenome) AS NOME_COMPLETO,
CONCAT (B.nm_cidade,' ', B.nm_estado) AS CIDADE_ESTADO,
C.ds_profissao AS PROFISSAO,
D.ds_tipo_investimento AS TIPO_INVESTIMENTO,
E.nm_cor AS COR_PREFERIDA,
F.ds_nome AS FACULDADE,
CAST(G.dt_data AS DATE) AS DATA,
H.ds_emocao as EMOCAO
from fato.aplicacoes A
LEFT JOIN dim.pessoa B			ON A.id_pessoa = B.id
LEFT JOIN dim.profissao C		ON a.id_profissao = C.id
LEFT JOIN dim.investimentos D	ON a.id_investimento = D.id
LEFT JOIN dim.cor_preferida E	ON a.id_cor = E.id
LEFT JOIN dim.faculdade F		ON a.id_faculdade = f.id
LEFT JOIN dim.calendario G		ON a.id_data = G.id_data
LEFT JOIN dim.emocao H			ON a.id_emocao = H.id

