USE energymobile;

SELECT
	sd.rig_name,
	sd.date_time,
	sd.cumulative_minutes,
	cc.cooler_percentage,
	cc.cooler_description,
	vc.valve_percentage,
	vc.valve_description,
	ipl.leakage_level, -- AS internal_pump_leakage,
	ipl.pump_description,
	hab.pressure_bar, -- AS hydraulic_accumulator_bar,
	hab.hydraulic_description,
	sf.flag_value, -- AS stable_flag,
	sf.flag_description,
	MAX(CASE WHEN sd.sensor_name = 'PS1' THEN sd.sensor_value END) AS pressure_1,
    MAX(CASE WHEN sd.sensor_name = 'PS1' THEN s.physical_quantity END) AS ps1_pysical_quantity,
    MAX(CASE WHEN sd.sensor_name = 'PS1' THEN s.unit END) AS ps1_unit,
	MAX(CASE WHEN sd.sensor_name = 'PS1' THEN s.sampling_rate_hz END) AS ps1_sampling_rate_hz,
	MAX(CASE WHEN sd.sensor_name = 'PS2' THEN sd.sensor_value END) AS pressure_2,
	MAX(CASE WHEN sd.sensor_name = 'PS2' THEN s.physical_quantity END) AS ps2_pysical_quantity,
    MAX(CASE WHEN sd.sensor_name = 'PS2' THEN s.unit END) AS ps2_unit,
	MAX(CASE WHEN sd.sensor_name = 'PS2' THEN s.sampling_rate_hz END) AS ps2_sampling_rate_hz,
	MAX(CASE WHEN sd.sensor_name = 'PS3' THEN sd.sensor_value END) AS pressure_3,
	MAX(CASE WHEN sd.sensor_name = 'PS3' THEN s.physical_quantity END) AS ps3_pysical_quantity,
    MAX(CASE WHEN sd.sensor_name = 'PS3' THEN s.unit END) AS ps3_unit,
	MAX(CASE WHEN sd.sensor_name = 'PS3' THEN s.sampling_rate_hz END) AS ps3_sampling_rate_hz,
	MAX(CASE WHEN sd.sensor_name = 'PS4' THEN sd.sensor_value END) AS pressure_4,
	MAX(CASE WHEN sd.sensor_name = 'PS4' THEN s.physical_quantity END) AS ps4_pysical_quantity,
    MAX(CASE WHEN sd.sensor_name = 'PS4' THEN s.unit END) AS ps4_unit,
	MAX(CASE WHEN sd.sensor_name = 'PS4' THEN s.sampling_rate_hz END) AS ps4_sampling_rate_hz,
	MAX(CASE WHEN sd.sensor_name = 'PS5' THEN sd.sensor_value END) AS pressure_5,
	MAX(CASE WHEN sd.sensor_name = 'PS5' THEN s.physical_quantity END) AS ps5_pysical_quantity,
    MAX(CASE WHEN sd.sensor_name = 'PS5' THEN s.unit END) AS ps5_unit,
	MAX(CASE WHEN sd.sensor_name = 'PS5' THEN s.sampling_rate_hz END) AS ps5_sampling_rate_hz,
	MAX(CASE WHEN sd.sensor_name = 'PS6' THEN sd.sensor_value END) AS pressure_6,
	MAX(CASE WHEN sd.sensor_name = 'PS6' THEN s.physical_quantity END) AS ps6_pysical_quantity,
    MAX(CASE WHEN sd.sensor_name = 'PS6' THEN s.unit END) AS ps6_unit,
	MAX(CASE WHEN sd.sensor_name = 'PS6' THEN s.sampling_rate_hz END) AS ps6_sampling_rate_hz,
	MAX(CASE WHEN sd.sensor_name = 'EPS1' THEN sd.sensor_value END) AS motor_power_eps1,
	MAX(CASE WHEN sd.sensor_name = 'EPS1' THEN s.physical_quantity END) AS eps1_pysical_quantity,
    MAX(CASE WHEN sd.sensor_name = 'EPS1' THEN s.unit END) AS EPS1_unit,
	MAX(CASE WHEN sd.sensor_name = 'EPS1' THEN s.sampling_rate_hz END) AS eps1_sampling_rate_hz,
	MAX(CASE WHEN sd.sensor_name = 'FS1' THEN sd.sensor_value END) AS volume_flow_fs1,
    MAX(CASE WHEN sd.sensor_name = 'FS1' THEN s.physical_quantity END) AS fs1_pysical_quantity,
    MAX(CASE WHEN sd.sensor_name = 'FS1' THEN s.unit END) AS fs1_unit,
	MAX(CASE WHEN sd.sensor_name = 'FS1' THEN s.sampling_rate_hz END) AS fs1_sampling_rate_hz,
	MAX(CASE WHEN sd.sensor_name = 'FS2' THEN sd.sensor_value END) AS volume_flow_min_fs2,
    MAX(CASE WHEN sd.sensor_name = 'FS2' THEN s.physical_quantity END) AS fs2_pysical_quantity,
    MAX(CASE WHEN sd.sensor_name = 'FS2' THEN s.unit END) AS fs2_unit,
	MAX(CASE WHEN sd.sensor_name = 'FS2' THEN s.sampling_rate_hz END) AS fs2_sampling_rate_hz,
	MAX(CASE WHEN sd.sensor_name = 'TS1' THEN sd.sensor_value END) AS temperature_1,
    MAX(CASE WHEN sd.sensor_name = 'TS1' THEN s.physical_quantity END) AS t1_pysical_quantity,
    MAX(CASE WHEN sd.sensor_name = 'TS1' THEN s.unit END) AS t1_unit,
	MAX(CASE WHEN sd.sensor_name = 'TS1' THEN s.sampling_rate_hz END) AS t1_sampling_rate_hz,
	MAX(CASE WHEN sd.sensor_name = 'TS2' THEN sd.sensor_value END) AS temperature_2,
    MAX(CASE WHEN sd.sensor_name = 'TS2' THEN s.physical_quantity END) AS t2_pysical_quantity,
    MAX(CASE WHEN sd.sensor_name = 'TS2' THEN s.unit END) AS t2_unit,
	MAX(CASE WHEN sd.sensor_name = 'TS2' THEN s.sampling_rate_hz END) AS t2_sampling_rate_hz,
	MAX(CASE WHEN sd.sensor_name = 'TS3' THEN sd.sensor_value END) AS temperature_3,
    MAX(CASE WHEN sd.sensor_name = 'TS3' THEN s.physical_quantity END) AS t3_pysical_quantity,
    MAX(CASE WHEN sd.sensor_name = 'TS3' THEN s.unit END) AS t3_unit,
	MAX(CASE WHEN sd.sensor_name = 'TS3' THEN s.sampling_rate_hz END) AS t3_sampling_rate_hz,
	MAX(CASE WHEN sd.sensor_name = 'TS4' THEN sd.sensor_value END) AS temperature_4,
    MAX(CASE WHEN sd.sensor_name = 'TS4' THEN s.physical_quantity END) AS t4_pysical_quantity,
    MAX(CASE WHEN sd.sensor_name = 'TS4' THEN s.unit END) AS t4_unit,
	MAX(CASE WHEN sd.sensor_name = 'TS4' THEN s.sampling_rate_hz END) AS t4_sampling_rate_hz,
	MAX(CASE WHEN sd.sensor_name = 'VS1' THEN sd.sensor_value END) AS vibration_1,
    MAX(CASE WHEN sd.sensor_name = 'VS1' THEN s.physical_quantity END) AS v1_pysical_quantity,
    MAX(CASE WHEN sd.sensor_name = 'VS1' THEN s.unit END) AS v1_unit,
	MAX(CASE WHEN sd.sensor_name = 'VS1' THEN s.sampling_rate_hz END) AS v1_sampling_rate_hz,
	MAX(CASE WHEN sd.sensor_name = 'CE' THEN sd.sensor_value END) AS cooling_efficiency,
    MAX(CASE WHEN sd.sensor_name = 'CE' THEN s.physical_quantity END) AS ce_pysical_quantity,
    MAX(CASE WHEN sd.sensor_name = 'CE' THEN s.unit END) AS ce_unit,
	MAX(CASE WHEN sd.sensor_name = 'CE' THEN s.sampling_rate_hz END) AS ce_sampling_rate_hz,
	MAX(CASE WHEN sd.sensor_name = 'CP' THEN sd.sensor_value END) AS cooling_power,
    MAX(CASE WHEN sd.sensor_name = 'CP' THEN s.physical_quantity END) AS cp_pysical_quantity,
    MAX(CASE WHEN sd.sensor_name = 'CP' THEN s.unit END) AS cp_unit,
	MAX(CASE WHEN sd.sensor_name = 'CP' THEN s.sampling_rate_hz END) AS cp_sampling_rate_hz,
	MAX(CASE WHEN sd.sensor_name = 'SE' THEN sd.sensor_value END) AS efficiency_factor_percent_se,
    MAX(CASE WHEN sd.sensor_name = 'SE' THEN s.physical_quantity END) AS se_pysical_quantity,
    MAX(CASE WHEN sd.sensor_name = 'SE' THEN s.unit END) AS se_unit,
	MAX(CASE WHEN sd.sensor_name = 'SE' THEN s.sampling_rate_hz END) AS se_sampling_rate_hz
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
	sensors s ON sd.sensor_name = s.sensor_name
GROUP BY
	sd.rig_name,
	sd.date_time,
	sd.cumulative_minutes,
	cc.cooler_percentage,
	cc.cooler_description,
	vc.valve_percentage,
	vc.valve_description,
	ipl.leakage_level,
	ipl.pump_description,
	hab.pressure_bar,
	hab.hydraulic_description,
	sf.flag_value,
	sf.flag_description
ORDER BY
	sd.well_name;
