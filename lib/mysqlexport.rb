# frozen_string_literal: true

require "active_support"
require "active_support/version"
require "active_support/core_ext" if ::ActiveSupport::VERSION::MAJOR >= 3

require "mysql2"

require_relative "mysqlexport/version"
require_relative "mysqlexport/config"
require_relative "mysqlexport/csv"
require_relative "mysqlexport/writer"

module Mysqlexport
  class Error < StandardError; end
  # options = {
  #   username: "root",
  #   password: "root",
  #   database: "mysqlexport_test",
  #   execute: "select * from employees",
  #   force_quotes: "",
  #   col_sep: "",
  #   row_sep: ""
  # }
  # csv = Mysqlexport::Csv.new options
end
