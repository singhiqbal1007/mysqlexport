# frozen_string_literal: true

require_relative "lib/mysqlexport/version"

Gem::Specification.new do |spec|
  spec.name          = "mysqlexport"
  spec.version       = Mysqlexport::VERSION
  spec.authors       = ["Iqbal Singh"]
  spec.email         = ["singhiqbal1007@gmail.com"]

  spec.summary       = "Export mysql table to csv files"
  spec.description   = "dummy description"
  spec.homepage      = "https://github.com/singhiqbal1007/mysqlexport"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")
  

  #spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.7"

  spec.add_dependency "activerecord", "~> 6.1"
  spec.add_dependency "mixlib-cli", "~> 2.1.8"
  spec.add_dependency "mysql2", "~> 0.5.3"
  spec.add_dependency "yaml", "~> 0.1"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
