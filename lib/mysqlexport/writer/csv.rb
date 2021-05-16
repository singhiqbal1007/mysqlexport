if RUBY_VERSION >= "1.9"
  require "csv"
else
  require "fastercsv"
end
module Mysqlexport
  class Csv < Writer
    def initialize(options = {})
      super(**options)
    end

    def to_file(file)
      result = client.query(config.execute, stream: true, cache_rows: false, as: :array)
      csv_o = csv_options
      file.write result.fields.to_csv(**csv_o) if config.csv_heading
      result.each do |row|
        file.write row.to_csv(**csv_o)
      end
    end

    private

    def csv_options
      options = {}
      options[:force_quotes] = config.force_quotes unless config.force_quotes.nil?
      options[:col_sep] = config.col_sep unless config.col_sep.nil?
      options[:row_sep] = config.row_sep unless config.row_sep.nil?
      options
    end
  end
end
