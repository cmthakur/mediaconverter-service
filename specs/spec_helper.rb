require './media_converter_service.rb'
require 'rspec'
require 'rack/test'
require 'pry'


RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
