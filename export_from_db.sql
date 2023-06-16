use energymobile;

SELECT
	sd.well_name,
	sd.date_time,
	sd.cumulative_minutes,
	sd.cooler_percentage,
    .cooler_description,
	sd.valve_percentage,
    .valve_description,
	sd.internal_pump_leakage,
	.pump_description,
    sd.hydraulic_accumulator_bar,
	.hydraulic_description,
	sd.stable_flag,
	.flag_description,
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
JOIN (
	select
		sd.profile_id,
		sd.internal_pump_leakage,
		sd.hydraulic_accumulator_bar,
		sd.stable_flag,
        cc.cooler_description,
        cc.cooler_percentage,
        vc.valve_description,
        vc.valve_percentage,
        ipl.pump_description,
        hab.hydraulic_description,
        sf.flag_description
    FROM well_profile sd
    JOIN cooler_condition cc on sd.cooler_condition = cc.cooler_id
	JOIN valve_condition vc ON sd.valve_condition = vc.valve_id
    JOIN internal_pump_leakage ipl on sd.internal_pump_leakage = ipl.leakage_level
    JOIN hydraulic_accumulator_bar hab on sd.hydraulic_accumulator_bar = hab.pressure_bar
    JOIN stable_flag sf on sd.stable_flag = sf.flag_value
  ) AS sd on sd.well_profile = sd.profile_id
GROUP BY
	sd.well_name,
	sd.date_time,
	sd.cumulative_minutes,
	sd.cooler_percentage,
    .cooler_description,
	sd.valve_percentage,
    .valve_description,
	sd.internal_pump_leakage,
	.pump_description,
    sd.hydraulic_accumulator_bar,
	.hydraulic_description,
	sd.stable_flag,
	.flag_description
ORDER BY
  sd.well_name;
