# Mysqlexport

Gives you binary `mysqlexport` and ruby class `Mysqlexport::Csv` to export mysql tables into csv file.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mysqlexport'
```

And then execute:
```
$ bundle install
```

Or install it yourself as:
```
$ gem install mysqlexport
```


## Usage

#### Binaries
```
$ mysqlexport --user=root --password=root --database=mysqlexport_test --table=employees
```

#### options
```
    $ mysqlexport --help
    
    -c, --col-sep=,                  column separtor for csv, default is ","
    -d, --database=DATABASE          Set MySQL database
    -e, --execute=EXECUTE            The SQL statement to execute
    -f, --force-quotes=true          force quotes to csv, default is false
    -h, --host=HOST                  Set MySQL host
    -o, --out=PATH                   output path, default is current directory
    -p, --password=PASSWORD          Set MySQL password
    -P, --port=PORT                  Set MySQL port
    -r, --row-sep=\n                 row separator for csv, default is "\n"
    -s, --socket=SOCKET              Set MySQL socket
    -t, --table=TABLE                MySQL table you want to export
    -u, --username=USERNAME          Set MySQL username
        --help                       Show help

```
#### Ruby Class
```ruby
options = {
  username: "root",
  password: "root",
  database: "mysqlexport_test",
  execute: "select * from employees"
}
Mysqlexport::Csv.new(options).to_stdout  # write it directly to $stdout
Mysqlexport::Csv.new(options).to_path('/tmp/table.csv')  # write it to a file at this path
Mysqlexport::Csv.new(options).to_file(File.open('/tmp/table.csv', 'w'))  # write it to a file handle
```
#### All available options
```ruby
Mysqlexport::Csv.new(
  host: "127.0.0.1", # optional, default is 127.0.0.1
  port: "3306", # optional, default is 3306
  username: "root", # optional if using Active record
  password: "root", # optional if using Active record
  database: "mysqlexport_test", # optional if using Active record
  socket: "/path/to/mysql.sock", # optional
  execute: "select * from employees", # not required if table is given
  table: "employees", # not required if execute query is given
  force_quotes: true, # optional, default is false
  col_sep: ",", # optional, default is ","
  row_sep: "", # optional, default is "\n"
  output_path: "/tmp/employees.csv" # optional, default is current directory
)
```


If you're running it inside a Rails application, it will default to the ActiveRecord connection config.

```ruby
csv = Mysqlexport::Csv.new execute: "select * from employees" # no need to specify username, password
csv.to_stdout  
```


## Development
Go to `spec/configuration.yml`, then set the mysql configurations and test database. see example configuration below.
```
host: localhost
username: root
password: 
database: mysqlexport_test
```
Use `bundle install` to install the necessary development & testing gems and `bundle exec rake` for running the tests.
```
$ bundle install
$ bundle exec rake
```
Database named `mysqlexport_test` will automatically be created.


## Benchmarks

#### Running benchmarks
```
$ bundle exec rake benchmark:run
```
It will insert 1 million rows in mysql and run the tests on it.


#### Latest Benchmark Results
```
                           user     system      total        real
1000    rows:          0.043286   0.003848   0.047134 (  0.047876)
5000    rows:          0.142942   0.003945   0.146887 (  0.147594)
10000   rows:          0.287696   0.004216   0.291912 (  0.310871)
50000   rows:          1.417689   0.004253   1.421942 (  1.484315)
100000  rows:          2.786458   0.012036   2.798494 (  2.839488)
500000  rows:         13.706715   0.044224  13.750939 ( 15.014367)
1000000 rows:         27.928350   0.183935  28.112285 ( 29.992699)
```

If you want to skip loading data into mysql
```
$ bundle exec rake benchmark:skip_data_load
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
