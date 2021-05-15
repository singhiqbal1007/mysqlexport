module Mysqlexport
  class Writer
    attr_reader :client, :sql, :config

    def initialize(options = {})
      validate!(options)
      @config = Mysqlexport::Config.new options
      @client = @config.client
    end

    def to_stdout
      to_file $stdout
      nil
    end

    def filter_path(path)
      path = ::Dir.pwd.to_s unless path.instance_of? ::String
      file_name = "/#{::Time.now.to_i}_mysqlexport.#{extension}" if ::File.directory?(path)
      file_name = "/#{config.table}.#{extension}" if ::File.directory?(path) && !config.table.nil?
      path += file_name.to_s
      path
    end

    def to_path(path = config.output_path)
      f = ::File.open(filter_path(path), "w")
      to_file f
      f.close
      nil
    end

    def to_s
      s = ::StringIO.new
      to_file s
      s.rewind
      s.read
    end

    private

    def validate!(options)
      raise Error, "[required option missing] execute or table required in options" if options[:table].nil? && options[:execute].nil?

      true
    end

    def extension
      # default extension is csv
      return "json" if instance_of? Mysqlexport::Json

      "csv"
    end
  end
end
