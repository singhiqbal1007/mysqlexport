if RUBY_VERSION >= "1.9"
  require "csv"
else
  require "fastercsv"
end
require_relative "writer"
module Mysqlexport
  class Csv
    include Writer
    attr_reader :client, :sql

    def initialize(options = {})
      @config = Mysqlexport::Config.new options
      @client = @config.client
      @sql = @config.execute
    end

    def print
      result = client.query(sql, :stream => true, :cache_rows => false, :as => :array)
      result.each do |r|
        puts r.to_csv(:force_quotes => false, :col_sep => "\t")
      end
    end

  end
end
