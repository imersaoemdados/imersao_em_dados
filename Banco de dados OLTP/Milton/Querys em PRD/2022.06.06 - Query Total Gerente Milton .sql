-- Nesta query, realizamos uma consulta em Produ��o, buscando o valor total realizado para o gerente Milton
-- e m�s de Maio. Nesse c�digo, � considerado o d�bito e cr�dito

USE PROD

SELECT SUM(REALIZADO) AS REALIZADO FROM (
			SELECT 
				Data,
				GERENTE,
				CASE 
					WHEN DEBITO_CREDITO = 'D' THEN VALOR_LANCTO
					WHEN DEBITO_CREDITO = 'C' THEN VALOR_LANCTO *-1
					ELSE 0
				END AS REALIZADO
			FROM [dbo].[OM_Mesasamori]
							) A
WHERE 1=1
AND GERENTE = 'MILTON'
AND MONTH(Data) = 5

