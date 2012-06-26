require './config/database.rb'
require 'sinatra'
require 'pry'
require 'carrierwave'
require 'carrierwave/datamapper'
require './models/media_converter.rb'
require './models/media_uploader.rb'

class MediaConverterService < Sinatra::Base
  #set :environment, :production

  get '/' do
    "Work in progress......"
  end


  post '/start' do
    movie = MediaConverter.new(params)
    converted = movie.start_conversion
  end

end


# @audio_bitrate=37,
# @audio_channels="mono",
# @audio_codec="aac",
# @audio_sample_rate=22050,
# @audio_stream="aac, 22050 Hz, mono, s16, 37 kb/s",
# @bitrate=339,
# @colorspace="yuv420p",
# @dar="1016:765",
# @duration=324.4,
# @path="./converted/nepali_song.mp4",
# @resolution="320x240",
# @time=0.0,
# @uncertain_duration=true,
# @video_bitrate=299,
# @video_codec="mpeg4",