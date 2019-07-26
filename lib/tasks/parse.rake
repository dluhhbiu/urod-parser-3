# frozen_string_literal: true

require 'awesome_print'

task :parse_and_send do
  Parser.new.parse
  Sender.new.send
end
