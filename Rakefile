# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"
require_relative "spec/benchmarks/run_benchmark"

RuboCop::RakeTask.new

task :unit_tests do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = "spec/unit/**{,/*/**}/*_spec.rb"
  end
  Rake::Task["spec"].execute
end

task :benchmark do
  benchmark = Benchmark::RunBenchmark.new
  benchmark.load_data unless ENV["SKIP_DATA_LOAD"].to_s.downcase == "true"
  puts "Running Benchmarks..."
  benchmark.run
end

task default: %i[unit_tests rubocop]
