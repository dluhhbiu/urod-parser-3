unless defined?($bot)
  $bot = Discordrb::Bot.new(token: ENV['BOT_TOKEN'])
  $bot.run
end
