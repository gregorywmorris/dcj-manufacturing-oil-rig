
IF NOT EXISTS CREATE DATABASE energymobile;

USE energymobile;

DROP TABLE IF EXISTS sensors;
DROP TABLE IF EXISTS cooler_condition;
DROP TABLE IF EXISTS valve_condition;
DROP TABLE IF EXISTS pump_leakage;
DROP TABLE IF EXISTS hydraulic_accumulator;
DROP TABLE IF EXISTS stable_flag;
DROP TABLE IF EXISTS sensor_data;

CREATE TABLE sensors (
  sensor_name varchar(255) not null,
  physical_quantity varchar(255) not null,
  unit varchar(255) not null,
  sampling_rate varchar(255) not null,
  primary key (sensor_name)
);

CREATE TABLE cooler_condition (
  cooler_id int not null,
  condition_percentage float not null,
  cooler_description varchar(255) not null,
  primary key (id)
);

CREATE TABLE valve_condition (
  valve_id int not null,
  condition_percentage float not null,
  valve_description varchar(255) not null,
  primary key (id)
);

CREATE TABLE pump_leakage (
  leakage_level int not null,
  pump_description varchar(255) not null,
  primary key (leakage_level)
);

CREATE TABLE hydraulic_accumulator (
  pressure_bar int not null,
  hydraulic_description varchar(255) not null,
  primary key (pressure_bar)
);

CREATE TABLE stable_flag (
  flag_value int not null,
  flag_description varchar(255) not null,
  primary key (flag_value)
);

CREATE TABLE sensor_data (
  data_id int not null auto_increment,
  sensor_name varchar(255),
  time_stamp datetime,
  cumulative_minutes int,
  cohort int,
  sensor_value int,
  cooler_condition int,
  valve_condition int,
  pump_leakage int,
  hydraulic_accumulator int,
  stable_flag int,
  primary key (data_id),
  FOREIGN KEY (sensor_name) REFERENCES sensors(sensor_name),
  FOREIGN KEY (cooler_condition) REFERENCES cooler_condition(cooler_id),
  FOREIGN KEY (valve_condition) REFERENCES valve_condition(valve_id),
  FOREIGN KEY (pump_leakage) REFERENCES pump_leakage(leakage_level),
  FOREIGN KEY (hydraulic_accumulator) REFERENCES hydraulic_accumulator(pressure_bar),
  FOREIGN KEY (stable_flag) REFERENCES stable_flag(flag_value)
);