select 
C.ds_nome AS FACULDADE, 
COUNT(DISTINCT B.nm_nome) AS QUANTIDADE_PESSOA 
from fato.aplicacoes A
INNER JOIN dim.pessoa B ON A.id_pessoa = B.id
LEFT JOIN dim.faculdade C ON A.id_faculdade = B.id
GROUP BY C.ds_nome
ORDER BY COUNT(DISTINCT B.nm_nome)