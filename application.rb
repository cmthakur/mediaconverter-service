require './config/database.rb'
require 'sinatra'
require 'pry'

class Application < Sinatra::Base


get "/" do
  binding.pry
 #"Media Converter service work is in progress"
end

post '/validate' do
movie = MediaConverter.new(params)
binding.pry

end


post '/convert' do
  redirect to '/validate'
end

end