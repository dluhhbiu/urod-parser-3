# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.3'

gem 'dotenv', '~>2.7.4'
gem 'httparty', '~>0.17.0'
gem 'nokogiri', '~>1.10.4'
gem 'pg', '~>1.1.4'
gem 'rake', '~>12.3.3'
gem 'sequel', '~>5.21.0'
gem 'sinatra', '~>2.0.5'
gem 'sorbet-runtime'

group :development, :test do
  gem 'awesome_print', '~>1.8.0'
  gem 'byebug', '~>11.0.1'
  gem 'rack-console', '~>1.3.1'
  gem 'rubocop', '~>0.72.0'
  gem 'rubocop-rspec', '~>1.35.0'
end

group :development do
  gem 'sinatra-contrib', '~>2.0.5', require: 'sinatra/reloader'
  gem 'sorbet'
end

group :test do
  gem 'codecov', '~>0.1.14'
  gem 'database_cleaner', '~>1.5.3'
  gem 'factory_bot', '~>5.0.2'
  gem 'faker', '~>2.1.2'
  gem 'rack-test', '~>1.1.0'
  gem 'rspec', '~>3.8.0'
  gem 'simplecov', '~>0.16.1', require: false
  gem 'webmock', '~>3.7.2'
end
