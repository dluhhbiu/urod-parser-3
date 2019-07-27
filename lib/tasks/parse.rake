# frozen_string_literal: true

task :parse_and_send do
  Parser.new.parse
  Sender.new.send
end
