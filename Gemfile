source "https://rubygems.org"

gemspec

ruby '2.2.2', engine: 'jruby', engine_version: '9.0.4.0'

gem 'rosette-datastore-memory', github: 'rosette-proj/rosette-datastore-memory'

group :development, :test do
  gem 'activemodel', '>= 3.2', '< 5'
  gem 'expert', '~> 1.0'
  gem 'pry-nav'
  gem 'rake'
  gem 'repo-fixture'
end

group :development do
  gem 'yard', '~> 0.8.0'
end

group :test do
  gem 'codeclimate-test-reporter', require: nil
  gem 'simplecov'
  gem 'rspec'
  gem 'rosette-test-helpers', github: 'rosette-proj/rosette-test-helpers'
end
