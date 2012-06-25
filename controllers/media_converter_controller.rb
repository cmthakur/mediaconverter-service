include './models/media_converter_controller.rb'
require 'pry'
class MediaConverterController

#validates the params that are provided for the media conversion
post '/validate' do
movie = MediaConverter.new(params)
binding.pry

end


#if validation is ok then start conversion of the media
post '/start_conversion' do

end


#when media conversion get completed then let user to doenload the converted files
#if the job is in progress then warn user and notify them about the progresss
get '/converted_files' do

end

#get the progress of the work done
get '/progress' do

end

end