# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"

RuboCop::RakeTask.new

task :unit_tests do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = "spec/unit/**{,/*/**}/*_spec.rb"
  end
  Rake::Task["spec"].execute
end

task default: %i[unit_tests rubocop]
