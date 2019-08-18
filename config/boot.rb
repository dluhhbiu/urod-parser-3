# frozen_string_literal: true

require 'sinatra/base'
require 'dotenv'
require 'sequel'

Dotenv.load
Sequel.connect(ENV['DATABASE_URL'])

require './lib/blank'
Dir.glob('./app/**/concerns/*.rb').each { |file| require file }
require './app/controllers/application_controller'
Dir.glob('./app/**/*.rb').each { |file| require file }
