USE steel_energy_analysis;

WITH load_summary AS (
    SELECT
        Load_Type,
        AVG(Usage_kWh) AS avg_usage_kwh
    FROM energy_data
    GROUP BY Load_Type
)
SELECT
    Load_Type,
    avg_usage_kwh,
    RANK() OVER (ORDER BY avg_usage_kwh DESC) AS consumption_rank
FROM load_summary
ORDER BY consumption_rank;

WITH hourly_summary AS (
    SELECT
        Hour,
        AVG(Usage_kWh) AS avg_usage_kwh
    FROM energy_data
    GROUP BY Hour
)
SELECT
    Hour,
    avg_usage_kwh,
    RANK() OVER (ORDER BY avg_usage_kwh DESC) AS hour_rank
FROM hourly_summary
ORDER BY hour_rank;

WITH hourly_summary AS (
    SELECT
        Hour,
        AVG(Usage_kWh) AS avg_usage_kwh
    FROM energy_data
    GROUP BY Hour
)
SELECT
    Hour,
    avg_usage_kwh,
    LAG(avg_usage_kwh) OVER (ORDER BY Hour) AS previous_hour_avg,
    avg_usage_kwh - LAG(avg_usage_kwh) OVER (ORDER BY Hour) AS difference_from_previous
FROM hourly_summary
ORDER BY Hour;

WITH hourly_load AS (
    SELECT
        Load_Type,
        Hour,
        AVG(Usage_kWh) AS avg_usage_kwh
    FROM energy_data
    GROUP BY Load_Type, Hour
)
SELECT
    Load_Type,
    Hour,
    avg_usage_kwh,
    RANK() OVER (
        PARTITION BY Load_Type
        ORDER BY avg_usage_kwh DESC
    ) AS hour_rank
FROM hourly_load
ORDER BY Load_Type, hour_rank;

WITH hourly_load AS (
    SELECT
        Load_Type,
        Hour,
        AVG(Usage_kWh) AS avg_usage_kwh
    FROM energy_data
    GROUP BY Load_Type, Hour
),
ranked_hours AS (
    SELECT
        Load_Type,
        Hour,
        avg_usage_kwh,
        RANK() OVER (
            PARTITION BY Load_Type
            ORDER BY avg_usage_kwh DESC
        ) AS hour_rank
    FROM hourly_load
)
SELECT
    Load_Type,
    Hour,
    avg_usage_kwh,
    hour_rank
FROM ranked_hours
WHERE hour_rank <= 3
ORDER BY Load_Type, hour_rank;

WITH weekly_summary AS (
    SELECT
        WeekStatus,
        AVG(Usage_kWh) AS avg_usage_kwh
    FROM energy_data
    GROUP BY WeekStatus
)
SELECT
    WeekStatus,
    avg_usage_kwh,
    avg_usage_kwh - AVG(avg_usage_kwh) OVER () AS difference_from_overall_avg
FROM weekly_summary;

WITH daily_summary AS (
    SELECT
        Day_of_week,
        AVG(Usage_kWh) AS avg_usage_kwh
    FROM energy_data
    GROUP BY Day_of_week
)
SELECT
    Day_of_week,
    avg_usage_kwh,
    RANK() OVER (ORDER BY avg_usage_kwh DESC) AS day_rank
FROM daily_summary
ORDER BY day_rank;