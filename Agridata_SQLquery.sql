SHOW DATABASES;
USE agriculture_db;
SELECT * FROM agriculture_data LIMIT 10;
-- 1 ---
SELECT                        
    a.Year,                  
    a.`State Name`,
    a.Total_Rice
FROM (
    SELECT 
        Year,
        `State Name`,
        SUM(`RICE PRODUCTION (1000 tons)`) AS Total_Rice
    FROM agriculture_data
    WHERE Year BETWEEN 1966 AND 2017
    GROUP BY Year, `State Name`
) a
WHERE (
    SELECT COUNT(*)
    FROM (
        SELECT 
            Year,
            `State Name`,
            SUM(`RICE PRODUCTION (1000 tons)`) AS Total_Rice
        FROM agriculture_data
        WHERE Year BETWEEN 1966 AND 2017
        GROUP BY Year, `State Name`
    ) b
    WHERE b.Year = a.Year
      AND b.Total_Rice > a.Total_Rice
) < 3
ORDER BY a.Year, a.Total_Rice DESC;

-- 2-----
SELECT 
    `Dist Name`,
    AVG(`WHEAT YIELD (Kg per ha)`) AS Avg_Wheat_Yield
FROM agriculture_data
WHERE Year >= (SELECT MAX(Year) FROM agriculture_data) - 4
GROUP BY `Dist Name`
ORDER BY Avg_Wheat_Yield DESC
LIMIT 5;

-- 3-----

SELECT
    s_old.`State Name` AS State,
    s_old.total_old AS Oilseed_Start,
    s_new.total_new AS Oilseed_End,
    ROUND(((s_new.total_new - s_old.total_old) / s_old.total_old) * 100, 2) AS Growth_Percentage
FROM
    (SELECT `State Name`, SUM(`OILSEEDS PRODUCTION (1000 tons)`) AS total_old
     FROM agriculture_data
     WHERE Year = (SELECT MAX(Year) FROM agriculture_data) - 5
     GROUP BY `State Name`) s_old
JOIN
    (SELECT `State Name`, SUM(`OILSEEDS PRODUCTION (1000 tons)`) AS total_new
     FROM agriculture_data
     WHERE Year = (SELECT MAX(Year) FROM agriculture_data)
     GROUP BY `State Name`) s_new
ON s_old.`State Name` = s_new.`State Name`
ORDER BY Growth_Percentage DESC
LIMIT 5;

-- 4---
SELECT 
    base.`Dist Name`,
    rice.rice_corr,
    wheat.wheat_corr,
    maize.maize_corr
FROM
    (SELECT DISTINCT `Dist Name` FROM agriculture_data) base

LEFT JOIN
(
    SELECT 
        `Dist Name`,
        ROUND(
            (COUNT(*) * SUM(`RICE AREA (1000 Ha)` * `RICE PRODUCTION (1000 tons)`)
             - SUM(`RICE AREA (1000 Ha)`) * SUM(`RICE PRODUCTION (1000 tons)`))
            /
            NULLIF(
                SQRT(
                    (COUNT(*) * SUM(`RICE AREA (1000 Ha)` * `RICE AREA (1000 Ha)`) 
                     - POWER(SUM(`RICE AREA (1000 Ha)`),2)) *
                    (COUNT(*) * SUM(`RICE PRODUCTION (1000 tons)` * `RICE PRODUCTION (1000 tons)`)
                     - POWER(SUM(`RICE PRODUCTION (1000 tons)`),2))
                ), 0
            ), 4
        ) AS rice_corr
    FROM agriculture_data
    GROUP BY `Dist Name`
) rice ON rice.`Dist Name` = base.`Dist Name`

LEFT JOIN
(
    SELECT 
        `Dist Name`,
        ROUND(
            (COUNT(*) * SUM(`WHEAT AREA (1000 Ha)` * `WHEAT PRODUCTION (1000 tons)`)
             - SUM(`WHEAT AREA (1000 Ha)`) * SUM(`WHEAT PRODUCTION (1000 tons)`))
            /
            NULLIF(
                SQRT(
                    (COUNT(*) * SUM(`WHEAT AREA (1000 Ha)` * `WHEAT AREA (1000 Ha)`) 
                     - POWER(SUM(`WHEAT AREA (1000 Ha)`),2)) *
                    (COUNT(*) * SUM(`WHEAT PRODUCTION (1000 tons)` * `WHEAT PRODUCTION (1000 tons)`)
                     - POWER(SUM(`WHEAT PRODUCTION (1000 tons)`),2))
                ), 0
            ), 4
        ) AS wheat_corr
    FROM agriculture_data
    GROUP BY `Dist Name`
) wheat ON wheat.`Dist Name` = base.`Dist Name`

