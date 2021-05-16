# Mysqlexport
Gives you binary `mysqlexport` and ruby classes `Mysqlexport::Csv` and `Mysqlexport::Json` to export mysql tables into csv or json file respectively.

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
$ mysqlexport --user=root --password=root --database=mysqlexport_test --table=employees --to=csv
```

#### options
```
$ mysqlexport --help
    
    -u, --username=USERNAME          Set MySQL username
    -p, --password=PASSWORD          Set MySQL password
    -h, --host=HOST                  Set MySQL host
    -P, --port=PORT                  Set MySQL port
    -d, --database=DATABASE          Set MySQL database
    -s, --socket=SOCKET              Set MySQL socket
    -T, --to=CSV                     Export Mysql table to CSV/JSON
    -e, --execute=EXECUTE            The SQL statement to execute
    -o, --out=PATH                   output path, default is current directory
    -t, --table=TABLE                MySQL table you want to export

CSV Options
    -f, --force-quotes=false         force quotes to csv, default is false
    -c, --col-sep=,                  column separtor for csv, default is ","
    -r, --row-sep=\n                 row separator for csv, default is "\n"
    -H, --csv-heading=true           show csv heading, default is true

JSON Options
    -y, --pretty=false               display json pretty, default is false
    -j, --json-engine=oj             choose json engine
```

## Use in Ruby
#### Ruby classes
```ruby
Mysqlexport::Csv.new(options) # create csv object
Mysqlexport::Json.new(options) # create json object
```
#### Methods Suported
```ruby
to_stdout  # write it directly to $stdout
to_path(String)  # write it to a file at this path
to_file(File)  # write it to a file handle
```
#### Usage
```ruby
require 'mysqlexport'
options = {
  username: "root",
  password: "root",
  database: "mysqlexport_test",
  execute: "select * from employees"
}
Mysqlexport::Csv.new(options).to_stdout
Mysqlexport::Csv.new(options).to_path('/tmp/table.csv')
Mysqlexport::Json.new(options).to_file(File.open('/tmp/table.json', 'w')) 
```

#### All available options
##### General options
 
```py
  host: "127.0.0.1", # optional, default is 127.0.0.1
  port: "3306", # optional, default is 3306
  username: "root", # optional if using Active record
  password: "root", # optional if using Active record
  database: "mysqlexport_test", # optional if using Active record
  socket: "/path/to/mysql.sock", # optional
  execute: "select * from employees", # not required if table is given
  table: "employees" # not required if execute query is given
```

##### csv options (only works with `Mysqlexport::Csv` class)
```py
  force_quotes: true, # optional, default is false
  col_sep: ",", # optional, default is ','
  row_sep: "", # optional, default is '\n'
  output_path: "/tmp/employees.csv" # optional, default is current directory
```

##### json options (only works with `Mysqlexport::Json` class)
```py
  pretty: false # display json pretty, default is false
```

## More Uses
#### ActiveRecord Support
If you're running it inside a Rails application, it will default to the `ActiveRecord` connection configurations.

```ruby
csv = Mysqlexport::Csv.new execute: "select * from employees" # no need to specify username, password or database
csv.to_stdout

