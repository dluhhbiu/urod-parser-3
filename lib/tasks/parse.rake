# frozen_string_literal: true

task :parse_and_send do
  Parser.parse
  threads = []
  threads << Thread.new { Sender::Telegram.send }
  threads << Thread.new { Sender::Discord.send } if $bot&.connected?
  threads.each(&:join) # main thread will wait for it
  Sender.remove_old_news!
end
