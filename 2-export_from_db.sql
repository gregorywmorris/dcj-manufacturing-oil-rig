USE energymobile;

SELECT
    sd.rig_name,
    sd.date_time,
    sd.cumulative_minutes,
    cc.cooler_percentage,
    cc.cooler_description,
    vc.valve_percentage,
    vc.valve_description,
    ipl.leakage_level AS internal_pump_leakage,
    ipl.pump_description,
    hab.pressure_bar AS hydraulic_accumulator_bar,
    hab.hydraulic_description,
    sf.flag_value AS stable_flag,
    sf.flag_description,
    s1.sensor_value AS pressure_bar_1,
    s1.sensor_value AS pressure_bar_2,
    s1.sensor_value AS pressure_bar_3,
    s1.sensor_value AS pressure_bar_4,
    s1.sensor_value AS pressure_bar_5,
    s1.sensor_value AS pressure_bar_6,
    s7.sensor_value AS motor_power_w,
    s8.sensor_value AS volume_flow_min_1,
    s9.sensor_value AS volume_flow_min_2,
    s10.sensor_value AS temperature_1,
    s10.sensor_value AS temperature_2,
    s10.sensor_value AS temperature_3,
    s10.sensor_value AS temperature_4,
    s14.sensor_value AS vibration,
    s15.sensor_value AS cooling_efficiency,
    s16.sensor_value AS cooling_power,
    s17.sensor_value AS efficiency_factor_percent
FROM
    sensor_data sd
JOIN
    cooler_condition cc ON sd.cooler_condition = cc.cooler_id
JOIN
    valve_condition vc ON sd.valve_condition = vc.valve_id
JOIN
    internal_pump_leakage ipl ON sd.internal_pump_leakage = ipl.leakage_level
JOIN
    hydraulic_accumulator_bar hab ON sd.hydraulic_accumulator_bar = hab.pressure_bar
JOIN
    stable_flag sf ON sd.stable_flag = sf.flag_value
JOIN
    (SELECT sensor_name, MAX(sensor_value) AS sensor_value FROM sensor_data WHERE sensor_name IN ('PS1', 'PS2', 'PS3', 'PS4', 'PS5', 'PS6') GROUP BY sensor_name) s1 ON sd.sensor_name = s1.sensor_name
JOIN
    (SELECT sensor_name, MAX(sensor_value) AS sensor_value FROM sensor_data WHERE sensor_name = 'EPS1' GROUP BY sensor_name) s7 ON sd.sensor_name = s7.sensor_name
JOIN
    (SELECT sensor_name, MAX(sensor_value) AS sensor_value FROM sensor_data WHERE sensor_name = 'FS1' GROUP BY sensor_name) s8 ON sd.sensor_name = s8.sensor_name
JOIN
    (SELECT sensor_name, MAX(sensor_value) AS sensor_value FROM sensor_data WHERE sensor_name = 'FS2' GROUP BY sensor_name) s9 ON sd.sensor_name = s9.sensor_name
JOIN
    (SELECT sensor_name, MAX(sensor_value) AS sensor_value FROM sensor_data WHERE sensor_name LIKE 'TS%' GROUP BY sensor_name) s10 ON sd.sensor_name = s10.sensor_name
JOIN
    (SELECT sensor_name, MAX(sensor_value) AS sensor_value FROM sensor_data WHERE sensor_name = 'VS1' GROUP BY sensor_name) s14 ON sd.sensor_name = s14.sensor_name
JOIN
    (SELECT sensor_name, MAX(sensor_value) AS sensor_value FROM sensor_data WHERE sensor_name = 'CE' GROUP BY sensor_name) s15 ON sd.sensor_name = s15.sensor_name
JOIN
    (SELECT sensor_name, MAX(sensor_value) AS sensor_value FROM sensor_data WHERE sensor_name = 'CP' GROUP BY sensor_name) s16 ON sd.sensor_name = s16.sensor_name
JOIN
    (SELECT sensor_name, MAX(sensor_value) AS sensor_value FROM sensor_data WHERE sensor_name = 'SE' GROUP BY sensor_name) s17 ON sd.sensor_name = s17.sensor_name
ORDER BY
    sd.well_name;