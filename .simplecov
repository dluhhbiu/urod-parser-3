# frozen_string_literal: true

SimpleCov.minimum_coverage 100
SimpleCov.start do
  add_filter '/config/'
  add_filter '/db/'
  add_filter '/sorbet/'
  add_filter '/spec/'
  add_filter '/lib/'
  # the file has config blocks witch don't work with text environment
  add_filter '/app/controllers/application_controller.rb'

  add_group 'Controllers', 'app/controllers/'
  add_group 'Models', 'app/models/'
  add_group 'Services', 'app/services/'
end

require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov
