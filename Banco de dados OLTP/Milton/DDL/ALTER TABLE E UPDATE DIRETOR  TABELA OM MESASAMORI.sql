alter table dbo.[OM_Mesasamori] add COD_DIRETOR INT



UPDATE dbo.[OM_Mesasamori]
	SET COD_DIRETOR = 1
	WHERE DIRETOR = 'TITE'


UPDATE dbo.[OM_Mesasamori]
	SET COD_DIRETOR =2
	WHERE DIRETOR = 'HOMERO'

	

UPDATE dbo.[OM_Mesasamori]
	SET COD_DIRETOR =3
	WHERE DIRETOR = 'LAURO'