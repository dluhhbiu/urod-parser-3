# frozen_string_literal: true

require './config/boot' if ARGV.first != 'db:migrate'

Dir.glob('./lib/tasks/*.rake').each { |rake| load rake }
