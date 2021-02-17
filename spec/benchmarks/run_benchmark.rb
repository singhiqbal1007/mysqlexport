require "benchmark"
require "mysqlexport"
require "yaml"
require_relative "load_data"

DB_INFO = YAML.load_file(File.join(__dir__, "../config/configuration.yml"))
Benchmark::LoadData.new(DB_INFO).start unless ENV["SKIP_DATA_LOAD"].to_s.downcase == "true"

Benchmark.bm(7) do |x|
  x.report("3 lakh records:") do
    Mysqlexport::Csv.new( host: DB_INFO["host"],
                          username: DB_INFO["username"],
                          password: DB_INFO["password"],
                          database: DB_INFO["database"],
                          execute: "select * from employees").to_path("/home/iqbal/Desktop/table.csv")
  end
end
