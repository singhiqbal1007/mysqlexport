require "benchmark"
require "mysqlexport"
require "yaml"
require_relative "load_data"

DB_INFO = YAML.load_file(File.join(__dir__, "../config/configuration.yml"))
CSV_PATH = "#{__dir__}/results/csv".freeze
JSON_PATH = "#{__dir__}/results/json".freeze

module Benchmark
  class RunBenchmark
    attr_reader :ld

    def initialize
      @ld = Benchmark::LoadData.new(DB_INFO)
    end

    def load_data
      ld.start
    end

    def run_csv
      puts "*******************Running CSV Benchmarks*******************"
      Benchmark.bm(20) do |x|
        test_set.each do |row_count|
          options = { host: DB_INFO["host"],
                      username: DB_INFO["username"],
                      password: DB_INFO["password"],
                      database: DB_INFO["database"],
                      execute: "SELECT * FROM employees LIMIT #{row_count}",
                      output_path: "#{CSV_PATH}/employees_#{row_count}.csv" }
          x.report("#{"%-7d".to_s % row_count} rows: ") { Mysqlexport::Csv.new(options).to_path }
        end
      end
    end

    def run_json
      puts "*******************Running JSON Benchmarks*******************"
      Benchmark.bm(20) do |x|
        test_set.each do |row_count|
          options = { host: DB_INFO["host"],
                      username: DB_INFO["username"],
                      password: DB_INFO["password"],
                      database: DB_INFO["database"],
                      execute: "SELECT * FROM employees LIMIT #{row_count}",
                      output_path: "#{JSON_PATH}/employees_#{row_count}.json" }
          x.report("#{"%-7d".to_s % row_count} rows: ") { Mysqlexport::Csv.new(options).to_path }
        end
      end
    end

    private

    def test_set
      rows = ld.rows
      ld.close
      arr = [1000]
      if rows > arr.last
        val = 5000
        while val <= rows
          arr.append(val)
          val *= 5 if arr.count.odd?
          val *= 2 if arr.count.even?
        end
      else
        arr = [rows]
      end
      arr
    end
  end
end
