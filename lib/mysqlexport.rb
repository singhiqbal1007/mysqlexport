# frozen_string_literal: true

require "active_support"
require "active_support/version"
require "active_support/core_ext" if ::ActiveSupport::VERSION::MAJOR >= 3

require "mysql2"

require "mysqlexport/version"
require "mysqlexport/config"
require "mysqlexport/csv"

module Mysqlexport
  class Error < StandardError; end
end
