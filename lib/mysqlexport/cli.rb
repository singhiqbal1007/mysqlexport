require "mixlib/cli"

module Mysqlexport
  class Cli
    include ::Mixlib::CLI
    %w[username password host Port database socket].each do |o|
      option o.downcase.to_sym, { short: "-#{o[0, 1]} #{o.upcase}",
                                  long: "--#{o.downcase}=#{o.upcase}",
                                  description: "Set MySQL #{o.downcase}" }
    end
    option :execute, {  short: "-e EXECUTE",
                        long: "--execute=EXECUTE",
                        description: "The SQL statement to execute" }
    option :force_quotes, { short: "-f false",
                            long: "--force-quotes=true",
                            description: "force quotes to csv, default is false" }
    option :col_sep, {  short: "-c ,",
                        long: "--col-sep=,",
                        description: "column separtor for csv, default is \",\"" }
    option :row_sep, {  short: "-r \\n",
                        long: "--row-sep=\\n",
                        description: "row separator for csv, default is \"\\n\"" }
    option :output_path, {  short: "-o n",
                            long: "--out=PATH",
                            description: "output path, default is current directory" }
    option :table, {  short: "-t TABLE",
                      long: "--table=TABLE",
                      description: "MySQL table you want to export" }
    option :help, { long: "--help",
                    description: "Show help",
                    on: :tail,
                    boolean: true,
                    show_options: true,
                    exit: 0 }
  end
end
