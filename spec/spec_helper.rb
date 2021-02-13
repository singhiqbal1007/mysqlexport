# frozen_string_literal: true

require "mysqlexport"
require "yaml"

DB_INFO = YAML.load_file(File.join(__dir__, "config/configuration.yml"))

CLIENT = Mysql2::Client.new({ host: DB_INFO["host"],
                              username: DB_INFO["username"],
                              password: DB_INFO["password"] })

# CLIENT.query("DROP DATABASE IF EXISTS #{DB_INFO["database"]}")
# CLIENT.query("CREATE DATABASE #{DB_INFO["database"]}")
# CLIENT.close

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
