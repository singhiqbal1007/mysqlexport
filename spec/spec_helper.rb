# frozen_string_literal: true

require "mysqlexport"
require "mysqlexport/cli/cli"
require "mysqlexport/cli/help_parser"
require "yaml"
require "fakefs/safe"

DB_INFO = YAML.load_file(File.join(__dir__, "config/configuration.yml")).transform_keys(&:to_sym)
DB_INFO[:table] = "unit_tests"
CLIENT = Mysql2::Client.new({ host: DB_INFO[:host],
                              username: DB_INFO[:username],
                              password: DB_INFO[:password] })

CLIENT.query("CREATE DATABASE IF NOT EXISTS #{DB_INFO[:database]}")
CLIENT.query("USE #{DB_INFO[:database]}")
CLIENT.query("DROP TABLE IF EXISTS #{DB_INFO[:table]}")
CLIENT.query("CREATE TABLE #{DB_INFO[:table]} (first_name VARCHAR(14) NOT NULL, last_name VARCHAR(16) NOT NULL,birth_date DATE NOT NULL)")
CLIENT.query("INSERT INTO `#{DB_INFO[:table]}` VALUES ('Georgi','Facello','1986-06-26'), ('Bezalel','Simmel','1985-11-21'),('Parto','Bamford','1986-08-28')")
CLIENT.close

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
