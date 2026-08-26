USE steel_energy_analysis;
SELECT COUNT(*) AS total_rows
FROM energy_data;

SELECT *
FROM energy_data
LIMIT 10;

SELECT
    COUNT(*) AS total_rows,
    SUM(date IS NULL) AS null_date,
    SUM(Usage_kWh IS NULL) AS null_usage,
    SUM(Lagging_Current_Reactive_Power_kVarh IS NULL) AS null_lagging_reactive,
    SUM(Leading_Current_Reactive_Power_kVarh IS NULL) AS null_leading_reactive,
    SUM(CO2_tCO2 IS NULL) AS null_co2,
    SUM(Lagging_Current_Power_Factor IS NULL) AS null_lagging_pf,
    SUM(Leading_Current_Power_Factor IS NULL) AS null_leading_pf,
    SUM(NSM IS NULL) AS null_nsm,
    SUM(WeekStatus IS NULL) AS null_week_status,
    SUM(Day_of_week IS NULL) AS null_day,
    SUM(Load_Type IS NULL) AS null_load_type,
    SUM(Hour IS NULL) AS null_hour,
    SUM(Month IS NULL) AS null_month
FROM energy_data;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT date) AS unique_dates
FROM energy_data;

SELECT DISTINCT WeekStatus
FROM energy_data;

SELECT DISTINCT Day_of_week
FROM energy_data;

SELECT DISTINCT Load_Type
FROM energy_data;

SELECT
    MIN(date) AS first_date,
    MAX(date) AS last_date
FROM energy_data;

SELECT
    MIN(Usage_kWh) AS min_usage,
    MAX(Usage_kWh) AS max_usage,
    AVG(Usage_kWh) AS avg_usage,
    SUM(Usage_kWh) AS total_usage
FROM energy_data;