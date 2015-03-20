# encoding: utf-8

require 'rubygems'

begin
  require 'bundler/setup'
rescue LoadError => e
  abort e.message
end

require 'rake'

require 'rubygems/tasks'
Gem::Tasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

task :test    => :spec
task :default => :spec

gem_root = File.expand_path(File.dirname(__FILE__))
namespace :metrics do
  require 'rake'
  require 'metric_fu'
  require 'metric_fu/metric'
  require 'metric_fu/run'

  def options_tip(task_name)
    "with options, for example:  rake metrics:#{task_name}['cane: {abc_max: 81}']"
  end

  desc "Generate all metrics reports, or #{options_tip('all')}"
  task :all, [:options] do |_t, args|
    MetricFu.run(process_options(args.options))
  end

  desc "Run only specified ;-separated metrics, for example, metrics:only[cane;flog] or #{options_tip('only')}"
  task :only, [:metrics, :options] do |_t, args|
    requested_metrics = args.metrics.to_s.split(";").map(&:strip)
    enabled_metrics = MetricFu::Metric.enabled_metrics.map(&:name)
    metrics_to_run = enabled_metrics.select { |metric| requested_metrics.include?(metric.to_s) }
    MetricFu.run_only(metrics_to_run, process_options(args.options))
  end

  MetricFu::Metric.enabled_metrics.each do |metric|
    name = metric.name
    desc "Generate report for #{name}, or #{options_tip('cane')}"
    task name, [:options] do |_t, args|
      MetricFu.run_only(name, process_options(args.options))
    end
  end

private

  # from https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/hash/keys.rb
  class Hash
    # Destructively, recursively convert all keys to symbols, as long as they respond
    # to +to_sym+.
    def recursively_symbolize_keys!
      keys.each do |key|
        value = delete(key)
        new_key = key.intern # rescue
        self[new_key] = (value.is_a?(Hash) ? value.dup.recursively_symbolize_keys! : value)
      end
      self
    end
  end

  def process_options(options)
    return {} if options.nil? or options.empty?
    options = YAML.load(options)
    if options.is_a?(Hash)
      p "Got options #{options.recursively_symbolize_keys!.inspect}"
      options
    else
      raise "Invalid options #{options.inspect}, is a #{options.class}, should be a Hash"
    end
  end
end

gem_root = File.expand_path(File.dirname(__FILE__))
namespace :mutant do
  desc 'Run mutant'
  task :coverage do
    require 'mutant'

    # For this specific project 4 threads on CI perform best
    jobs = ENV.key?('CI') ? 4 : Mutant::Config::DEFAULT.jobs

    # Note: Increase your score value once you've actually written tests.
    arguments = %W[
      --use rspec
      --jobs #{jobs}
      --score 0
      --fail-fast
      --include lib
      --require duet
      --
      Duet
    ]

    status = Mutant::CLI.run(arguments)
  end
end

require 'yard'
YARD::Rake::YardocTask.new  
task :doc => :yard
