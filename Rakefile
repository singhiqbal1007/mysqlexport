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

namespace :benchmark do
  task :load_data do
    Benchmark::RunBenchmark.new.load_data
  end

  namespace :all do
    task run: ["benchmark:load_data", "benchmark:all:skip_data_load"]
    task :skip_data_load do
      Benchmark::RunBenchmark.new.run_csv
      Benchmark::RunBenchmark.new.run_json
    end
  end

  namespace :csv do
    task run: ["benchmark:load_data", "benchmark:csv:skip_data_load"]
    task :skip_data_load do
      Benchmark::RunBenchmark.new.run_csv
    end
  end

  namespace :json do
    task run: ["benchmark:load_data", "benchmark:json:skip_data_load"]
    task :skip_data_load do
      Benchmark::RunBenchmark.new.run_json
    end
  end
end

task default: %i[unit_tests rubocop]
