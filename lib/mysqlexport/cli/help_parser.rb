require "optparse"
module Mysqlexport
  class HelpParser
    def parse(hsh)
      OptionParser.new do |opts|
        opts.banner = "Usage: mysqlexport [options]"
        hsh.tap { |h| h.delete(:help) }
        all = []
        all.append([[], nil])
        all.append([[], "\nCSV Options"])
        all.append([[], "\nJSON Options"])
        hsh.each do |o|
          case o[1][:type]
          when "csv"
            all[1][0].append(o[1])
          when "json"
            all[2][0].append(o[1])
          else
            all[0][0].append(o[1])
          end
        end
        all.map do |category|
          opts.on category[1] unless category[1].nil?
          category[0].each do |o|
            short = o[:short].slice(0, 2)
            long = o[:long]
            desc = o[:description]
            opts.on(short, long, desc)
          end
        end
      end.parse!
    end

    def info
      puts "mysqlexport info"
    end
  end
end
