require 'rubygems'
require 'streamio-ffmpeg'
require "./models/media_converter.rb"
require 'carrierwave'
require 'carrierwave/datamapper'

class MediaConverter
  include DataMapper::Resource

  timestamps :created_at, :updated_at

  property :id, Serial
  property :source, String, required: true
  property :destination, String, required: true

  property :format, String, required: true
  #property :duration, Float,  required: true

  #for vedio
  #property :video_codec, String, :default => "libx264"
  #property :video_preset


  # property :video_min_bitrate, Float, :default => 600
  # property :buffer_size, Float, :default => 2000
  # property :audio_bitrate, Float, :default => 50
  # property :audio_channels, Float, :default => 1
  # #property :audio_codec, String, :default => "acc"
  # property :audio_sample_rate, Float, :default => 44100
  # property :resolution, String, :default => "176x144"
  # property :video_bitrate, Float, :default => 220

  validates_presence_of :source
  validates_presence_of :destination

  #for carrierwave you need to mount uploader
  # mount_uploader :source, MediaUploader
  # mount_uploader :destination, MediaUploader


  def initialize(*args)
    conversion_params = args.first
    @source = conversion_params.delete("source")
    @destination = conversion_params.delete("destination")
    @format = conversion_params.delete("to")
    begin
      FFMPEG::Movie.new(self.source)
    rescue => e
      raise CustomExceptionError.new("An unexpected error occured #{e}")
    end
  end


  def start_conversion
    oignal_file_name = self.source.split("/").last
    ext_less_name = oignal_file_name.split(".").first
    new_file_name = self.format.nil? ? "#{self.destination}/#{oignal_file_name}" : "#{self.destination}/#{ext_less_name}.#{self.format}"
    movie = FFMPEG::Movie.new(self.source)
    begin
      movie.transcode(new_file_name, self.media_options) { |progress| puts progress.round(2) } if movie.valid?
      upload_media(new_file_name)
    rescue => e
      raise CustomExceptionError.new("An unexpected error occured \n #{e.message}")
    end
  end


  def upload_media(file_name)
    media = File.open(file_name)
    uploader = MediaUploader.new
    uploader.store!(media)
    `rm -rf #{file_name}`
  end

  def media_options
    all_attributes = self.attributes
    [:destination, :format, :source].each { |k| all_attributes.delete k }
    all_attributes
  end
end