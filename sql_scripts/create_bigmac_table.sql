DROP TABLE big_mac_wage;

CREATE TABLE big_mac_wage (
  date varchar(50) DEFAULT NULL,
  iso_a3 varchar(50) DEFAULT NULL,
  currency_code varchar(50) DEFAULT NULL,
  name varchar(50) DEFAULT NULL,
  local_price double DEFAULT NULL,
  dollar_ex int DEFAULT NULL,
  dollar_price double DEFAULT NULL,
  USD_raw double DEFAULT NULL,
  EUR_raw double DEFAULT NULL,
  GBP_raw double DEFAULT NULL,
  JPY_raw double DEFAULT NULL,
  CNY_raw double DEFAULT NULL,
  GDP_dollar double DEFAULT NULL,
  adj_price double DEFAULT NULL,
  USD_adjusted double DEFAULT NULL,
  EUR_adjusted double DEFAULT NULL,
  GBP_adjusted double DEFAULT NULL,
  JPY_adjusted double DEFAULT NULL,
  CNY_adjusted double DEFAULT NULL,
  min_wage double DEFAULT NULL,
  visitors double DEFAULT NULL,
  income double DEFAULT NULL,
  outcome double DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);