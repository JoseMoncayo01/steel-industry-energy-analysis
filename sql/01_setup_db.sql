CREATE DATABASE IF NOT EXISTS steel_energy_analysis;

USE steel_energy_analysis;

CREATE TABLE energy_data (
    date DATETIME,
    Usage_kWh DECIMAL(10,2),
    Lagging_Current_Reactive_Power_kVarh DECIMAL(10,2),
    Leading_Current_Reactive_Power_kVarh DECIMAL(10,2),
    CO2_tCO2 DECIMAL(10,4),
    Lagging_Current_Power_Factor DECIMAL(6,2),
    Leading_Current_Power_Factor DECIMAL(6,2),
    NSM INT,
    WeekStatus VARCHAR(20),
    Day_of_week VARCHAR(20),
    Load_Type VARCHAR(30),
    Hour TINYINT,
    Month VARCHAR(20)
);