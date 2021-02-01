if RUBY_VERSION >= "1.9"
  require "csv"
else
  require "fastercsv"
end
require_relative "writer"
module Mysqlexport
  class Csv
    include Writer
    attr_reader :client, :query

    def initialize(options = {})
      @config = Mysqlexport::Config.new options
      @client = @config.client
      @query = @config.query
    end

    def print
      results = client.query(query)
      results.each do |row|
        puts row["emp_no"]
      end
    end

    private

    def slash_n
      user_specified_options.fetch :slash_n, false
    end
  end
end
