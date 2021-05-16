require "multi_json"

module Mysqlexport
  class Json < Writer
    def initialize(options = {})
      super(**options)
    end

    def to_file(file)
      first = true
      json_o = json_options
      file.write "["
      client.query(config.execute, stream: true, cache_rows: false).each do |h|
        next if h.nil?

        if first
          first = false
        else
          file.write ","
        end
        file.write ::MultiJson.dump(h, **json_o)
      end
      file.write "]"
      nil
    end

    private

    def json_options
      options = {}
      options[:pretty] = config.pretty unless config.pretty.nil?
      options
    end
  end
end
