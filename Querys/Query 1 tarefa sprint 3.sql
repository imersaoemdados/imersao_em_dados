use Banco_Teste

select
nm_nome,
sum(valor) 
--dt_data
from fato.aplicacoes A
LEFT JOIN dim.pessoa b on a.id_pessoa = b.id
LEFT JOIN dim.calendario c on  a.id_data = c.id_data
where 1=1
and
MONTH(C.dt_data) = '3'
group by  nm_nome
order by sum(valor) desc