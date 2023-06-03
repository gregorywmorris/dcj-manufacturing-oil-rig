use energymobile;

SELECT
  sd.date_time,
  sd.cumulative_minutes,
  tc.cooler_condition,
  tc.valve_condition,
  tc.internal_pump_leakage,
  tc.hydraulic_accumulator_bar,
  tc.stable_flag,
  MAX(CASE WHEN sd.sensor_name = 'PS1' THEN sd.sensor_value END) AS pressure_bar_1,
  MAX(CASE WHEN sd.sensor_name = 'PS2' THEN sd.sensor_value END) AS pressure_bar_2,
  MAX(CASE WHEN sd.sensor_name = 'PS3' THEN sd.sensor_value END) AS pressure_bar_3,
  MAX(CASE WHEN sd.sensor_name = 'PS4' THEN sd.sensor_value END) AS pressure_bar_4,
  MAX(CASE WHEN sd.sensor_name = 'PS5' THEN sd.sensor_value END) AS pressure_bar_5,
  MAX(CASE WHEN sd.sensor_name = 'PS6' THEN sd.sensor_value END) AS pressure_bar_6,
  MAX(CASE WHEN sd.sensor_name = 'EPS1' THEN sd.sensor_value END) AS motor_power_w,
  MAX(CASE WHEN sd.sensor_name = 'FS1' THEN sd.sensor_value END) AS volume_flow_min_1,
  MAX(CASE WHEN sd.sensor_name = 'FS2' THEN sd.sensor_value END) AS volume_flow_min_1,
  MAX(CASE WHEN sd.sensor_name = 'TS1' THEN sd.sensor_value END) AS temperature_1,
  MAX(CASE WHEN sd.sensor_name = 'TS2' THEN sd.sensor_value END) AS temperature_2,
  MAX(CASE WHEN sd.sensor_name = 'TS3' THEN sd.sensor_value END) AS temperature_3,
  MAX(CASE WHEN sd.sensor_name = 'TS4' THEN sd.sensor_value END) AS temperature_4,
  MAX(CASE WHEN sd.sensor_name = 'VS1' THEN sd.sensor_value END) AS vibration,
  MAX(CASE WHEN sd.sensor_name = 'CE' THEN sd.sensor_value END) AS cooling_efficiency,
  MAX(CASE WHEN sd.sensor_name = 'CP' THEN sd.sensor_value END) AS Cooling_power,
  MAX(CASE WHEN sd.sensor_name = 'SE' THEN sd.sensor_value END) AS efficiency_factor_percent
FROM
  sensor_data sd
  JOIN target_condition tc ON sd.target_condition = tc.condition_id
GROUP BY
  sd.date_time,
  sd.cumulative_minutes,
  tc.cooler_condition,
  tc.valve_condition,
  tc.internal_pump_leakage,
  tc.hydraulic_accumulator_bar,
  tc.stable_flag
ORDER BY
  sd.date_time;
