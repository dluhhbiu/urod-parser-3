require 'sinatra/base'

map('/') { run WelcomeController }
