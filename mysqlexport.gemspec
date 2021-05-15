require_relative "lib/mysqlexport/version"

Gem::Specification.new do |spec|
  spec.name          = "mysqlexport"
  spec.version       = Mysqlexport::VERSION
  spec.authors       = ["Iqbal Singh"]
  spec.email         = ["singhiqbal1007@gmail.com"]
  spec.summary       = "Export mysql table to csv files"
  spec.description   = "Gives you binary mysqlexport and Ruby classes to export mysql tables into csv files"
  spec.homepage      = "https://github.com/singhiqbal1007/mysqlexport"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "benchmark", "~> 0.1"
  spec.add_development_dependency "fakefs", "~> 1.3"
  spec.add_development_dependency "pry-nav", "~> 0.3"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.7"
  spec.add_development_dependency "yaml", "~> 0.1"

  spec.add_dependency "activerecord", ">= 6.1.2.1"
  spec.add_dependency "mixlib-cli", "~> 2.1.8"
  spec.add_dependency "multi_json", "~> 1.0"
  spec.add_dependency "mysql2", "~> 0.5.3"
end
