# frozen_string_literal: true

require 'rubygems'
require 'bundler'

Bundler.require

require 'sinatra/base'
require 'sequel'

Dotenv.load
Sequel.connect(ENV.fetch('DATABASE_URL'))
Dir.glob('./app/**/*.rb').each { |file| require file }
map('/') { run WelcomeController }
