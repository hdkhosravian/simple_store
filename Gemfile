# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
gem 'redis-rails'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
# Simple, efficient background processing for Ruby
gem 'sidekiq', '~>6.0.2'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

gem 'devise'
gem 'jwt'
gem 'rails_param'
gem 'jsonapi-rails'

# Upload files in your Ruby applications, map them to a range of ORMs, store them on different backends.
gem 'carrierwave'

# Pundit provides a set of helpers which guide you in leveraging regular Ruby classes and object oriented design patterns to build a simple, robust and scalable authorization system.
gem 'pundit'

# Complete geocoding solution for Ruby
gem 'geocoder'

gem 'acts_as_commentable_with_threading'
gem 'acts-as-taggable-on'
gem 'acts_as_votable'
gem 'kaminari'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i(mri mingw x64_mingw)
  gem 'rspec-rails', '~> 3.9'
  gem 'annotate'
  gem 'faker'
  gem 'factory_bot_rails'
  # Speedup test by running parallel on multiple CPU cores.
  gem 'parallel_tests'
  gem 'ffaker'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-clipboard'
end

group :test do
  gem 'database_cleaner', '~> 1.7'
  gem 'simplecov', require: false
  gem 'shoulda-matchers'
  gem 'pundit-matchers'
  gem 'dox', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', require: false
  gem 'rubocop-performance'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i(mingw mswin x64_mingw jruby)
