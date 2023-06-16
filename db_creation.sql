CREATE DATABASE IF NOT EXISTS energymobile;

USE energymobile;

DROP TABLE IF EXISTS sensor_data;
DROP TABLE IF EXISTS sensors;
DROP TABLE IF EXISTS cooler_condition;
DROP TABLE IF EXISTS valve_condition;
DROP TABLE IF EXISTS internal_pump_leakage;
DROP TABLE IF EXISTS hydraulic_accumulator_bar;
DROP TABLE IF EXISTS stable_flag;


CREATE TABLE sensors (
  sensor_name varchar(255) not null,
  physical_quantity varchar(255) not null,
  unit varchar(255) not null,
  sampling_rate_hz int not null,
  PRIMARY KEY (sensor_name)
);

CREATE TABLE cooler_condition (
  cooler_id int not null,
  cooler_percentage float not null,
  cooler_description varchar(255) not null,
  PRIMARY KEY (cooler_id)
);

CREATE TABLE valve_condition (
  valve_id int not null,
  valve_percentage float not null,
  valve_description varchar(255) not null,
  PRIMARY KEY (valve_id)
);

CREATE TABLE internal_pump_leakage (
  leakage_level int not null,
  pump_description varchar(255) not null,
  PRIMARY KEY (leakage_level)
);

CREATE TABLE hydraulic_accumulator_bar (
  pressure_bar int not null,
  hydraulic_description varchar(255) not null,
  PRIMARY KEY (pressure_bar)
);

CREATE TABLE stable_flag (
  flag_value int not null,
  flag_description varchar(255) not null,
  PRIMARY KEY (flag_value)
);


CREATE TABLE sensor_data (
  data_id int not null auto_increment,
  well_name varchar(255),
  sensor_name varchar(255),
  sensor_value float,
  date_time datetime,
  cumulative_minutes int,
  well_profile int,
  cooler_condition int,
  valve_condition int,
  internal_pump_leakage int,
  hydraulic_accumulator_bar int,
  stable_flag int,
  PRIMARY KEY (data_id),
  FOREIGN KEY (cooler_condition) REFERENCES cooler_condition(cooler_id),
  FOREIGN KEY (valve_condition) REFERENCES valve_condition(valve_id),
  FOREIGN KEY (internal_pump_leakage) REFERENCES internal_pump_leakage(leakage_level),
  FOREIGN KEY (hydraulic_accumulator_bar) REFERENCES hydraulic_accumulator_bar(pressure_bar),
  FOREIGN KEY (stable_flag) REFERENCES stable_flag(flag_value),
  FOREIGN KEY (sensor_name) REFERENCES sensors(sensor_name)
);

INSERT INTO cooler_condition
VALUES (3, 0.03, 'close to total failure'), (20, 0.20, 'reduced efficiency'), (100, 1.00, 'close to total failure');

INSERT INTO valve_condition
VALUES (100, 1.00, 'optimal switching behavior'), (90, 0.90, 'small lag'), (80, 0.80, 'severe lag'), (73, 0.73, 'closer to total failure');

INSERT INTO internal_pump_leakage
VALUES (0, 'no leakage'), (1, 'weak leakage'), (2, 'severe leakage');

INSERT INTO hydraulic_accumulator_bar
VALUES (130, 'optimal pressure'), (115, 'slightly reduced pressure'), (100, 'severely reduced pressure'), (90, 'close to total failure');

INSERT INTO stable_flag
VALUES (0, 'conditions were stable'), (1, 'static conditions might not have been reached yet');

INSERT INTO sensors
VALUES
  ('PS1', 'Pressure', 'bar', 100),
  ('PS2', 'Pressure', 'bar', 100),
  ('PS3', 'Pressure', 'bar', 100),
  ('PS4', 'Pressure', 'bar', 100),
  ('PS5', 'Pressure', 'bar', 100),
  ('PS6', 'Pressure', 'bar', 100),
  ('EPS1', 'motor power','w', 100),
  ('FS1', 'Volume flow', 'l/min', 10),
  ('FS2', 'Volume flow', 'l/min', 10),
  ('TS1', 'Temperature', 'celsius', 1),
  ('TS2', 'Temperature', 'celsius', 1),
  ('TS3', 'Temperature', 'celsius', 1),
  ('TS4', 'Temperature', 'celsius', 1),
  ('VS1', 'Vibration', 'mm/s', 1),
  ('CE', 'Cooling efficiency (virtual)', 'percent', 1),
  ('CP', 'Cooling power (virtual)', 'kW', 1),
  ('SE', 'Efficiency factor', 'percent', 1);
