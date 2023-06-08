use energymobile;

SELECT
	sd.well_number,
	sd.date_time,
	sd.cumulative_minutes,
	wp.cooler_percentage,
    wp.cooler_description,
	wp.valve_percentage,
    wp.valve_description,
	wp.internal_pump_leakage,
	wp.pump_description,
    wp.hydraulic_accumulator_bar,
	wp.hydraulic_description,
	wp.stable_flag,
	wp.flag_description,
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
  -- JOIN well_profile wp ON sd.well_profile = wp.condition_id
JOIN (
	select
		wp.profile_id,
		wp.internal_pump_leakage,
		wp.hydraulic_accumulator_bar,
		wp.stable_flag,
        cc.cooler_description,
        cc.cooler_percentage,
        vc.valve_description,
        vc.valve_percentage,
        ipl.pump_description,
        hab.hydraulic_description,
        sf.flag_description
    FROM well_profile wp
    JOIN cooler_condition cc on wp.cooler_condition = cc.cooler_id
	JOIN valve_condition vc ON wp.valve_condition = vc.valve_id
    JOIN internal_pump_leakage ipl on wp.internal_pump_leakage = ipl.leakage_level
    JOIN hydraulic_accumulator_bar hab on wp.hydraulic_accumulator_bar = hab.pressure_bar
    JOIN stable_flag sf on wp.stable_flag = sf.flag_value
  ) AS wp on sd.well_profile = wp.profile_id
GROUP BY
	sd.well_number,
	sd.date_time,
	sd.cumulative_minutes,
	wp.cooler_percentage,
    wp.cooler_description,
	wp.valve_percentage,
    wp.valve_description,
	wp.internal_pump_leakage,
	wp.pump_description,
    wp.hydraulic_accumulator_bar,
	wp.hydraulic_description,
	wp.stable_flag,
	wp.flag_description
ORDER BY
  sd.well_number;
