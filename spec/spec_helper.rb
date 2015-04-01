require 'rspec'

if ENV['CI'].to_s == 'true'
  require 'coveralls'
  Coveralls.wear! do
    add_filter 'spec/'
  end
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
else
  require 'simplecov'
  require 'simplecov-sublime-ruby-coverage'
  SimpleCov.formatter = SimpleCov::Formatter::SublimeRubyCoverageFormatter
  SimpleCov.start do
    add_filter 'spec/'
  end
end

require 'duet/version'

include Duet
