# frozen_string_literal: true

require 'dotenv'
require 'sequel'

Dotenv.load
Sequel.connect(ENV['DATABASE_URL'])
Dir.glob('./app/**/concerns/*.rb').each { |file| require file }
Dir.glob('./app/**/*.rb').each { |file| require file }
