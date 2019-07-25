# frozen_string_literal: true

class WelcomeController < ApplicationController
  get '/' do
    erb 'welcome/index'.to_sym
  end
end
