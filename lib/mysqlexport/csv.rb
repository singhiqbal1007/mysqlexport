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

    def print
      csv_options = {}
      csv_options[:force_quotes] = config.force_quotes unless config.force_quotes.nil?
      csv_options[:col_sep] = config.col_sep unless config.col_sep.nil?
      csv_options[:row_sep] = config.row_sep unless config.row_sep.nil?
      result = client.query(config.execute, stream: true, cache_rows: false, as: :array)
      result.each do |r|
        puts r.to_csv(**csv_options)
      end
    end
  end
end
