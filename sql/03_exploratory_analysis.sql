USE steel_energy_analysis;

SELECT
    Hour,
    AVG(Usage_kWh) AS avg_usage_kwh
FROM energy_data
GROUP BY Hour
ORDER BY Hour;

SELECT
    Day_of_week,
    AVG(Usage_kWh) AS avg_usage_kwh
FROM energy_data
GROUP BY Day_of_week
ORDER BY avg_usage_kwh DESC;

SELECT
    Month,
    AVG(Usage_kWh) AS avg_usage_kwh
FROM energy_data
GROUP BY Month
ORDER BY avg_usage_kwh DESC;

SELECT
    WeekStatus,
    AVG(Usage_kWh) AS avg_usage_kwh,
    SUM(Usage_kWh) AS total_usage_kwh
FROM energy_data
GROUP BY WeekStatus
ORDER BY avg_usage_kwh DESC;

SELECT
    Load_Type,
    COUNT(*) AS measurements,
    AVG(Usage_kWh) AS avg_usage_kwh,
    MIN(Usage_kWh) AS min_usage_kwh,
    MAX(Usage_kWh) AS max_usage_kwh,
    SUM(Usage_kWh) AS total_usage_kwh
FROM energy_data
GROUP BY Load_Type
ORDER BY avg_usage_kwh DESC;

SELECT
    Hour,
    AVG(Usage_kWh) AS avg_usage_kwh
FROM energy_data
GROUP BY Hour
ORDER BY avg_usage_kwh DESC
LIMIT 10;

SELECT
    Load_Type,
    Hour,
    AVG(Usage_kWh) AS avg_usage_kwh
FROM energy_data
GROUP BY Load_Type, Hour
ORDER BY Load_Type, avg_usage_kwh DESC;

SELECT
    Hour,
    AVG(Usage_kWh) AS avg_usage_kwh
FROM energy_data
GROUP BY Hour
HAVING AVG(Usage_kWh) > 40
ORDER BY avg_usage_kwh DESC;

SELECT
    Day_of_week,
    Hour,
    AVG(Usage_kWh) AS avg_usage_kwh
FROM energy_data
GROUP BY Day_of_week, Hour
ORDER BY avg_usage_kwh DESC;

SELECT
    date,
    Day_of_week,
    Hour,
    Load_Type,
    Usage_kWh
FROM energy_data
ORDER BY Usage_kWh DESC
LIMIT 10;

