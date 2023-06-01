
CREATE DATABASE energymobile;

use energymobile;

CREATE TABLE `wellTests` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `s2` float,
  `ps1` float,
  `ps2` float,
  `ps3` float,
  `ps4` float,
  `ps5` float,
  `ps6` float,
  `se` float,
  `ts1` float,
  `ts2` float,
  `ts3` float,
  `ts4` float,
  `vs1` float,
  `cumulative_minutes` integer,
  `cohort` integer,
  `date_time` datetime,
  `cooler_condition` integer,
  `valve_condition` integer,
  `internal_pump_leakage` integer,
  `hydrolic_acucumlator_bar` integer,
  `stable_flag` integer
);
