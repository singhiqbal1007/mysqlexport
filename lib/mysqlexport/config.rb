module Mysqlexport
  class Config
    attr_reader :user_specified_options

    def initialize(user_specified_options = {})
      @user_specified_options = user_specified_options.symbolize_keys
    end

    def host
      user_specified_options[:host] || active_record_config.try(:[], :host)
    end

    def port
      user_specified_options[:port] || active_record_config.try(:[], :port)
    end

    def username
      user_specified_options[:username] || active_record_config.try(:[], :username)
    end

    def password
      user_specified_options[:password] || active_record_config.try(:[], :password)
    end

    def database
      user_specified_options[:database] || active_record_connection.try(:current_database)
    end

    def socket
      user_specified_options[:socket] || active_record_config.try(:[], :socket)
    end

    def execute
      user_specified_options[:execute] || "select * from #{table}"
    end

    def table
      user_specified_options[:table]
    end

    def force_quotes
      user_specified_options[:force_quotes].to_s.downcase == "true" || nil
    end

    def col_sep
      user_specified_options[:col_sep]
    end

    def row_sep
      user_specified_options[:row_sep]
    end

    def output_path
      user_specified_options[:output_path]
    end

    def client
      return @client if @client.is_a? ::Mysql2::Client

      @client = ::Mysql2::Client.new(host: host, port: port, username: username,
                                     password: password, database: database, socket: socket)
    end

    private

    def active_record_connection
      ::ActiveRecord::Base.connection if defined?(::ActiveRecord)
    rescue StandardError
      # oh well
    end

    def active_record_config
      active_record_connection&.instance_variable_get :@config
    end
  end
end
