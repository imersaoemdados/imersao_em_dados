USE PROD 

SELECT * FROM dbo.om_kccdados
select * from dbo.OM_MESASAMORI
select * from dbo.OM_SYMCOMPANY

-- Realize uma query, trazendo o valor lan�ado, do gerente 'MILTON' e m�s Maio.


select 
VALOR_LANCTO
from OM_KCCDADOS
WHERE 1=1
AND NAME = 'MILTON'
MONTH(Data) = 5
