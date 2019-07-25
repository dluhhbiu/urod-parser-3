# frozen_string_literal: true

require 'dotenv'
require 'sequel'

Dotenv.load
Sequel.connect(ENV.fetch('DATABASE_URL'))
Dir.glob('./app/**/*.rb').each { |file| require file }
Dir.glob('lib/tasks/*.rake').each { |rake| load rake }
