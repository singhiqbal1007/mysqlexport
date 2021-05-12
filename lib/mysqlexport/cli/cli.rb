require "mixlib/cli"

module Mysqlexport
  class Cli
    include ::Mixlib::CLI
    %w[username password host Port database socket].each do |o|
      option o.downcase.to_sym, { short: "-#{o[0, 1]} #{o.upcase}",
                                  long: "--#{o.downcase}=#{o.upcase}",
                                  description: "Set MySQL #{o.downcase}" }
    end
    option :to, {  short: "-T TO",
                   long: "--to=CSV",
                   description: "Export Mysql to CSV/JSON" }
    option :execute, {  short: "-e EXECUTE",
                        long: "--execute=EXECUTE",
                        description: "The SQL statement to execute" }
    option :force_quotes, { short: "-f false",
                            long: "--force-quotes=false",
                            type: "csv",
                            description: "force quotes to csv, default is false" }
    option :col_sep, {  short: "-c ,",
                        long: "--col-sep=,",
                        type: "csv",
                        description: "column separtor for csv, default is \",\"" }
    option :row_sep, {  short: "-r \\n",
                        long: "--row-sep=\\n",
                        type: "csv",
                        description: "row separator for csv, default is \"\\n\"" }
    option :output_path, {  short: "-o n",
                            long: "--out=PATH",
                            description: "output path, default is current directory" }
    option :table, {  short: "-t TABLE",
                      long: "--table=TABLE",
                      description: "MySQL table you want to export" }
    option :pretty, { short: "-y false",
                      long: "--pretty=false",
                      type: "json",
                      description: "display json pretty, default is false" }
    option :json_engine, { short: "-j oj",
                           long: "--json_engine=oj",
                           type: "json",
                           description: "choose json engine" }
    option :help, { long: "--help",
                    description: "Show help",
                    on: :tail,
                    boolean: true }
  end
end
