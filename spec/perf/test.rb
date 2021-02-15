require "benchmark"
require "mysqlexport"

Benchmark.bm(7) do |x|
  x.report("3 lakh records:") do
    Mysqlexport::Csv.new(username: "root",
                         password: "root",
                         database: "mysqlexport_test",
                         execute: "select * from employees").to_path("/home/iqbal/Desktop/table.csv")
  end
end
