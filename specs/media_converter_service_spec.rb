require_relative 'spec_helper'

describe 'Media converter Service' do
  include Rack::Test::Methods

  def app
    MediaConverterService
  end

  context "#index" do
    it "Work in progress......" do
      get "/"
      last_response.should be_ok
      last_response.body.should == "Work in progress......"
    end
  end

  context "/start_conversion" do
    it "should convert file to mp3 format" do
      post "/start", {:source => "./test_files/nepali_song.mp4" , :destination => "./converted", :to => "mp3", :options => {"audio_bitrate" => 50}}
      last_response.should be_ok
    end

    it "should convert file to flv format" do
      post "/start", {:source => "./test_files/nepali_song.mp4" , :destination => "./converted", :to => "flv"}
      last_response.should be_ok
    end
  end
end