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
    $ mysqlexport --help
```
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
  execute: "select * from employees",
}
Mysqlexport::Csv.new(options).to_stdout  # write it directly to $stdout
Mysqlexport::Csv.new(options).to_path('/tmp/outfile.json')  # write it to a file at this path
Mysqlexport::Csv.new(options).to_file(File.open('/tmp/outfile.json', 'w'))  # write it to a file handle
```

If you're running it inside a Rails application, it will default to the ActiveRecord connection config.

```ruby
csv = Mysqlexport::Csv.new execute: "select * from employees" # no need to specify username, password
csv.to_stdout  
```


## Development
Rename the file `spec/configuration.yml.example` to `spec/configuration.yml`, then set the mysql configurations and test database. see example configuration below.
```
host: localhost
username: root
password: 
database: mysqlexport_test
```
Use `bundle install` to install the necessary development & testing gems and run rake for running the tests.
```
bundle install
rake
```
Database named `mysqlexport_test` will automatically be created.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