json = Mysqlexport::Json.new table: "employees" # no need to specify username, password or database
json.to_stdout 
```

#### to_path method/out option 
Supports both relative and absolute path
##### ruby
```ruby
Mysqlexport::Csv.new(options).to_path('/tmp/table.csv') # this will create a file with name table.csv at given path
Mysqlexport::Csv.new(options).to_path('table.csv') # this will create file with name table.csv at current directory
```

##### binary
create a file with name table.csv at given path
```
$ mysqlexport --user=root --password=root --database=mysqlexport_test --table=employees --to=csv --out=/tmp/table.csv
```
create file with name table.csv at current directory
```
$ mysqlexport --user=root --password=root --database=mysqlexport_test --table=employees --to=csv --out=table.csv
```
When directory is given in path. It will create a file inside the directory.
##### ruby
```ruby
Mysqlexport::Csv.new(options).to_path('/tmp/mydir') # this will create a file inside mydir
Mysqlexport::Csv.new(options).to_path # this will create a file in the current directory
```

##### binary
create a file inside a directory
```
$ mysqlexport --user=root --password=root --database=mysqlexport_test --table=employees --to=csv --out=/tmp/mydir
```
create a file in current directory
```
$ mysqlexport --user=root --password=root --database=mysqlexport_test --table=employees --to=csv
```

What would be the file name in above cases? It takes file name from table option. If table option is not provided it will generate a file with current timestamp.
##### ruby
```ruby
Mysqlexport::Json.new({ table: "employees" }).to_path('/tmp/mydir') # this will create a file with name employees.json
Mysqlexport::Json.new({ execute: "select * from employees" }).to_path('/tmp/mydir') # this will create a file with current timestamp.
Mysqlexport::Json.new({
    table: "employees",
    execute: "select * from employees limit 2"
}).to_path('/tmp/mydir') # this will create a file with name employees.json
```
##### binary
Create a file with name employees.json
```
$ mysqlexport --user=root --password=root --database=mysqlexport_test --table=employees --to=json --out=/tmp/mydir
```
This will create a file with current timestamp
```
$ mysqlexport --user=root --password=root --database=mysqlexport_test --execute="select * from employees" --to=json --out=/tmp/mydir
```
This will create a file with name employees.json
```
$ mysqlexport --user=root --password=root --database=mysqlexport_test --table=emplyees --execute="select * from employees" --to=json --out=/tmp/mydir
```

#### Json Engine
It uses [multi_json][multi_json] to convert to json.

#### Supported JSON Engines
* [Oj][oj] Optimized JSON by Peter Ohler
* [Yajl][yajl] Yet Another JSON Library by Brian Lopez
* [JSON][json-gem] The default JSON gem with C-extensions (ships with Ruby 1.9+)
* [JSON Pure][json-gem] A Ruby variant of the JSON gem
* [NSJSONSerialization][nsjson] Wrapper for Apple's NSJSONSerialization in the Cocoa Framework (MacRuby only)
* [gson.rb][gson] A Ruby wrapper for google-gson library (JRuby only)
* [JrJackson][jrjackson] JRuby wrapper for Jackson (JRuby only)
* [OkJson][okjson] A simple, vendorable JSON parser

#### Usecase
##### ruby
In case of ruby classes to use a json engine, it should be already loaded.
```ruby
require 'mysqlexport'
require 'oj'
Mysqlexport::Json.new(options).to_stdout
```
##### binary
In case of the binary, it will try to load the specified json engine in the option `json_engine`. Make sure you have the json engine already installed in order to use it. If it is unable to load json engine it will default to OkJson.
```
$ mysqlexport --user=root --password=root --database=mysqlexport_test --table=employees --to=json --json-engine=oj
```

## Development
#### Configurations
Go to `spec/configuration.yml`, then set the mysql configurations and test database. see example configuration below.
```
host: localhost
username: root
password: 
database: mysqlexport_test
```

#### Unit Tests and Rubocop
Use `bundle install` to install the necessary development & testing then `bundle exec rake`  for running both unit_tests and rubocop. Database named `mysqlexport_test` and table named `unit_tests` with some data will automatically be created.
```
$ bundle install
$ bundle exec rake
```

##### Other rake tasks
`bundle exec rake unit_tests` to run only unit tests
`bundle exec rake rubocop` to run only rubocop

#### Benchmarks
##### Running benchmarks
```
$ bundle exec rake benchmark:all:run
```
It will insert 1 million rows in mysql and runs the benchmark on it. Database named `mysqlexport_test` and table named `employees` will automatically be created.

##### Latest Benchmark Results
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

##### All available rake tasks for benchmark
```ruby
benchmark:all:run # load data into mysql, run benchmarks for csv and json
benchmark:all:skip_data_load # do not load data into mysql, run benchmarks for csv and json
benchmark:csv:run # load data into mysql, run benchmarks for csv
benchmark:csv:skip_data_load # do not load data into mysql, run benchmarks for csv
benchmark:json:run # load data into mysql, run benchmarks for only json
benchmark:json:skip_data_load # do not load data into mysql, run benchmarks for only json
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

[gson]: https://github.com/avsej/gson.rb
[jrjackson]: https://github.com/guyboertje/jrjackson
[json-gem]: https://github.com/flori/json
[json-pure]: https://github.com/flori/json
[oj]: https://github.com/ohler55/oj
[okjson]: https://github.com/kr/okjson
[yajl]: https://github.com/brianmario/yajl-ruby
[multi_json]: https://github.com/intridea/multi_json
[nsjson]: https://developer.apple.com/documentation/foundation/jsonserialization
