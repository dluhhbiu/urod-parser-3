# frozen_string_literal: true

require 'sinatra/reloader'

class ApplicationController < Sinatra::Base
  # reload app in dev mode
  configure :development do
    register Sinatra::Reloader
  end

  # set root folder
  set :root, File.expand_path('./app')

  # don't enable logging when running tests
  configure :production, :development do
    enable :logging
  end
end
