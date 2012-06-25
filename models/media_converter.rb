require 'rubygems'
require 'streamio-ffmpeg'

class MediaConverter
  include DataMapper::Resource

  timestamps :created_at, :updated_at

  property :id, Serial
  property :source, String, required: true
  property :destination, String, required: true
  property :quality, String, required: true
  property :length, Float,  required: true

  #for vedio
  property :video_codec, Float, :default => "libx264"
  property :video_preset, Float, :default => "medium"
  property :video_min_bitrate, Float, :default => 600
  property :buffer_size, Float, :default => 2000
  property :resolution, :default => "640x480"


  validates_presence_of :source
  validates_presence_of :destination
  validates_presence_of :quality
  validates_presence_of :length


  def initilize(*args)
    FFMPEG::Movie.new(self.source)
  end


  def start_conversion(options)


    options = {:video_codec => "libx264", :frame_rate => 10, :resolution => "320x240", :video_bitrate => 300, :video_bitrate_tolerance => 100,
      :aspect => 1.333333, :keyframe_interval => 90,
      :audio_codec => "libfaac", :audio_bitrate => 32, :audio_sample_rate => 22050, :audio_channels => 1,
      :threads => 2,
      :custom => "-vf crop=60:60:10:10"}
      movie.transcode("movie.mp4", options)

    end

    def progress
      movie.transcode("movie.mp4") { |progress| puts progress }
    end

  end