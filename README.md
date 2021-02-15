# Mysqlexport

Gives you binary `mysqlexport` and ruby class `Mysqlexport::Csv` to export mysql tables into csv file.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mysqlexport'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mysqlexport

## Usage

#### Binaries
    $ mysqlexport --user=root --password=root --database=mysqlexport_test --table=employees

##### options
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
##### All available options
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

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
