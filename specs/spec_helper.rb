# require_relative 'spec_helper'
require './application.rb'
require 'rspec'
require 'rack/test'
require 'pry'


RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
