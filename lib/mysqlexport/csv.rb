if RUBY_VERSION >= "1.9"
  require "csv"
else
  require "fastercsv"
end
require_relative "writer"
module Mysqlexport
  class Csv
    include Writer
    attr_reader :client, :sql, :config

    def initialize(options = {})
      @config = Mysqlexport::Config.new options
      @client = @config.client
    end

    def to_file(file)
      result = client.query(config.execute, stream: true, cache_rows: false, as: :array)
      file.write result.fields.to_csv(**csv_options)
      result.each do |row|
        file.write row.to_csv(**csv_options)
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
