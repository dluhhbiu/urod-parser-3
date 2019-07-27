# frozen_string_literal: true

require 'rubygems'
require 'bundler'

Bundler.require

require './config/boot'

map('/') { run WelcomeController }
