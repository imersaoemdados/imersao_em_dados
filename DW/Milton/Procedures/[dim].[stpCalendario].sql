USE [DW]
GO
/****** Object:  StoredProcedure [dim].[stpCalendario]    Script Date: 31/07/2022 23:47:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dim].[stpCalendario]
AS BEGIN

TRUNCATE TABLE dim.calendario

DECLARE @StartDate  date = '20180101';

DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 10, @StartDate));

;WITH seq(n) AS 
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS 
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
    Data				= CONVERT(date, d),
    Dia					= DATEPART(DAY,       d),
    NomeSemana			= DATENAME(WEEKDAY,   d),
    NumSemana			= DATEPART(WEEK,      d),
    NumSemanaISO		= DATEPART(ISO_WEEK,  d),
    DiaSemana			= DATEPART(WEEKDAY,   d),
    NumMes				= DATEPART(MONTH,     d),
    NomeMes				= DATENAME(MONTH,     d),
    NumQuarter			= DATEPART(Quarter,   d),
    Ano					= DATEPART(YEAR,      d),
    PrimeiroDiaMes		= DATEFROMPARTS(YEAR(d), MONTH(d), 1),
    UltimoDiaMes		= DATEFROMPARTS(YEAR(d), 12, 31),
    DiadoAno			= DATEPART(DAYOFYEAR, d)
  FROM d
)
insert into dim.calendario
SELECT 
	Data as dt_data,
	Dia as dt_dia,
	NomeSemana as nm_semana,
	NumSemana as nr_semana,
	NumSemanaISO as nr_semana_iso,
	DiaSemana as nr_dia_semana,
	SUBSTRING(CAST(Data AS VARCHAR), 6,2) as nr_mes,
	NomeMes as nm_mes,
	NumQuarter as nr_quarter,
	Ano as nr_ano,
	PrimeiroDiaMes as dt_primeiro_dia_mes,
	UltimoDiaMes as dt_ultimo_dia_mes,
	DiadoAno as nr_dia_ano,
	'' AS fl_feriado
FROM src
  ORDER BY Data
  OPTION (MAXRECURSION 0)

END;


