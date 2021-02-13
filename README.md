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



## Development
Rename the file `spec/configuration.yml.example` to `spec/configuration.yml` and set the mysql configurations and test database. see example configuration below.
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

