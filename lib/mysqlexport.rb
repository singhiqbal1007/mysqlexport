# frozen_string_literal: true

require "active_support"
require "active_support/version"
require "active_support/core_ext" if ::ActiveSupport::VERSION::MAJOR >= 3

require "mysql2"

require "mysqlexport/version"
require "mysqlexport/config"
require "mysqlexport/writer"
require "mysqlexport/writer/csv"
require "mysqlexport/writer/json"

module Mysqlexport
  class Error < StandardError
    def initialize(msg = "Mysqlexport::Error")
      super(msg)
    end
  end
end
