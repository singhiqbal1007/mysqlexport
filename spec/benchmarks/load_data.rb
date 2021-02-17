require "mysql2"

DUMP_PATH = File.read("#{__dir__}/dumps/load_employees.dump")

module Benchmark
  class LoadData
    attr_reader :db_info, :client

    def initialize(db_info)
      @db_info = db_info
      @client = ::Mysql2::Client.new({  host: db_info["host"],
                                        username: db_info["username"],
                                        password: db_info["password"],
                                        flags: Mysql2::Client::MULTI_STATEMENTS })
    end

    def start
      puts "Loading Data into mysql. This could take few minutes..."
      client.query(sql)
      while client.next_result
        result = client.store_result
        puts result.first["INFO"] unless result.nil?
      end
      puts "Sucessfully loaded data..."
    end

    def rows
      q = "USE #{db_info["database"]}; SELECT count(*) from employees;"
      r = client.query(q, as: :array)
      c = 0
      while client.next_result
        r = client.store_result
        c = r.first.first unless r.nil?
      end
      c
    end

    def close
      client.close
    end

    private

    def sql # rubocop:disable Metrics/MethodLength
      %(
        DROP DATABASE IF EXISTS #{db_info["database"]};
        CREATE DATABASE IF NOT EXISTS #{db_info["database"]};
        USE #{db_info["database"]};
        SELECT 'Sucessfully Created database #{db_info["database"]}...' as 'INFO';
        DROP TABLE IF EXISTS employees;
        CREATE TABLE employees (
            emp_no      INT             NOT NULL,
            birth_date  DATE            NOT NULL,
            first_name  VARCHAR(14)     NOT NULL,
            last_name   VARCHAR(16)     NOT NULL,
            gender      ENUM ('M','F')  NOT NULL,
            hire_date   DATE            NOT NULL,
            PRIMARY KEY (emp_no)
        );
        SELECT 'Sucessfully created table employees...' as 'INFO';
        SELECT 'Loading data into employees table..' as 'INFO';
        #{DUMP_PATH}
        ).freeze
    end
  end
end
