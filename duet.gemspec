# -*- encoding: utf-8 -*-

require File.expand_path('../lib/duet/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "duet"
  gem.version       = Duet::VERSION
  gem.summary       = %q{TODO: Summary}
  gem.description   = %q{TODO: Description}
  gem.license       = "MIT"
  gem.authors       = ["Bob Aman"]
  gem.email         = "bob@sporkmonger.com"
  gem.homepage      = "https://github.com/sporkmonger/duet#readme"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', "~> 1.2"
  gem.add_development_dependency 'metric_fu', ["~> 4.11", ">= 4.11.4"]
  gem.add_development_dependency 'mutant', ["~> 0.7", ">= 0.7.8"]
  gem.add_development_dependency 'mutant-rspec', ["~> 0.7", ">= 0.7.8"]
  gem.add_development_dependency 'rake', "~> 10.0"
  gem.add_development_dependency 'rspec', ["< 3.3.0", ">= 3.0.0"]
  gem.add_development_dependency 'rubygems-tasks', "~> 0.2"
  gem.add_development_dependency 'yard', "~> 0.8"
end
