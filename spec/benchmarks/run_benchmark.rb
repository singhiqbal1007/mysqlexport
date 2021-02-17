require "benchmark"
require "mysqlexport"
require "yaml"
require_relative "load_data"

db_info = YAML.load_file(File.join(__dir__, "../config/configuration.yml"))
csv_path = "#{__dir__}/results/csv".freeze
# Benchmark::LoadData.new(db_info).start unless ENV["SKIP_DATA_LOAD"].to_s.downcase == "true"

puts "Running Benchmarks..."
Benchmark.bm(20) do |x|
  %w[1000 10000 100000 300000].each do |row_count|
    options = { host: db_info["host"],
                username: db_info["username"],
                password: db_info["password"],
                database: db_info["database"],
                execute: "SELECT * FROM employees LIMIT #{row_count}",
                output_path: "#{csv_path}/employees_#{row_count}.csv" }
    x.report("#{"%-7d".to_s % row_count} rows: ") { Mysqlexport::Csv.new(options).to_path }
  end
end
