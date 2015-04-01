source 'https://rubygems.org'

gem 'addressable', git: 'https://github.com/sporkmonger/addressable.git', branch: 'rack-mount'

group :test do
  gem 'simplecov', require: false
  gem 'coveralls', require: false
  gem 'codeclimate-test-reporter', require: false
end

group :test, :development do
  gem 'simplecov-sublime-ruby-coverage', require: false
end

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-rubocop'
end

gemspec
