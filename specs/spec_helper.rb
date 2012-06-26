require './media_converter_service.rb'
require 'rspec'
require 'rack/test'
require 'pry'


settings.environment = :test

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
