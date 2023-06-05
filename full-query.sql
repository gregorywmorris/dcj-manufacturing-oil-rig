use energymobile;

SELECT
	sd.cohort,
	sd.date_time,
	sd.cumulative_minutes,
	tc.cooler_percentage,
	tc.valve_percentage,
	tc.internal_pump_leakage,
	tc.hydraulic_accumulator_bar,
	tc.stable_flag,
	tc.cooler_description,
	tc.valve_description,
	tc.pump_description,
	tc.hydraulic_description,
	tc.flag_description,
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
  -- JOIN target_condition tc ON sd.target_condition = tc.condition_id
JOIN (
	select
		tc.condition_id,
		tc.internal_pump_leakage,
		tc.hydraulic_accumulator_bar,
		tc.stable_flag,
        cc.cooler_description,
        cc.cooler_percentage,
        vc.valve_description,
        vc.valve_percentage,
        ipl.pump_description,
        hab.hydraulic_description,
        sf.flag_description
    FROM target_condition tc
    JOIN cooler_condition cc on tc.cooler_condition = cc.cooler_id
	  JOIN valve_condition vc ON tc.valve_condition = vc.valve_id
    JOIN internal_pump_leakage ipl on tc.internal_pump_leakage = ipl.leakage_level
    JOIN hydraulic_accumulator_bar hab on tc.hydraulic_accumulator_bar = hab.pressure_bar
    JOIN stable_flag sf on tc.stable_flag = sf.flag_value
  ) AS tc on sd.target_condition = tc.condition_id
-- WHERE cohort = 59 or cohort = 60
GROUP BY
	sd.cohort,
	sd.date_time,
	sd.cumulative_minutes,
	tc.cooler_percentage,
	tc.valve_percentage,
	tc.internal_pump_leakage,
	tc.hydraulic_accumulator_bar,
	tc.stable_flag,
	tc.cooler_description,
	tc.valve_description,
	tc.pump_description,
	tc.hydraulic_description,
	tc.flag_description
ORDER BY
  sd.date_time;
