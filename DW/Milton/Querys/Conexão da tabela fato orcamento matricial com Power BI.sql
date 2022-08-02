SELECT 
	dt_data,
	cd_conta_contabil,
	cd_area,
	cd_centro_custo,
	SUM(vl_valor_lancto) as vl_valor_lancto,
	ds_origem,
	cd_diretor,
	cd_gerente
FROM fato.orcamento_matricial
WHERE 1=1
GROUP BY 
	dt_data,
	cd_conta_contabil,
	cd_area,
	cd_centro_custo,
	ds_origem,
	cd_diretor,
	cd_gerente