LEFT JOIN
(
    SELECT 
        `Dist Name`,
        ROUND(
            (COUNT(*) * SUM(`MAIZE AREA (1000 Ha)` * `MAIZE PRODUCTION (1000 tons)`)
             - SUM(`MAIZE AREA (1000 Ha)`) * SUM(`MAIZE PRODUCTION (1000 tons)`))
            /
            NULLIF(
                SQRT(
                    (COUNT(*) * SUM(`MAIZE AREA (1000 Ha)` * `MAIZE AREA (1000 Ha)`) 
                     - POWER(SUM(`MAIZE AREA (1000 Ha)`),2)) *
                    (COUNT(*) * SUM(`MAIZE PRODUCTION (1000 tons)` * `MAIZE PRODUCTION (1000 tons)`)
                     - POWER(SUM(`MAIZE PRODUCTION (1000 tons)`),2))
                ), 0
            ), 4
        ) AS maize_corr
    FROM agriculture_data
    GROUP BY `Dist Name`
) maize ON maize.`Dist Name` = base.`Dist Name`;

-- 5---
WITH Top5States AS (
    SELECT 
        `State Name`
    FROM agriculture_data
    GROUP BY `State Name`
    ORDER BY SUM(`COTTON PRODUCTION (1000 tons)`) DESC
    LIMIT 5
)
SELECT 
    Year,
    `State Name`,
    SUM(`COTTON PRODUCTION (1000 tons)`) AS Yearly_Cotton_Production
FROM agriculture_data
WHERE `State Name` IN (SELECT `State Name` FROM Top5States)
GROUP BY Year, `State Name`
ORDER BY Year, Yearly_Cotton_Production DESC;WITH Top5States AS (
    SELECT 
        `State Name`
    FROM agriculture_data
    GROUP BY `State Name`
    ORDER BY SUM(`COTTON PRODUCTION (1000 tons)`) DESC
    LIMIT 5
)
SELECT 
    Year,
    `State Name`,
    SUM(`COTTON PRODUCTION (1000 tons)`) AS Yearly_Cotton_Production
FROM agriculture_data
WHERE `State Name` IN (SELECT `State Name` FROM Top5States)
GROUP BY Year, `State Name`
ORDER BY Year, Yearly_Cotton_Production DESC;

-- 6
SELECT 
    `Dist Name`,
    SUM(`GROUNDNUT PRODUCTION (1000 tons)`) AS Groundnut_Production
FROM agriculture_data
WHERE Year = 2017
GROUP BY `Dist Name`
ORDER BY Groundnut_Production DESC
LIMIT 5;

-- 7
SELECT 
    Year,
    AVG(`MAIZE YIELD (Kg per ha)`) AS Avg_Maize_Yield
FROM agriculture_data
GROUP BY Year
ORDER BY Year;

-- 8
SELECT 
    `State Name`,
    SUM(`OILSEEDS AREA (1000 ha)`) AS Total_Oilseed_Area
FROM agriculture_data
GROUP BY `State Name`
ORDER BY Total_Oilseed_Area DESC;

-- 9
SELECT 
    `Dist Name`,
    AVG(`RICE YIELD (Kg per ha)`) AS Avg_Rice_Yield
FROM agriculture_data
GROUP BY `Dist Name`
ORDER BY Avg_Rice_Yield DESC
LIMIT 5;

-- 10
WITH Top5States AS (
    SELECT 
        `State Name`
    FROM agriculture_data
    GROUP BY `State Name`
    ORDER BY SUM(`RICE PRODUCTION (1000 tons)` + `WHEAT PRODUCTION (1000 tons)`) DESC
    LIMIT 5
)
SELECT 
    Year,
    `State Name`,
    SUM(`RICE PRODUCTION (1000 tons)`) AS Rice_Production,
    SUM(`WHEAT PRODUCTION (1000 tons)`) AS Wheat_Production
FROM agriculture_data
WHERE `State Name` IN (SELECT `State Name` FROM Top5States)
GROUP BY Year, `State Name`
ORDER BY Year, `State Name`;


