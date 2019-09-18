# frozen_string_literal: true

if ARGV.first != 'db:migrate'
  require './config/boot'
  require './config/discord'
end

Dir.glob('./lib/tasks/*.rake').each { |rake| load rake }
