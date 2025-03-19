DECLARE @StartDate DATE = '2000-01-01';
DECLARE @EndDate DATE = '2050-12-31';

WITH DateSeries AS (
    SELECT CAST(@StartDate AS DATE) AS DateValue
    UNION ALL
    SELECT DATEADD(DAY, 1, DateValue)
    FROM DateSeries
    WHERE DateValue < @EndDate
)
SELECT 
    DateValue AS [Date],
    YEAR(DateValue) AS [Year],
    MONTH(DateValue) AS [Month],
    FORMAT(DateValue, 'MMMM') AS [MonthName],
    DAY(DateValue) AS [Day],
    DATEPART(QUARTER, DateValue) AS [Quarter],
    DATENAME(WEEKDAY, DateValue) AS [Weekday],
    DATEPART(WEEK, DateValue) AS [WeekOfYear],
    CASE WHEN DATEPART(WEEKDAY, DateValue) IN (1,7) THEN 'Weekend' ELSE 'Weekday' END AS [WeekendFlag]
INTO FabricLakehouse.dbo.DimDate
FROM DateSeries
OPTION (MAXRECURSION 0);