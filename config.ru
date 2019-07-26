# frozen_string_literal: true

require 'rubygems'
require 'bundler'

Bundler.require

require 'sinatra/base'
require './config/boot'

map('/') { run WelcomeController }
