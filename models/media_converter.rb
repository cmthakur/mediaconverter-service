require 'rubygems'
require 'streamio-ffmpeg'
require "./models/media_converter.rb"

class MediaConverter
  include DataMapper::Resource

  timestamps :created_at, :updated_at

  property :id, Serial
  property :source, String, required: true
  property :destination, String, required: true

  property :format, String, required: true
  property :length, Float,  required: true

  #for vedio
  property :video_codec, Float, :default => "libx264"
  property :video_preset, Float, :default => "medium"
  property :video_min_bitrate, Float, :default => 600
  property :buffer_size, Float, :default => 2000
  #property :resolution, :default => "640x480"


  validates_presence_of :source
  validates_presence_of :destination
  validates_presence_of :quality
  validates_presence_of :length


  def initialize(*args)
    conversion_params = args.first
    @source = conversion_params.delete("source")
    @destination = conversion_params.delete("destination")
    @format = conversion_params.delete("to")
    @quality = conversion_params.delete("quality")
    @video_codec = conversion_params.delete("video_codec")
    @video_preset = conversion_params.delete("video_preset")
    @video_min_bitrate = conversion_params.delete("video_min_bitrate")
    @buffer_size = conversion_params.delete("buffer_size")

    begin
      FFMPEG::Movie.new(self.source)
    rescue => e
      raise CustomExceptionError.new("An unexpected error occured #{e}")
    end
  end


  def start_conversion#(conversion_options = nil)
    oignal_file_name = self.source.split("/").last
    ext_less_name = oignal_file_name.split(".").first
    new_file_name = self.format.nil? ? "#{self.destination}/#{ext_less_name}/#{self.format}" : "#{self.destination}/#{oignal_file_name}"

    #default options
    options = {:frame_rate => 10, :resolution => "320x240", :video_bitrate => 300, :video_bitrate_tolerance => 100,
      :aspect => 1.33, :keyframe_interval => 90,
      :audio_codec => "libfaac", :audio_bitrate => 64, :audio_sample_rate => 22050, :audio_channels => 1,
      :threads => 2}


      #options = conversion_options.nil? ? options : conversion_options

      movie = FFMPEG::Movie.new(self.source)
      begin
        movie.transcode(new_file_name, options) { |progress| puts progress.round(2) }
      rescue => e
        raise CustomExceptionError.new("An unexpected error occured \n #{e.message}")
      end


    end
  end